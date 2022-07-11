local lspconfig = require('lspconfig')
local conf = require('config.lsp.helpers')

lspconfig['emmet_ls'].setup({
  capabilities = conf.capabilities,
  on_attach = conf.on_attach,
  settings = {},
})
