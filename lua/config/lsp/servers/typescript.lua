return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "pmizio/typescript-tools.nvim" },
		opts = {
			tsserver_file_preferences = {
				includeInlayParameterNameHints = "all",
				includeInlayEnumMemberValueHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayVariableTypeHints = true,
			},
			completions = {
				completeFunctionCalls = true,
			},
			setup = {
				tsserver = function(_, opts)
					require("typescript-tools").setup({ settings = opts })
					return true
				end,
			},
		},
	},
}
