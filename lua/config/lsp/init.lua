require("mason").setup()

require("mason-lspconfig").setup({
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
	},
})

local function border(hl_name)
	return {
		{ "╭", hl_name },
		{ "─", hl_name },
		{ "╮", hl_name },
		{ "│", hl_name },
		{ "╯", hl_name },
		{ "─", hl_name },
		{ "╰", hl_name },
		{ "│", hl_name },
	}
end

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border("CmpBorder")
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local lspconfig = require("lspconfig")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local lsp_format = function(bufnr)
	local ft = vim.bo[bufnr].filetype
	local have_nls = (#require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0)
	vim.lsp.buf.format({
		filter = function(client)
			if have_nls then
				return client.name == "null-ls"
			end
			return client.name ~= "null-ls"
		end,
		bufnr = bufnr,
	})
end

local lsp_attach = function(client, bufnr)
	-- keymap
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP - Go to declaration" })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP - Go to definition" })
	vim.keymap.set("n", "gh", vim.lsp.buf.hover, { desc = "LSP - Display hover tooltip" })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "LSP - Go to implementation" })
	vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "LSP - Show diagnostic message" })
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "LSP - Go to type definition" })
	vim.keymap.set("n", "gR", vim.lsp.buf.rename, { desc = "LSP - Rename all references" })
	vim.keymap.set("n", "gr", function()
		pcall(require("telescope.builtin").lsp_references)
	end, { desc = "LSP - References" })
	vim.keymap.set("n", "gca", vim.lsp.buf.code_action, { desc = "LSP - Code actions" })

	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP - Function signature help" })

	vim.keymap.set("n", "gF", function()
		vim.lsp.buf.format({ async = true })
	end)
	if client.name == "tsserver" then
		vim.keymap.set("n", "gco", "<cmd>TypescriptOrganizeImports<CR>", { buffer = bufnr, desc = "Organize Imports" })
		vim.keymap.set("n", "gcR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = bufnr })
	end

	require("lsp_signature").on_attach({
		floating_window = false,
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		handler_opts = {
			border = "rounded",
		},
	}, bufnr)

	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_format(bufnr)
			end,
		})
	end
end

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
require("mason-lspconfig").setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({
			on_attach = lsp_attach,
			capabilities = lsp_capabilities,
		})
	end,
})

lspconfig.jsonls.setup(require("config.lsp.servers.json").setup)
lspconfig.tailwindcss.setup(require("config.lsp.servers.tailwind").setup)
require("config.lsp.servers.typescript")

local null_ls = require("null-ls")

require("mason-null-ls").setup({
	ensure_installed = {
		"jq",
		"prettierd",
		"stylua",
		"shfmt",
		"elm_format",
		"eslint_d",
	},
	handlers = {
		eslint_d = function()
			null_ls.builtins.diagnostics.eslint_d.with({
				method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
			})
		end,
		prettierd = function(source_name, methods)
			require("mason-null-ls").default_setup(source_name, methods)
			null_ls.register(null_ls.builtins.formatting.prettierd.with({
				extra_filetypes = {
					"astro",
				},
			}))
		end,
	},
})

null_ls.setup({
	on_attach = lsp_attach,
	setup = {},
	sources = {
		require("typescript.extensions.null-ls.code-actions"),
	},
})

local signs = {
	Error = " ",
	Warn = " ",
	Hint = " ",
	Info = " ",
}
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
})

-- keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts, { desc = "LSP - Open Diag" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts, { desc = "LSP - Go to previous diag" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts, { desc = "LSP - Go to next diag" })
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts, { desc = "LSP - Add all diagnostics to loclist" })
