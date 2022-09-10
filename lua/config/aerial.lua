require('aerial').setup({
  backends = { 'lsp', 'treesitter', 'markdown' },
  min_width = 28,
  show_guides = true,
  filter_kind = false,
  guides = {
    mid_item = '├ ',
    last_item = '└ ',
    nested_top = '│ ',
    whitespace = '  ',
  },
})
