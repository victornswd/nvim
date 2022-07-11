require('nvim-lsp-installer').setup({
  automatic_installation = true,
  ui = {
    icons = {
      server_installed = '✓',
      server_pending = '➜',
      server_uninstalled = '✗',
    },
  },
})

--   if server.name == 'html' then
--     opts.capabilities = require('config.lsp.servers.html').capabilities
--     opts.settings = require('config.lsp.servers.html').settings
--   end
--
--   if server.name == 'jsonls' then
--     opts.settings = require('config.lsp.servers.json').settings
--   end
