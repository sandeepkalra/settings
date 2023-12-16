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
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				-- your personnal icons can go here (to override)
				-- you can specify color or cterm_color instead of specifying both of them
				-- DevIcon will be appended to `name`
				override = {
					zsh = {
						icon = "",
						color = "#428850",
						cterm_color = "65",
						name = "Zsh",
					},
				},
				-- globally enable different highlight colors per icon (default to true)
				-- if set to false all icons will have the default icon's color
				color_icons = true,
				-- globally enable default icons (default to false)
				-- will get overriden by `get_icons` option
				default = true,
				-- globally enable "strict" selection of icons - icon will be looked up in
				-- different tables, first by filename, and if not found by extension; this
				-- prevents cases when file doesn't have any extension but still gets some icon
				-- because its name happened to match some extension (default to false)
				strict = true,
				-- same as `override` but specifically for overrides by filename
				-- takes effect when `strict` is true
				override_by_filename = {
					[".gitignore"] = {
						icon = "",
						color = "#f1502f",
						name = "Gitignore",
					},
				},
				-- same as `override` but specifically for overrides by extension
				-- takes effect when `strict` is true
				override_by_extension = {
					["log"] = {
						icon = "",
						color = "#81e043",
						name = "Log",
					},
				},
			})
			require("nvim-web-devicons").has_loaded()
			require("nvim-web-devicons").get_icons()
			require("nvim-web-devicons").set_default_icon("", "#6d8086", 65)
			require("nvim-web-devicons").get_icon_by_filetype(filetype, opts)
			require("nvim-web-devicons").get_icon_colors_by_filetype(filetype, opts)
			require("nvim-web-devicons").get_icon_color_by_filetype(filetype, opts)
			require("nvim-web-devicons").get_icon_cterm_color_by_filetype(filetype, opts)
		end,
	},
	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",

			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",

			-- Adds a number of user-friendly snippets
			"rafamadriz/friendly-snippets",
		},
	},
	{ "folke/which-key.nvim",  opts = {} },
	{
		"nvim-lualine/lualine.nvim",
	},
	{
		"akinsho/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		config = true,
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				sort_by = "case_sensitive",
				view = {
					width = 30,
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = true,
				},
			})
		end,
	},
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
			{ "AlexvZyl/nordic.nvim",             name = "nordic" },
			{ "felipeagc/fleet-theme-nvim",       name = "fleet" },
			{ "cpea2506/one_monokai.nvim",        name = "one_monokai" },
			{ "Mofiqul/dracula.nvim",             name = "dracula" },
			{ "rose-pine/neovim",                 name = "rose-pine" },
			{ "EdenEast/nightfox.nvim",           name = "nightfox" },
			{ "catppuccin/nvim",                  name = "catppuccin" },
			{ "ellisonleao/gruvbox.nvim",         opts = { contrast = "hard" } },
			{ "navarasu/onedark.nvim",            name = "onedark" },
			{ "tiagovla/tokyodark.nvim",          name = "tokyodark" },
			{ "Mofiqul/vscode.nvim",              name = "vscode" },
			{ "NLKNguyen/papercolor-theme",       name = "PaperColor" },
			{ "nyoom-engineering/nyoom.nvim",     name = "nyoom" },
			{ "bluz71/vim-nightfly-colors",       name = "nightfly" },
			{ "bluz71/vim-moonfly-colors",        name = "moonfly" },
			{ "nyoom-engineering/oxocarbon.nvim", name = "carbon" },
			{ "louisboilard/pyramid.nvim",        name = "pyramid" },
		},
		config = function()
			vim.opt.background = "dark" -- light
			require("nordic").setup({
				on_palette = function(palette)
					return palette
				end,
				bold_keywords = false,
				-- Enable italic comments.
				italic_comments = true,
				-- Enable general editor background transparency.
				transparent_bg = true,
				-- Enable brighter float border.
				bright_border = true,
				-- Reduce the overall amount of blue in the theme (diverges from base Nord).
				reduced_blue = true,
				-- Swap the dark background with the normal one.
				swap_backgrounds = false,
				-- Override the styling of any highlight group.
				override = {},
				-- Cursorline options.  Also includes visual/selection.
				cursorline = {
					-- Bold font in cursorline.
					bold = false,
					-- Bold cursorline number.
					bold_number = true,
					-- Avialable styles: 'dark', 'light'.
					theme = "light",
					-- Blending the cursorline bg with the buffer bg.
					blend = 0.3,
				},
				noice = {
					-- Available styles: `classic`, `flat`.
					style = "flat",
				},
				telescope = {
					-- Available styles: `classic`, `flat`.
					style = "flat",
				},
				leap = {
					-- Dims the backdrop when using leap.
					dim_backdrop = true,
				},
				ts_context = {
					-- Enables dark background for treesitter-context window
					dark_background = true,
				},
			})

			require("rose-pine").setup({
				italics = false, -- disable italics
				transparent = true, -- enable transparent window
			})
			require("gruvbox").setup({
				transparent = true, -- enable transparent window
			})
			require("one_monokai").setup({
				transparent = true, -- enable transparent window
				colors = {
					lmao = "#000000", -- add new color
					whitey = "#fff5f8", -- some white variant
					pink = "#ec6075", -- replace default color
				},
				themes = function(colors)
					-- change highlight of some groups,
					-- the key and value will be passed respectively to "nvim_set_hl"
					return {
						Normal = { bg = colors.lmao, fg = colors.whitey },
						Identifier = { fg = colors.pink:lighten(0.8) },
						Function = { fg = colors.peanut },
						Macro = { fg = colors.whitey:lighten(0.8) },
						PreProc = { fg = colors.whitey:lighten(0.8) },
						String = { fg = colors.cyan:lighten(0.5) },
						DiffChange = { fg = colors.whitey:lighten(0.1) }, -- other option is :darken()
						Comment = { fg = colors.gray:lighten(0.7) },
						CursorLineNr = { fg = colors.peanut },
						LineNr = { fg = colors.dark_gray },
						Nontext = { fg = colors.white },
						ErrorMsg = { fg = colors.pink, standout = true },
						["@lsp.type.keyword"] = { link = "@keyword" },
					}
				end,
				italics = false, -- disable italics
			})

			require("nightfox").setup({
				palettes = {
					-- Custom duskfox with black background
					duskfox = {
						bg1 = "#000000", -- Black background
						bg0 = "#1d1d2b", -- Alt backgrounds (floats, statusline, ...)
						bg3 = "#121820", -- 55% darkened from stock
						sel0 = "#231b24", -- 55% darkened from stock
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
				transparent = true,
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

			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
			pcall(vim.cmd.colorscheme, "nordic")
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
	{
		-- This section configures LSP + Treesitter + Mason: Treesitter syntax highlighting + Autocompletion + LSP + Auto installing LSP servers
		-- You can copy pase this section in your config and get all IDE like features easily
		-- For keybindindings check bottom of this file
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter",
				dependencies = {
					"nvim-treesitter/nvim-treesitter-textobjects",
					"nvim-treesitter/playground",
					"williamboman/mason.nvim",
					"williamboman/mason-lspconfig.nvim",
					-- Additional lua configuration, makes nvim stuff amazing!
					"folke/neodev.nvim",
					{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },
				},
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
					--				["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					-- Add tab support
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					}),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "vsnip" },
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

	{ "stevearc/oil.nvim",    opt = {} }, -- File manager like a BOSS
	{ "pbrisbin/vim-mkdir" },       -- Automatically create directory if not exists
	{ "fladson/vim-kitty" },        -- Support Kitty terminal config syntax
	{ "towolf/vim-helm" },          -- Support for helm template syntax
	{ "tpope/vim-surround" },       -- surrounding text objects
	{ "kevinhwang91/nvim-bqf" },    -- Preview quickfix list item.
	{ "tpope/vim-eunuch" },         -- Helper commands like :Rename, :Move, :Delete, :Remove, ...
	{ "tpope/vim-sleuth" },         -- Heuristically set buffer options
	{ "windwp/nvim-autopairs" },    -- Auto insert pairs like () [] {}
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
	},                    -- Best Git Client after magit :)
	{ "dag/vim-fish" },   -- Vim fish syntax
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
	{ "rust-lang/rust.vim" },
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
vim.opt.number = true         -- Line numbers
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
vim.opt.shortmess:append("c")           -- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append("I")           -- No Intro message
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
vim.g.mapleader = "\\"
vim.g.maplocalleader = " "
local bind = vim.keymap.set
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sG", ":LiveGrepGitRoot<cr>", { desc = "[S]earch by [G]rep on Git Root" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })

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
bind("n", "<leader>o", function() -- open treesitter
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
		bind("n", "<leader>s", function() -- symbol
			require("telescope.builtin").lsp_document_symbols(no_preview)
		end, buffer)
	end,
})
-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
	},
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
	-- Use the current buffer's path as the starting point for the git search
	local current_file = vim.api.nvim_buf_get_name(0)
	local current_dir
	local cwd = vim.fn.getcwd()
	-- If the buffer is not associated with a file, return nil
	if current_file == "" then
		current_dir = cwd
	else
		-- Extract the directory from the current file's path
		current_dir = vim.fn.fnamemodify(current_file, ":h")
	end

	-- Find the Git root directory from the current file's path
	local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
	if vim.v.shell_error ~= 0 then
		print("Not a git repository. Searching on current working directory")
		return cwd
	end
	return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
	local git_root = find_git_root()
	if git_root then
		require("telescope.builtin").live_grep({
			search_dirs = { git_root },
		})
	end
