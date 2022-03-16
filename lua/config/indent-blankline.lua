-- set the colors manually
local i, j = string.find(cs, '-base16')
local th = cs
if i then
  th = string.sub(cs, 1, (i - 1))
end
local colors = require('hl_themes.' .. th)

local fg = function(group, col)
  vim.cmd('hi ' .. group .. ' guifg=' .. col)
end

fg('IndentBlanklineChar', colors.one_bg3)
fg('IndentBlanklineContextChar', colors.dark_purple)

require('indent_blankline').setup({
  space_char_blankline = ' ',
  show_current_context = true,
  show_current_context_start = true,
  indent_blankline_use_treesitter = true,
})

vim.cmd("let g:indent_blankline_filetype_exclude = ['starter', 'markdown', 'vimwiki']")
