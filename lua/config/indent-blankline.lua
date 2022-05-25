require('indent_blankline').setup({
  space_char_blankline = ' ',
  show_current_context = true,
  show_current_context_start = true,
  indent_blankline_use_treesitter = true,
})

vim.cmd("let g:indent_blankline_filetype_exclude = ['starter', 'markdown', 'vimwiki']")