end

vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})
-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
	nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end

-- document existing key chains
require("which-key").register({
	["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
	["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
	["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
	["<leader>h"] = { name = "More git", _ = "which_key_ignore" },
	["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
	["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
	["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
})

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require("mason").setup()
require("mason-lspconfig").setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
	-- clangd = {},
	-- gopls = {},
	-- pyright = {},
	-- rust_analyzer = {},
	-- tsserver = {},
	-- html = { filetypes = { 'html', 'twig', 'hbs'} },

	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		})
	end,
})

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})

-- further customization by sandeep kalra here --
local bind = vim.keymap.set
bind("n", "“", "<C-t>")
bind("n", "‘", "<C-]>")
bind("n", "<leader>v", "<cmd>vsplit<CR>")
bind("n", "<leader>h", "<cmd>split<CR>")
bind("n", "<C-h>", "<cmd>wincmd h<CR>")
bind("n", "<leader>t", ":NvimTreeToggle<Esc>")
bind("n", "<C-j>", "<cmd>wincmd j<CR>")
bind("n", "<C-k>", "<cmd>wincmd k<CR>")
bind("n", "<C-l>", "<cmd>wincmd l<CR>")
--
--
--
--
vim.g.PaperColor_Theme_Options = {
	theme = {
		["default"] = {
			transparent_background = 1,
		},
		["default.dark"] = {
			override = {
				cursor_fg = { "#1c1c1c", "234" },
				cursor_bg = { "#c6c6c6", "251" },
			},
		},
	},
}

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
	require("nvim-treesitter.configs").setup({
		-- Add languages to be installed here that you want installed for treesitter
		ensure_installed = {
			"c",
			"cpp",
			"go",
			"lua",
			"python",
			"rust",
			"tsx",
			"javascript",
			"typescript",
			"vimdoc",
			"vim",
			"bash",
		},

		-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
		auto_install = false,

		highlight = { enable = true },
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<c-space>",
				node_incremental = "<c-space>",
				scope_incremental = "<c-s>",
				node_decremental = "<M-space>",
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},
			swap = {
				enable = true,
				swap_next = {
					["<leader>a"] = "@parameter.inner",
				},
				swap_previous = {
					["<leader>A"] = "@parameter.inner",
				},
			},
		},
	})
