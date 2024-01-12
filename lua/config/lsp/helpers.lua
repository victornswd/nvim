return {
	{
		"williamboman/mason.nvim",
		build = function()
			pcall(vim.cmd, "MasonUpdate")
		end,
	},
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"bashls",
					"cssls",
					"html",
					"jsonls", -- custom
					"tsserver", -- custom
					"tailwindcss", -- custom
					"prismals",
					"astro",
					"sqlls",
					"emmet_language_server",
					"lua_ls",
					"eslint",
					"gopls",
					"templ",
					--
					"prettierd",
					"stylua",
					"shfmt",
					"elm-format",
					"goimports",
					"gofumpt",
					"rustywind",
				},
				run_on_start = false,
			})

			vim.defer_fn(vim.cmd.MasonToolsInstall, 500)
		end,
	},
}
