local M = {}

local lsp_format = function(bufnr)
  vim.lsp.buf.format({
    filter = function(clients)
      return clients.name == 'null-ls'
    end,
    bufnr = bufnr,
  })
end

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

M.on_attach = function(client, bufnr)
  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_format(bufnr)
      end,
    })
  end

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  require('lsp_signature').on_attach()

  require('aerial').on_attach(client, bufnr)

  -- if client.server_capabilities.colorProvider then
  --   require('document-color').buf_attach(bufnr)
  -- end
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

capabilities.textDocument.completion.completionItem = {
  documentationFormat = { 'markdown', 'plaintext' },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    },
  },
}

capabilities.textDocument.colorProvider = {
  dynamicRegistration = true,
}

M.capabilities = capabilities
--
return M
