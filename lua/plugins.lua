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
			require("config.neogen")
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

	-- UI flourishes
	{
		"lukas-reineke/indent-blankline.nvim",
		opts = { enabled = true },
		config = function()
			require("config.indent-blankline")
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
		cond = function()
			return vim.version().minor >= 9
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
		event = "VeryLazy",
	},
	{
		"stevearc/aerial.nvim",
		config = function()
			require("config.aerial")
		end,
		event = "VeryLazy",
	},
	{
		"edluffy/specs.nvim",
		config = function()
			require("config.specs")
		end,
		event = "VeryLazy",
		cond = minimal,
	},

	-- DX flourishes
	{ "ThePrimeagen/harpoon", dependencies = "nvim-lua/plenary.nvim" },
	{
		"ojroques/nvim-bufdel",
		config = function()
			require("config.bufdel")
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
			require("config.boole")
		end,
		event = "VeryLazy",
	},

	-- Command loaded plugins
	{ "tweekmonster/startuptime.vim", cmd = "StartupTime" },
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

	-- LSP Zero
	{
		"VonHeikemen/lsp-zero.nvim",
		config = function()
			require("config.lsp-zero")
		end,
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
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
	{ "marilari88/twoslash-queries.nvim", dependencies = "nvim-lspconfig" },

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
