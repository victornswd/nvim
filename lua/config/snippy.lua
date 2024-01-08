return {
	"dcampos/nvim-snippy",
	dependencies = {
		{
			"rafamadriz/friendly-snippets",
		},
		{
			"smjonas/snippet-converter.nvim",
			config = function()
				local template = {
					sources = {
						vscode = {
							"./friendly-snippets/snippets/",
						},
					},
					output = {
						snipmate = {
							vim.fn.stdpath("config") .. "/snippets",
						},
					},
				}

				require("snippet_converter").setup({
					templates = { template },
				})
			end,
		},
	},
	opts = {
		scopes = {
			markdown = { "markdown", "vimwiki" },
		},
	},
	keys = {
		{
			"<tab>",
			function()
				return require("snippy").can_expand_or_advance() and "<plug>(snippy-expand-or-advance)" or "<tab>"
			end,
			expr = true,
			silent = true,
			mode = { "i" },
		},
		{
			"<tab>",
			function()
				require("luasnip").next()
			end,
			mode = "s",
		},
		{
			"<s-tab>",
			function()
				require("snippy").previous()
			end,
			mode = { "i", "s" },
		},
	},
}
