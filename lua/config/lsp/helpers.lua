local M = {}
M.on_attach = function(client, bufnr)
  local vim_version = vim.version()

  if vim_version.minor > 7 then
    -- nightly
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  else
    -- stable
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  if client.server_capabilities.signatureHelpProvider then
    require('lsp_signature').on_attach()
  end
end

M.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

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

M.capabilities = capabilities
--
return M
