local minimal = true
if os.getenv("MINIMAL") == "true" then
	minimal = false
end

return {
	-- Dependencies
	"nvim-tree/nvim-web-devicons",
	"nvim-lua/plenary.nvim",
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
	-- Colors
	-- {
	-- 	"victornswd/base46",
	-- 	config = function()
	-- 		require("colors")
	-- 	end,
	-- },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		opts = function()
			return {
				flavour = "frappe",
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					telescope = true,
					mini = true,
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
					native_lsp = {
						enabled = true,
						underlines = {
							errors = { "undercurl" },
							hints = { "undercurl" },
							warnings = { "undercurl" },
							information = { "undercurl" },
						},
					},
				},
				custom_highlights = function(colors)
					return {
						SpecsHL = { bg = colors.text },
						MiniTablineFill = { bg = colors.crust },
						MiniTablineCurrent = { fg = colors.text, bg = colors.mantle, style = {} },
						MiniTablineModifiedCurrent = { fg = colors.mauve, bg = colors.mantle },
						MiniTablineModifiedHidden = { fg = colors.mauve, bg = colors.surface0 },
						MiniTablineVisible = { fg = colors.overlay0, bg = colors.surface0 },
						MiniTablineHidden = { fg = colors.overlay0, bg = colors.surface0 },
						-- MatchParen = { bg = colors.surface1 },
						markdownTSTitle = { bold = true, fg = colors.green },
						TSPunctSpecial = { bold = true, fg = colors.green },
						-- QuickFixLine = { bg = colors.mantle },
						IndentBlanklineChar = { fg = colors.surface2 },
						IndentBlanklineContextChar = { fg = colors.mauve },
						TelescopePromptPrefix = { bg = colors.crust },
						TelescopePromptNormal = { bg = colors.crust },
						TelescopeResultsNormal = { bg = colors.mantle },
						TelescopePreviewNormal = { bg = colors.crust },
						TelescopePromptBorder = { bg = colors.crust, fg = colors.crust },
						TelescopeResultsBorder = { bg = colors.mantle, fg = colors.crust },
						TelescopePreviewBorder = { bg = colors.crust, fg = colors.crust },
						TelescopePromptTitle = { fg = colors.crust, bg = colors.green },
						TelescopeResultsTitle = { fg = colors.text, bg = colors.red },
						TelescopePreviewTitle = { fg = colors.crust, bg = colors.sapphire },
						ConflictDiffAdd = { fg = colors.text, bg = "#214b45" },
						ConflictDiffText = { fg = colors.text, bg = "#7229a0" },
					}
				end,
			}
		end,
		config = function(_, opts)
			require("catppuccin").setup(opts)
		end,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("config.treesitter")
		end,
		build = ":TSUpdate",
		event = "VeryLazy",
	},
	{
		"nvim-treesitter/playground",
		cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor", "TSNodeUnderCursor" },
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "VeryLazy",
		config = function()
			-- This module contains a number of default definitions
			local rainbow_delimiters = require("rainbow-delimiters")

			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					commonlisp = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
				blacklist = { "c", "cpp" },
			}
		end,
	}, -- NOTE:
	{
		"andymass/vim-matchup",
		config = function()
			vim.g.matchup_matchparen_offscreen = {}
		end,
		event = "VeryLazy",
	}, -- NOTE:
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
		event = "BufReadPost",
	},
	{
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true,
		event = "VeryLazy",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("treesitter-context").setup({
				max_lines = 2, -- How many lines the window should span. Values <= 0 mean no limit.
			})
		end,
		event = "VeryLazy",
	},

	-- Dev helpers (documentation, pickers, editor config, etc)
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("config.telescope")
		end,
		dependencies = {
			{
				{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
				"nvim-lua/plenary.nvim",
				"debugloop/telescope-undo.nvim",
			},
		},
		event = "VeryLazy",
		cond = minimal,
	},
	{
		"danymat/neogen",
		config = function()
			require("neogen").setup({ snippet_engine = "luasnip" })

			vim.keymap.set("n", "<leader>dd", function()
				pcall(require("neogen").generate)
			end, { desc = "Generate function documentation" })
		end,
		dependencies = "nvim-treesitter/nvim-treesitter",
		keys = "<Leader>dd",
		cond = minimal,
	},
	{
		"vimwiki/vimwiki",
		branch = "dev",
		event = "VeryLazy",
		init = function()
			vim.g.vimwiki_list = {
				{
					path = "~/Dropbox/wiki/",
					syntax = "markdown",
					ext = ".md",
				},
			}
			vim.g.vimwiki_global_ext = 0
		end,
		config = function()
			local vimwiki_gr = vim.api.nvim_create_augroup("VimWikiGroup", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					vim.opt_local.filetype = "markdown"
				end,
				group = vimwiki_gr,
				pattern = "vimwiki",
			})
			vim.api.nvim_create_autocmd("BufEnter", {
				callback = function()
					vim.opt_local.syntax = "markdown"
				end,
				group = vimwiki_gr,
				pattern = "~/Dropbox/wiki/*.md",
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("config.lualine")
		end,
		event = "VeryLazy",
	},
	{
		"j-hui/fidget.nvim",
		config = true,
		branch = "legacy",
		event = "VeryLazy",
	},

	-- UI flourishes
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("ibl").setup({
				indent = { char = "│", tab_char = "│" },
				scope = { highlight = "IndentBlanklineContextChar", char = "│" },
			})
		end,
		event = "VeryLazy",
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("config.colorizer")
		end,
		ft = { "css", "javascript", "vim", "html", "lua", "typescript", "typescriptreact", "react", "astro" },
	},
	require("config.git"),
	{
		"edluffy/specs.nvim",
		config = function()
			require("specs").setup({
				show_jumps = true,
				min_jump = 5,
				popup = {
					delay_ms = 0, -- delay before popup displays
					inc_ms = 10, -- time increments used for fade/resize effects
					blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
					width = 10,
					winhl = "SpecsHL",
					fader = require("specs").linear_fader,
					resizer = require("specs").shrink_resizer,
				},
				ignore_filetypes = {},
				ignore_buftypes = {
					nofile = true,
				},
			})
		end,
		event = "VeryLazy",
		cond = minimal,
	},

	-- DX flourishes
	{ "ThePrimeagen/harpoon", dependencies = "nvim-lua/plenary.nvim" },
	{
		"ojroques/nvim-bufdel",
		config = function()
			vim.cmd([[
				:cnoreabbrev wq w ++p<bar>BufDel
				:cnoreabbrev q BufDel
			]])
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		opt = true,
		cond = minimal,
	},
	-- mini.nvim
	{
		"echasnovski/mini.ai",
		event = "BufReadPre",
		config = function()
			local ai = require("mini.ai")
			ai.setup({
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
				},
			})
		end,
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
				end,
			},
		},
	},
	{
		"echasnovski/mini.align",
		event = "BufReadPre",
		config = true,
	},
	{
		"echasnovski/mini.bracketed",
		event = "BufReadPre",
		config = true,
	},
	{
		"echasnovski/mini.comment",
		event = "BufReadPre",
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
		},
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
	},
	{
		"echasnovski/mini.move",
		event = "BufReadPre",
		opts = {
			mappings = {
				down = "J",
				up = "K",
				line_down = "J",
				line_up = "K",
			},
		},
	},
	{
		"echasnovski/mini.pairs",
		event = "BufReadPre",
		config = true,
	},
	{
		"echasnovski/mini.surround",
		event = "BufReadPre",
		config = true,
	},
	{
		"echasnovski/mini.tabline",
		event = "BufReadPre",
		config = true,
	},
	{
		"echasnovski/mini.starter",
		event = "VimEnter",
		config = function()
			require("config.mini")
		end,
	},
	{
		"folke/which-key.nvim",
		config = true,
		event = "VeryLazy",
		cond = minimal,
	},
	{
		"nat-418/boole.nvim",
		config = function()
			require("boole").setup({
				mappings = {
					increment = "<C-a>",
					decrement = "<C-x>",
				},
				-- User defined loops
				additions = {
					{ "Foo", "Bar" },
					{ "tic", "tac", "toe" },
				},
				allow_caps_additions = {
					{ "enable", "disable" },
				},
			})
		end,
		event = "VeryLazy",
	},

	-- Command loaded plugins
	{ "psliwka/termcolors.nvim", cmd = "TermcolorsShow" },
	{ "ThePrimeagen/vim-be-good", lazy = true, cmd = "VimBeGood" },
	{ "nvim-colortils/colortils.nvim", lazy = true, cmd = "Colortils", config = true },
	{
		"echasnovski/mini.files",
		config = true,
		keys = { { "<leader>F", "<cmd>:lua MiniFiles.open()<cr>", desc = "File Tree" } },
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("config.lsp")
		end,
		dependencies = {
			-- LSP Support (auto-install...)
			require("config.lsp.helpers"),

			-- Autocompletion
			require("config.cmp"),

			-- Snippets
			require("config.snippets"),

			{ "pmizio/typescript-tools.nvim" },
			{ "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
		},
		event = "VeryLazy",
		cond = minimal,
	},

	-- TypeScript Extras
	{
		"jay-babu/mason-null-ls.nvim",
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
		},
		cond = minimal,
	},
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	config = function()
	-- 		require("copilot").setup({
	-- 			panel = {
	-- 				enabled = false,
	-- 			},
	-- 			suggestion = {
	-- 				auto_trigger = true,
	-- 			},
	-- 		})
	-- 	end,
	-- 	event = "InsertEnter",
	-- },
	-- {
	-- 	"Exafunction/codeium.vim",
	-- 	config = function()
	-- 		vim.keymap.set(
	-- 			"i",
	-- 			"<Plug>(vimrc:copilot-dummy-map)",
	-- 			'codeium#Accept("")',
	-- 			{ silent = true, expr = true, script = true, desc = "Copilot dummy accept" }
	-- 		)
	-- 		vim.keymap.set("i", "<M-]>", function()
	-- 			return vim.fn["codeium#CycleCompletions"](1)
	-- 		end, { expr = true })
	-- 		vim.keymap.set("i", "<M-]>", function()
	-- 			return vim.fn["codeium#CycleCompletions"](-1)
	-- 		end, { expr = true })
	-- 	end,
	-- 	event = "InsertEnter",
	-- },

	-- Debugging
	{
		"mfussenegger/nvim-dap",
		lazy = true,
	}, -- NOTE:
	{
		"mxsdev/nvim-dap-vscode-js",
		dependencies = { "mfussenegger/nvim-dap", "vscode-js-debug" },
		lazy = true,
	}, -- NOTE:
	{
		"rcarriga/nvim-dap-ui",
		config = function()
			require("config.dap")
		end,
		dependencies = { "mxsdev/nvim-dap-vscode-js" },
		keys = "<Leader>db",
	}, -- NOTE:
	{
		"microsoft/vscode-js-debug",
		lazy = true,
		build = "npm install --legacy-peer-deps && npm run compile",
	}, -- NOTE:
}
