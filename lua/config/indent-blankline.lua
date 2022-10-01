local i, _ = string.find(vim.g.theme, '-NvChad')
local line = ''
if i then
  local colors = require('base46').get_theme_tb('base_30')
  line = colors.dark_purple
else
  line = '#ff0000'
end

require('indent_blankline').setup({
  space_char_blankline = ' ',
  show_current_context = true,
  show_current_context_start = true,
  indent_blankline_use_treesitter = true,
})

vim.cmd("let g:indent_blankline_filetype_exclude = ['starter', 'markdown', 'vimwiki']")

vim.api.nvim_set_hl(0, 'IndentBlanklineContextStart', {})
vim.api.nvim_set_hl(0, 'IndentBlanklineContextStart', { underline = true, sp = line })
