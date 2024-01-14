return {
	{
		"stevearc/conform.nvim",
		opts = {
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "shfmt" },
				javascript = { "prettierd" },
				astro = { "prettierd" },
				typescript = { "prettierd" },
				markdown = { "prettierd" },
				html = { "prettierd" },
				go = { "goimports", "gofumpt" },
				templ = { "templ", "rustywind" },
			},
		},
		event = "VeryLazy",
	},
	{
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = {
				go = { "golangcilint" },
				typescript = { "eslint_d" },
				javascript = { "eslint_d" },
				-- markdown = { "vale" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
		event = "VeryLazy",
	},
	-- {
	-- 	"lvimuser/lsp-inlayhints.nvim",
	-- 	branch = "anticonceal",
	-- },
}
