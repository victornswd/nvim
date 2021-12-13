-- cmd 'colorscheme gruvbox'
vim.g.rose_pine_variant = 'moon'

-- Load colorscheme after options
vim.cmd('colorscheme rose-pine')

-- set the colors manually from the rose-pine theme
vim.cmd [[highlight IndentBlanklineChar guifg=#59546d gui=nocombine]]
vim.cmd [[highlight IndentBlanklineContextChar guifg=#c4a7e7 gui=nocombine]]
require("indent_blankline").setup {
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
  indent_blankline_use_treesitter = true,
}
