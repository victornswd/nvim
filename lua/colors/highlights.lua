local cmd = vim.cmd

local i, j = string.find(cs, '-base16')
local th = cs
if i then
  th = string.sub(cs, 1, (i - 1))
end
local colors = require('hl_themes.' .. th)

local black = colors.black
local black2 = colors.black2
local blue = colors.blue
local darker_black = colors.darker_black
local folder_bg = colors.folder_bg
local vibrant_green = colors.vibrant_green
local green = colors.green
local pink = colors.pink
local grey = colors.grey
local grey_fg = colors.grey_fg
local light_grey = colors.light_grey
local line = colors.line
local nord_blue = colors.nord_blue
local one_bg = colors.one_bg
local one_bg2 = colors.one_bg2
local pmenu_bg = colors.pmenu_bg
local purple = colors.purple
local dark_purple = colors.dark_purple
local red = colors.red
local white = colors.white
local yellow = colors.yellow
local orange = colors.orange
local one_bg3 = colors.one_bg3

-- functions for setting highlights
local fg = function(group, col)
  cmd('hi ' .. group .. ' guifg=' .. col)
end
local fg_bg = function(group, fgcol, bgcol)
  cmd('hi ' .. group .. ' guifg=' .. fgcol .. ' guibg=' .. bgcol)
end
local bg = function(group, col)
  cmd('hi ' .. group .. ' guibg=' .. col)
end

-- Comments
fg('Comment', grey_fg .. ' gui=italic')

-- Disable cursor line
cmd('hi clear CursorLine')
-- Line number
fg('cursorlinenr', white)

-- same it bg, so it doesn't appear
fg('EndOfBuffer', black)

-- For floating windows
fg('FloatBorder', blue)
bg('NormalFloat', darker_black)

-- Pmenu
bg('Pmenu', one_bg)
bg('PmenuSbar', one_bg2)
bg('PmenuSel', pmenu_bg)
bg('PmenuThumb', nord_blue)
fg('CmpItemAbbr', white)
fg('CmpItemAbbrMatch', white)
fg('CmpItemKind', white)
fg('CmpItemMenu', white)

-- misc

-- inactive statuslines as thin lines
fg('StatusLineNC', one_bg3 .. ' gui=underline')

fg('LineNr', grey)
fg('NvimInternalError', red)
fg('VertSplit', one_bg2)

-- [[ Plugin Highlights
-- Git signs
fg_bg('DiffAdd', blue, 'NONE')
fg_bg('DiffChange', grey_fg, 'NONE')
fg_bg('DiffChangeDelete', red, 'NONE')
fg_bg('DiffModified', red, 'NONE')
fg_bg('DiffDelete', red, 'NONE')

-- Indent blankline plugin
fg('IndentBlanklineChar', line)
fg('IndentBlanklineSpaceChar', line)

-- Lsp diagnostics

fg('DiagnosticHint', purple)
fg('DiagnosticError', red)
fg('DiagnosticWarn', yellow)
fg('DiagnosticInformation', green)

-- Telescope
fg_bg('TelescopeBorder', darker_black, darker_black)
fg_bg('TelescopePromptBorder', black2, black2)

fg_bg('TelescopePromptNormal', white, black2)
fg_bg('TelescopePromptPrefix', red, black2)

bg('TelescopeNormal', darker_black)

fg_bg('TelescopePreviewTitle', black, green)
fg_bg('TelescopePromptTitle', black, red)
fg_bg('TelescopeResultsTitle', darker_black, darker_black)

bg('TelescopeSelection', black2)

vim.cmd('hi Function gui=italic')
vim.cmd('hi Error gui=italic guibg=' .. grey)
bg('MatchParen', grey)
vim.cmd('hi markdownTSTitle guifg=' .. vibrant_green .. ' gui=bold')
vim.cmd('hi TSPunctSpecial  guifg=' .. vibrant_green .. ' gui=bold')
