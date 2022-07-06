-- Load servers (They will be automatically installed after next "Sync plugins" launch)
-- Check installed servers by :LspInstallInfo
-- Configs copied from https://github.com/ecosse3/nvim

-- require('config.lsp.installer')
require('config.lsp.servers.bash')
require('config.lsp.servers.css')
require('config.lsp.servers.graphql')
require('config.lsp.servers.html')
require('config.lsp.servers.json')
require('config.lsp.servers.lua')
require('config.lsp.servers.tsserver')
require('config.lsp.servers.tailwind')
require('config.lsp.servers.emmet')

require('base46').load_highlight('lsp')
