local M = {}

local lsp_format = function(bufnr)
  vim.lsp.buf.format({
    filter = function(clients)
      return clients.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

M.on_attach = function(client, bufnr)
  -- keymap
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP - Go to declaration" })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP - Go to definition" })
  vim.keymap.set("n", "gh", vim.lsp.buf.hover, { desc = "LSP - Display hover tooltip" })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "LSP - Go to implementation" })
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "LSP - Go to type definition" })
  vim.keymap.set("n", "gR", vim.lsp.buf.rename, { desc = "LSP - Rename all references" })
  vim.keymap.set("n", "gr", function()
    pcall(require("telescope.builtin").lsp_references)
  end, { desc = "LSP - References" })
  vim.keymap.set("n", "gca", vim.lsp.buf.code_action, { desc = "LSP - Code actions" })

  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP - Function signature help" })

  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "always",
        prefix = " ",
        scope = "cursor",
      }
      vim.diagnostic.open_float(nil, opts)
    end,
  })
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

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  require("lsp_signature").on_attach({
    floating_window = false,
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "rounded",
    },
  }, bufnr)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

capabilities.textDocument.colorProvider = {
  dynamicRegistration = true,
}

M.capabilities = capabilities
return M
