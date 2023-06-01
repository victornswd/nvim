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
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
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
		opts = require("config.catppuccin"),
		config = function(_, opts)
			require("catppuccin").setup(opts)

			vim.cmd.colorscheme("catppuccin")
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
	{ "mrjones2014/nvim-ts-rainbow", event = "VeryLazy" }, -- NOTE:
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
				max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
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
		event = "VeryLazy",
	},

	-- UI flourishes
	{
		"lukas-reineke/indent-blankline.nvim",
		opts = { enabled = true },
		config = function()
			require("indent_blankline").setup({
				space_char_blankline = " ",
				show_current_context = true,
				show_current_context_start = true,
				indent_blankline_use_treesitter = true,
			})

			vim.cmd("let g:indent_blankline_filetype_exclude = ['starter', 'markdown', 'vimwiki']")

			vim.api.nvim_set_hl(0, "IndentBlanklineContextStart", {})
			vim.api.nvim_set_hl(0, "IndentBlanklineContextStart", { underline = true, sp = "#CA9EE6" })
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
	{
		"luukvbaal/statuscol.nvim",
		opts = { setopt = true },
		config = true,
		event = "VeryLazy",
	},
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
		event = "VeryLazy",
	},
	{
		-- "edluffy/specs.nvim",
		-- HACK: use this PR to fix a weird open in INSERT mode bug
		-- https://github.com/edluffy/specs.nvim/pull/16
		"xiyaowong/specs.nvim",
		branch = "feat/show-on-win-enter",
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
	{
		"echasnovski/mini.nvim",
		event = "VimEnter",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
				end,
			},
		},
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
		"nvim-tree/nvim-tree.lua",
		lazy = true,
		cmd = "NvimTreeToggle",
		keys = { { "<leader>b", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree" } },
		config = true,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("config.lsp")
		end,
		dependencies = {
			-- LSP Support
			{
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
		event = "VeryLazy",
		cond = minimal,
	},

	-- TypeScript Extras
	{
		"ray-x/lsp_signature.nvim",
		"jose-elias-alvarez/typescript.nvim",
		dependencies = "nvim-lspconfig",
		cond = minimal,
	},
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
