local i, _ = string.find(vim.g.theme, '-NvChad')
if i then
  require('base46').load_highlight('mason')
end

require('mason').setup({
  ui = {
    icons = {
      server_installed = '✓',
      server_pending = '➜',
      server_uninstalled = '✗',
    },
  },
})
