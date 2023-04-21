----------------------------------------------------------------------------
---------------------- Plugins And Their Configurations --------------------
----------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Colorschemes [[[
	{
		"dhananjaylatkar/cscope_maps.nvim",
		config = function()
			require("cscope_maps").setup({
				disable_maps = false, -- true disables my keymaps, only :Cscope will be loaded
				cscope = {
					db_file = "./cscope.out", -- location of cscope db file
				},
			})
		end,
	},
	{
		"Mofiqul/dracula.nvim",
		dependencies = {
			{ "Mofiqul/dracula.nvim", name = "dracula" },
			{ "rose-pine/neovim", name = "rose-pine" },
			{ "EdenEast/nightfox.nvim", name = "nightfox" },
			{ "catppuccin/nvim", name = "catppuccin" },
			{ "ellisonleao/gruvbox.nvim", opts = { contrast = "hard" } },
			{ "navarasu/onedark.nvim", name = "onedark" },
			{ "tiagovla/tokyodark.nvim", name = "tokyodark" },
			{ "Mofiqul/vscode.nvim", name = "vscode" },
			{ "NLKNguyen/papercolor-theme", name = "PaperColor" },
			{ "nyoom-engineering/nyoom.nvim", name = "nyoom" },
			{ "bluz71/vim-nightfly-colors", name = "nightfly" },
			{ "bluz71/vim-moonfly-colors", name = "moonfly" },
			{ "nyoom-engineering/oxocarbon.nvim", name = "carbon" },
		},
		config = function()
			require("nightfox").setup({
				palettes = {
					-- Custom duskfox with black background
					duskfox = {
						bg1 = "#000000", -- Black background
						bg0 = "#1d1d2b", -- Alt backgrounds (floats, statusline, ...)
						bg3 = "#121820", -- 55% darkened from stock
						sel0 = "#131b24", -- 55% darkened from stock
					},
				},
				specs = {
					all = {
						inactive = "bg0", -- Default value for other styles
					},
					duskfox = {
						inactive = "#090909", -- Slightly lighter then black background
					},
				},
				groups = {
					all = {
						NormalNC = { fg = "fg1", bg = "inactive" }, -- Non-current windows
					},
				},
				options = {
					colorblind = {
						enable = true,
						severity = {
							protan = 0.3,
							deutan = 0.6,
						},
					},
				},
			})
			require("vscode").setup({
				transparent = true,
				italic_comments = true,
			})
			require("onedark").setup({
				style = "dark",
				transparent = false,
				term_colors = true,
				toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" },
				colors = {
					bright_orange = "#0f8800", -- define a new color
					green = "#019f0a", -- redefine an existing color
				},
				highlights = {
					TSKeyword = { fg = "$green" },
					TSString = { fg = "$bright_orange", bg = "#00ff00", fmt = "bold" },
					TSFunction = { fg = "#0000ff", sp = "$cyan", fmt = "underline,italic" },
					TSFuncBuiltin = { fg = "#0059ff" },
				},
			})
			vim.opt.background = "dark" -- light

			pcall(vim.cmd.colorscheme, "nightfly")
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
		end,
	},
	-- ]]]
	{ "darrikonn/vim-gofmt" },
	{ "numToStr/Comment.nvim", opts = {} }, -- Comment

	{
		-- telescope: Fuzzy finding and searching interface
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
		config = function()
			require("telescope").setup({})
			require("telescope").load_extension("fzf")
		end,
	},
	{ "nvim-lualine/lualine.nvim", opts = {} },
	{
		-- This section configures LSP + Treesitter + Mason: Treesitter syntax highlighting + Autocompletion + LSP + Auto installing LSP servers
		-- You can copy pase this section in your config and get all IDE like features easily
		-- For keybindindings check bottom of this file
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter",
				dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", "nvim-treesitter/playground" },
			},
			{ "williamboman/mason.nvim", dependencies = { "williamboman/mason-lspconfig.nvim" } },
			"folke/neodev.nvim",
			{
				"hrsh7th/nvim-cmp", -- Autocompletion popup
				dependencies = {
					"hrsh7th/cmp-nvim-lsp",
					"hrsh7th/cmp-vsnip",
					"hrsh7th/vim-vsnip",
					"hrsh7th/cmp-path",
					"hrsh7th/cmp-buffer",
				},
			},
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "json", "yaml", "c", "cpp", "lua", "rust", "go", "python", "php" },
				context_commentstring = { enable = true },
				highlight = { enable = true },
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
				},
			})
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
			require("mason").setup({})
			for _, pkg in ipairs({ "stylua", "golangci-lint", "goimports", "yamlfmt" }) do -- ensure these tools are installed
				if not require("mason-registry").is_installed(pkg) then
					require("mason.api.command").MasonInstall({ pkg })
				end
			end

			local mason_lspconfig = require("mason-lspconfig")
			local lsp_servers = {
				gopls = {},
				lua_ls = {
					Lua = {
						telemetry = { enable = false },
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							checkThirdParty = false,
							library = vim.api.nvim_get_runtime_file("", true),
						},
					},
				},
				rust_analyzer = {},
				-- zls = {},
			}

			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(lsp_servers),
			})

			mason_lspconfig.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						settings = lsp_servers[server_name],
						handlers = {
							["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
							["textDocument/signatureHelp"] = vim.lsp.with(
								vim.lsp.handlers.signature_help,
								{ border = "rounded" }
							),
						},
					})
				end,
			})

			-- Auto format
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = { "*.rs", "*.lua" },
				callback = function(_)
					vim.lsp.buf.format()
				end,
			})
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				},
			})
			require("null-ls").setup({
				sources = {
					require("null-ls").builtins.code_actions.gitsigns,
					require("null-ls").builtins.diagnostics.golangci_lint,
					require("null-ls").builtins.diagnostics.trail_space.with({
						disabled_filetypes = { "NvimTree" },
					}),
					require("null-ls").builtins.formatting.stylua,
					require("null-ls").builtins.formatting.goimports,
				},
			})
		end,
	},

	{ "stevearc/oil.nvim", opt = {} }, -- File manager like a BOSS
	{ "pbrisbin/vim-mkdir" }, -- Automatically create directory if not exists
	{ "fladson/vim-kitty" }, -- Support Kitty terminal config syntax
	{ "towolf/vim-helm" }, -- Support for helm template syntax
	{ "tpope/vim-surround" }, -- surrounding text objects
	{ "kevinhwang91/nvim-bqf" }, -- Preview quickfix list item.
	{ "tpope/vim-eunuch" }, -- Helper commands like :Rename, :Move, :Delete, :Remove, ...
	{ "tpope/vim-sleuth" }, -- Heuristically set buffer options
	{ "windwp/nvim-autopairs" }, -- Auto insert pairs like () [] {}
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	}, -- Signs next to line numbers to show git status of a line
	{
		"tpope/vim-fugitive",
		config = function()
			vim.api.nvim_create_user_command("Gp", function(_, _)
				vim.cmd.Git("push")
			end, {})
		end,
	}, -- Best Git Client after magit :)
	{ "dag/vim-fish" }, -- Vim fish syntax
	{ "jansedivy/jai.vim" }, -- Jai from Jonathan Blow
	{
		"akinsho/toggleterm.nvim",
		config = function(_, _)
			require("toggleterm").setup({
				size = 20,
				direction = "horizontal",
			})
		end,
	},
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-lua/lsp_extensions.nvim" },
	{
		-- simrat39 START
		"simrat39/rust-tools.nvim",
		config = function()
			local rt = require("rust-tools")
			local opts = {
				tools = {
					-- rust-tools options

					-- how to execute terminal commands
					-- options right now: termopen / quickfix
					executor = require("rust-tools.executors").termopen,
					-- callback to execute once rust-analyzer is done initializing the workspace
					-- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
					on_initialized = nil,
					-- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
					reload_workspace_from_cargo_toml = true,
					-- These apply to the default RustSetInlayHints command
					inlay_hints = {
						-- automatically set inlay hints (type hints)
						-- default: true
						auto = true,
						-- Only show inlay hints for the current line
						only_current_line = false,
						-- whether to show parameter hints with the inlay hints or not
						-- default: true
						show_parameter_hints = true,
						-- prefix for parameter hints
						-- default: "<-"
						parameter_hints_prefix = "<- ",
						-- prefix for all the other hints (type, chaining)
						-- default: "=>"
						other_hints_prefix = "=> ",
						-- whether to align to the length of the longest line in the file
						max_len_align = false,
						-- padding from the left if max_len_align is true
						max_len_align_padding = 1,
						-- whether to align to the extreme right or not
						right_align = false,
						-- padding from the right if right_align is true
						right_align_padding = 7,
						-- The color of the hints
						highlight = "Comment",
					},
					-- options same as lsp hover / vim.lsp.util.open_floating_preview()
					hover_actions = {
						-- the border that is used for the hover window
						-- see vim.api.nvim_open_win()
						border = {
							{ "╭", "FloatBorder" },
							{ "─", "FloatBorder" },
							{ "╮", "FloatBorder" },
							{ "│", "FloatBorder" },
							{ "╯", "FloatBorder" },
							{ "─", "FloatBorder" },
							{ "╰", "FloatBorder" },
							{ "│", "FloatBorder" },
						},
						-- Maximal width of the hover window. Nil means no max.
						max_width = nil,
						-- Maximal height of the hover window. Nil means no max.
						max_height = nil,
						-- whether the hover action window gets automatically focused
						-- default: false
						auto_focus = false,
					},
					-- settings for showing the crate graph based on graphviz and the dot
					-- command
					crate_graph = {
						-- Backend used for displaying the graph
						-- see: https://graphviz.org/docs/outputs/
						-- default: x11
						backend = "x11",
						-- where to store the output, nil for no output stored (relative
						-- path from pwd)
						-- default: nil
						output = nil,
						-- true for all crates.io and external crates, false only the local
						-- crates
						-- default: true
						full = true,
						-- List of backends found on: https://graphviz.org/docs/outputs/
						-- Is used for input validation and autocompletion
						-- Last updated: 2021-08-26
						enabled_graphviz_backends = {
							"bmp",
							"cgimage",
							"canon",
							"dot",
							"gv",
							"xdot",
							"xdot1.2",
							"xdot1.4",
							"eps",
							"exr",
							"fig",
							"gd",
							"gd2",
							"gif",
							"gtk",
							"ico",
							"cmap",
							"ismap",
							"imap",
							"cmapx",
							"imap_np",
							"cmapx_np",
							"jpg",
							"jpeg",
							"jpe",
							"jp2",
							"json",
							"json0",
							"dot_json",
							"xdot_json",
							"pdf",
							"pic",
							"pct",
							"pict",
							"plain",
							"plain-ext",
							"png",
							"pov",
							"ps",
							"ps2",
							"psd",
							"sgi",
							"svg",
							"svgz",
							"tga",
							"tiff",
							"tif",
							"tk",
							"vml",
							"vmlz",
							"wbmp",
							"webp",
							"xlib",
							"x11",
						},
					},
				},
				-- all the opts to send to nvim-lspconfig
				-- these override the defaults set by rust-tools.nvim
				-- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
				server = {
					-- standalone file support
					-- setting it to false may improve startup time
					standalone = true,
				}, -- rust-analyzer options
				-- debugging stuff
				dap = {
					adapter = {
						type = "executable",
						command = "lldb-vscode",
						name = "rt_lldb",
					},
				},
			} -- opts set

			rt.setup(opts)
			-- 	rt.setup({
			-- 		server = {
			-- 			on_attach = function(_, bufnr)
			-- 				vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
			-- 				vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
			-- 			end,
			-- 		},
			-- 	})
		end,
	}, -- simrat39 END
})

