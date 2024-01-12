require("lspconfig").tailwindcss.setup({
	filetypes = vim.list_extend(
		require("lspconfig.server_configurations.tailwindcss").default_config.filetypes,
		{ "templ" }
	),
	init_options = {
		userLanguages = {
			templ = "html",
		},
	},
})
