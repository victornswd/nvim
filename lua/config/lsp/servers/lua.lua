local lspconfig = require('lspconfig')
local conf = require('config.lsp.helpers')

lspconfig['sumneko_lua'].setup({
  capabilities = conf.capabilities,
  on_attach = conf.on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})
