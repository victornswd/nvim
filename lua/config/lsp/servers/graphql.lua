local lspconfig = require('lspconfig')
local conf = require('config.lsp.helpers')

lspconfig['graphql'].setup({
  capabilities = conf.capabilities,
  on_attach = conf.on_attach,
  settings = {},
})