end, 0)

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
	nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end

-- document existing key chains
require("which-key").register({
	["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
	["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
	["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
	["<leader>h"] = { name = "More git", _ = "which_key_ignore" },
	["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
	["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
	["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
})

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require("mason").setup()
require("mason-lspconfig").setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
	-- clangd = {},
	-- gopls = {},
	-- pyright = {},
	-- rust_analyzer = {},
	-- tsserver = {},
	-- html = { filetypes = { 'html', 'twig', 'hbs'} },

	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		})
	end,
})

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})

-- further customization by sandeep kalra here --
local bind = vim.keymap.set
bind("n", "“", "<C-t>")
bind("n", "‘", "<C-]>")
bind("n", "<leader>v", "<cmd>vsplit<CR>")
bind("n", "<leader>h", "<cmd>split<CR>")
bind("n", "<C-h>", "<cmd>wincmd h<CR>")
bind("n", "<leader>t", ":NvimTreeToggle<Esc>")
bind("n", "<C-j>", "<cmd>wincmd j<CR>")
bind("n", "<C-k>", "<cmd>wincmd k<CR>")
bind("n", "<C-l>", "<cmd>wincmd l<CR>")
--
--
--
--
vim.g.PaperColor_Theme_Options = {
	theme = {
		["default"] = {
			transparent_background = 1,
		},
		["default.dark"] = {
			override = {
				cursor_fg = { "#1c1c1c", "234" },
				cursor_bg = { "#c6c6c6", "251" },
			},
		},
	},
}

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sG", ":LiveGrepGitRoot<cr>", { desc = "[S]earch by [G]rep on Git Root" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })

vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("lualine").setup({ theme = "PaperColor" })
require("cscope_maps").setup({ db_file = "./cscope.out" })
vim.g.PaperColor_Theme_Options = {
	theme = {
		["default"] = {
			transparent_background = 1,
		},
		--	["default.dark"] = {
		--		override = {
		--			cursor_fg = { "#1c1c1c", "234" },
		--			cursor_bg = { "#c6c6c6", "251" },
		--		},
		--	},
	},
}
-- Sets colors to line numbers Above, Current and Below  in this order
function LineNumberColors()
	vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#51B3EC", bold = true })
	vim.api.nvim_set_hl(0, "LineNr", { fg = "white", bold = true })
	vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#FB508F", bold = true })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "white" })
end

bind("n", "<leader>t", ":NvimTreeToggle<Esc>")
bind("n", "“", "<C-t>")
bind("n", "‘", "<C-]>")
-- pcall(vim.cmd.colorscheme, "PaperColor")
pcall(vim.cmd.colorscheme, "nordic")
LineNumberColors()
