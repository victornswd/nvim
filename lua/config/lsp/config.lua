local i, _ = string.find(vim.g.theme, '-NvChad')
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
require('config.lsp.servers.prisma')
require('config.lsp.servers.astro')
require('config.lsp.servers.sql')
require('config.lsp.servers.emmet')

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  float = {
    focusable = true,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

vim.diagnostic.config({
  -- virtual_text = false,
})

local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts, { desc = 'LSP - Open Diag' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts, { desc = 'LSP - Go to previous diag' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts, { desc = 'LSP - Go to next diag' })
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts, { desc = 'LSP - Add all diagnostics to loclist' })
