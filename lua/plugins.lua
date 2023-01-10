return {
	-- Dependencies
	"kyazdani42/nvim-web-devicons",
	"nvim-lua/plenary.nvim",
	{ "stevearc/dressing.nvim", event = "VeryLazy" },

	-- Colors
	{
		"victornswd/base46",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("colors")
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
		config = function()
			require("config.todo-comments")
		end,
		event = "VeryLazy",
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		dependencies = "nvim-treesitter",
	},

	-- Dev helpers (documentation, pickers, editor config, etc)
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("config.telescope")
		end,
		dependencies = {
			{
				"ElPiloto/telescope-vimwiki.nvim", -- NOTE:
				"benfowler/telescope-luasnip.nvim", -- NOTE:
				{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			},
		},
		event = "VeryLazy",
	},
	{
		"danymat/neogen",
		config = function()
			require("config.neogen")
		end,
		dependencies = "nvim-treesitter/nvim-treesitter",
		keys = "<Leader>dd",
	},
	{ "vimwiki/vimwiki", branch = "dev", event = "VeryLazy" },

	-- UI flourishes
	{
		"lukas-reineke/indent-blankline.nvim",
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
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup()
		end,
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
		"phaazon/hop.nvim",
		config = function()
			require("config.hop")
		end,
		event = "VeryLazy",
	}, -- NOTE:
	{
		"echasnovski/mini.nvim",
		config = function()
			require("config.mini")
		end,
	},
	{
		"folke/which-key.nvim",
		config = function()
			require("config.which-key")
		end,
		event = "VeryLazy",
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
	},

	-- TypeScript LSP Extras
	{
		"ray-x/lsp_signature.nvim",
		"jose-elias-alvarez/typescript.nvim",
		dependencies = "nvim-lspconfig",
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
	},
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	config = function() require("config.copilot"),
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
