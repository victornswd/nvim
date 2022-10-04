require('neogen').setup({ snippet_engine = 'luasnip' })

vim.keymap.set('n', '<leader>dd', function()
  pcall(require('neogen').generate)
end, { desc = 'Generate function documentation' })