-- ==========================================================================
-- ============================ Options ====================================
-- ==========================================================================
vim.opt.number = true -- Line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.errorbells = false
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.guicursor = ""
vim.opt.shortmess:append("c") -- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append("I") -- No Intro message
vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register.
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.cursorline = true
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.cmd([[
	set autoindent
	set expandtab
	set shiftwidth=2
	set smartindent
	set softtabstop=4
	set tabstop=4
]])
-- ==========================================================================
-- ========================= Keybindings ====================================
-- ==========================================================================
vim.g.mapleader = "+"
local bind = vim.keymap.set
-- Editing
bind("t", "<Esc>", "<C-\\><C-n>")
bind("t", "jk", "<C-\\><C-n>")
bind("t", "kj", "<C-\\><C-n>")
bind("i", "jk", "<esc>")
bind("i", "kj", "<esc>")
bind("n", "Y", "y$")
-- Window management
bind("n", "<leader>v", "<cmd>vsplit<CR>")
bind("n", "<leader>h", "<cmd>split<CR>")
bind("n", "<C-h>", "<cmd>wincmd h<CR>")
bind("n", "<C-j>", "<cmd>wincmd j<CR>")
bind("n", "<C-k>", "<cmd>wincmd k<CR>")
bind("n", "<C-l>", "<cmd>wincmd l<CR>")
bind("n", "<A-l>", "<C-w><")
bind("n", "<A-h>", "<C-w>>")
bind("n", "<A-j>", "<C-w>-")
bind("n", "<A-k>", "<C-w>+")
bind("t", "<A-l>", "<C-\\><C-n><C-w><")
bind("t", "<A-h>", "<C-\\><C-n><C-w>>")
bind("t", "<A-j>", "<C-\\><C-n><C-w>-")
bind("t", "<A-k>", "<C-\\><C-n><C-w>+")
-- Git
bind("n", "<leader>gs", vim.cmd.Git)
bind("n", "<leader>b", function()
	require("gitsigns").blame_line({ full = true })
end)
bind("n", "<leader>d", function()
	require("gitsigns").diffthis("~")
end)
-- Navigation
local no_preview = { previewer = false }
bind("n", "<C-d>", "<C-d>zz")
bind("n", "<C-u>", "<C-u>zz")
bind("n", "<leader><leader>", function()
	require("telescope.builtin").git_files(no_preview)
end)
bind("n", "<leader>ff", function()
	require("telescope.builtin").find_files(no_preview)
end)
bind("n", "<C-p>", function()
	require("telescope.builtin").git_files(no_preview)
end)
bind("n", "<M-p>", function()
	require("telescope.builtin").git_files(no_preview)
end)
bind("n", "<leader>k", function()
	require("telescope.builtin").current_buffer_fuzzy_find(no_preview)
end)
bind("n", "<leader>o", function()
	require("telescope.builtin").treesitter(no_preview)
end)
bind("n", "??", function()
	require("telescope.builtin").live_grep()
end)
bind("n", "Q", "<NOP>")
bind("n", "{", ":cprev<CR>")
bind("n", "}", ":cnext<CR>")
bind("n", "n", "nzz")
bind("n", "N", "Nzz")
bind("n", "<CR>", [[ {-> v:hlsearch ? ':nohl<CR>' : '<CR>'}() ]], { expr = true })
bind("n", "<leader>j", "<cmd>ToggleTerm<CR>")
bind("n", "<C-[>", "<C-t>")
bind("n", "<C-]>", "<C-]>")
bind("n", "<leader>?", ":RustEnableInlayHints<Esc>")
bind("n", "<leader>x", ":RustDisableInlayHints<Esc>")
bind("n", "<leader>s", ":lua require('lsp_extensions').inlay_hints()<Esc>", { buffer = 0 })
-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
		local buffer = { buffer = bufnr }
		bind("n", "gd", vim.lsp.buf.definition, buffer)
		bind("n", "gD", vim.lsp.buf.declaration, buffer)
		bind("n", "gi", vim.lsp.buf.implementation, buffer)
		bind("n", "gr", vim.lsp.buf.references, buffer)
		bind("n", "R", vim.lsp.buf.rename, buffer)
		bind("n", "K", vim.lsp.buf.hover, buffer)
		bind("n", "gf", vim.lsp.buf.format, buffer)
		bind("n", "gl", vim.diagnostic.open_float, buffer)
		bind("n", "gp", vim.diagnostic.goto_prev, buffer)
		bind("n", "gn", vim.diagnostic.goto_next, buffer)
		bind("n", "C", vim.lsp.buf.code_action, buffer)
		bind("n", "<C-s>", vim.lsp.buf.signature_help, buffer)
		bind("i", "<C-s>", vim.lsp.buf.signature_help, buffer)
		bind("n", "<leader>o", function()
			require("telescope.builtin").lsp_document_symbols(no_preview)
		end, buffer)
	end,
})
vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
require("cscope_maps").setup({ db_file = "./cscope.out" })

-- require("lsp-inlayhints").toggle()
-- vim.g.tokyodark.tokyodark_transparent_background = true
-- vim.g.tokyodark.tokyodark_enable_italic_comment = true
-- vim.g.tokyodark.tokyodark_enable_italic = true
-- vim.g.tokyodark_color_gamma = "1.0"
local n_keymap = function(lhs, rhs)
	vim.api.nvim_set_keymap("n", lhs, rhs, { noremap = true, silent = true })
	vim.api.nvim_set_keymap("t", lhs, rhs, { noremap = true, silent = true })
end

n_keymap("<esc>", "<esc>")
