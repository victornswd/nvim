require("mason").setup()
require("mason-lspconfig").setup()

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

-- keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "LSP - Open Diag" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "LSP - Go to previous diag" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "LSP - Go to next diag" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "LSP - Add all diagnostics to loclist" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts, { desc = "LSP - Go to declaration" })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts, { desc = "LSP - Go to definition" })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts, { desc = "LSP - Display hover tooltip" })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts, { desc = "LSP - Go to implementation" })
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts, { desc = "LSP - Function signature help" })
		vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
		end, opts)
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts, { desc = "LSP - Go to type definition" })
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts, { desc = "LSP - Rename all references" })
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts, { desc = "LSP - Code actions" })
		vim.keymap.set("n", "gr", function()
			pcall(require("telescope.builtin").lsp_references)
		end, opts, { desc = "LSP - References" })
		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
		vim.keymap.set(
			"n",
			"<leader>ws",
			require("telescope.builtin").lsp_dynamic_workspace_symbols,
			{ desc = "Workspace Symbols" }
		)
		vim.keymap.set(
			"n",
			"<leader>ds",
			require("telescope.builtin").lsp_document_symbols,
			{ desc = "Document Symbols" }
		)
	end,
})

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
require("mason-lspconfig").setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({
			capabilities = lsp_capabilities,
		})
	end,
})

require("config.lsp.servers.json")
require("config.lsp.servers.go")
require("config.lsp.servers.typescript")
require("config.lsp.servers.tailwind")

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
