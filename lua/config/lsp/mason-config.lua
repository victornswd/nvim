require('mason-lspconfig').setup({
  automatic_installation = true,
})

--   if server.name == 'html' then
--     opts.capabilities = require('config.lsp.servers.html').capabilities
--     opts.settings = require('config.lsp.servers.html').settings
--   end
--
--   if server.name == 'jsonls' then
--     opts.settings = require('config.lsp.servers.json').settings
--   end
