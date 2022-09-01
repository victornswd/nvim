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

-- keymap
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'LSP - Go to declaration' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP - Go to definition' })
vim.keymap.set('n', 'gh', vim.lsp.buf.hover, { desc = 'LSP - Display hover tooltip' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'LSP - Go to implementation' })
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = 'LSP - Go to type definition' })
-- vim.keymap.set('n', 'gR', vim.lsp.buf.rename, { desc = 'LSP - Rename all references' })
vim.keymap.set('n', 'gr', function()
  pcall(require('telescope.builtin').lsp_references)
end, { desc = 'LSP - References' })
vim.keymap.set('n', 'gca', function()
  pcall(require('telescope.builtin').lsp_code_actions)
end, { desc = 'LSP - Code actions' })

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts, { desc = 'LSP - Open Diag' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts, { desc = 'LSP - Go to previous diag' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts, { desc = 'LSP - Go to next diag' })
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts, { desc = 'LSP - Add all diagnostics to loclist' })

vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'LSP - Function signature help' })
