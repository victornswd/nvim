local lspconfig = require('lspconfig')
local conf = require('config.lsp.helpers')

lspconfig['cssls'].setup({
  capabilities = conf.capabilities,
  on_attach = conf.on_attach,
  settings = {},
})
