local i, j = string.find(vim.g.theme, '-NvChad')
if i then
  require('base46').load_highlight('lsp')
end

require('config.lsp.servers.bash')
require('config.lsp.servers.css')
require('config.lsp.servers.graphql')
require('config.lsp.servers.html')
require('config.lsp.servers.json')
require('config.lsp.servers.lua')
require('config.lsp.servers.tsserver')
require('config.lsp.servers.tailwind')
require('config.lsp.servers.emmet')

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  -- This sets the spacing and the prefix, obviously.
  virtual_text = false,
  update_in_insert = true,
})

local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
