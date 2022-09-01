require('neogen').setup({ snippet_engine = 'luasnip' })

vim.keymap.set('n', '<leader>d', function()
  pcall(require('neogen').generate)
end, { desc = 'Generate function documentation' })
