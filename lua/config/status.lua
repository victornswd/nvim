-- StatusLine adapted from https://github.com/cseickel/dotfiles/blob/main/config/nvim/lua/status.lua
local M = {}

local colorFn = function()
  local i, _ = string.find(vim.g.theme, '-NvChad')
  if i then
    return require('base46').get_theme_tb('base_30')
  else
    -- FIXME: make it into a monochrome washed out theme
    return {
      white = '#e8e8d3',
      darker_black = '#101010',
      black = '#151515', --  nvim bg
      black2 = '#1c1c1c',
      one_bg = '#252525',
      one_bg2 = '#2e2e2e',
      one_bg3 = '#3a3a3a',
      grey = '#424242',
      grey_fg = '#474747',
      grey_fg2 = '#4c4c4c',
      light_grey = '#525252',
      red = '#cf6a4c',
      baby_pink = '#da7557',
      pink = '#f0a0c0',
      line = '#232323', -- for lines like vertsplit
      green = '#99ad6a',
      vibrant_green = '#c2cea6',
      nord_blue = '#768cb4',
      blue = '#8197bf',
      yellow = '#fad07a',
      sun = '#ffb964',
      purple = '#ea94ea',
      dark_purple = '#e18be1',
      teal = '#668799',
      orange = '#e78a4e',
      cyan = '#8fbfdc',
      statusline_bg = '#191919',
      lightbg = '#252525',
      lightbg2 = '#1e1e1e',
      pmenu_bg = '#8197bf',
      folder_bg = '#8197bf',
    }
  end
end

local colors = colorFn()

local isempty = function(s)
  return s == nil or s == ''
end

local is_current = function()
  local winid = vim.g.actual_curwin
  if isempty(winid) then
    return false
  else
    return winid == tostring(vim.api.nvim_get_current_win())
  end
end
local icon_cache = {}

vim.api.nvim_set_hl(0, 'StatusLineGitAdd', {
  fg = colors.vibrant_green,
  bg = colors.statusline_bg,
})
vim.api.nvim_set_hl(0, 'StatusLineGitRemoved', {
  fg = colors.red,
  bg = colors.statusline_bg,
})
vim.api.nvim_set_hl(0, 'StatusLineGitChanged', {
  fg = colors.sun,
  bg = colors.statusline_bg,
})
vim.api.nvim_set_hl(0, 'StatusLineGitBranch', {
  fg = colors.grey_fg2,
  bg = colors.statusline_bg,
})
vim.api.nvim_set_hl(0, 'StatusLineLocation', {
  fg = colors.cyan,
  bg = colors.grey,
})
vim.api.nvim_set_hl(0, 'StatusLinePosition', {
  fg = colors.green,
  bg = colors.grey,
})
vim.api.nvim_set_hl(0, 'StatusLine', {
  bg = colors.statusline_bg,
  fg = colors.fg,
})

vim.api.nvim_set_hl(0, 'MainSep', {
  fg = colors.cyan,
  bg = colors.lightbg,
  bold = true,
})
vim.api.nvim_set_hl(0, 'Main', {
  bg = colors.cyan,
  fg = colors.lightbg,
  bold = true,
})
vim.api.nvim_set_hl(0, 'ModeCSep', {
  fg = colors.green,
  bg = colors.lightbg,
  bold = true,
})
vim.api.nvim_set_hl(0, 'ModeC', {
  bg = colors.green,
  fg = colors.lightbg,
  bold = true,
})
vim.api.nvim_set_hl(0, 'ModeISep', {
  fg = colors.dark_purple,
  bg = colors.lightbg,
  bold = true,
})
vim.api.nvim_set_hl(0, 'ModeI', {
  bg = colors.dark_purple,
  fg = colors.lightbg,
  bold = true,
})
vim.api.nvim_set_hl(0, 'ModeTSep', {
  fg = colors.green,
  bg = colors.lightbg,
  bold = true,
})
vim.api.nvim_set_hl(0, 'ModeT', {
  bg = colors.green,
  fg = colors.lightbg,
  bold = true,
})
vim.api.nvim_set_hl(0, 'ModeNSep', {
  fg = colors.red,
  bg = colors.lightbg,
  bold = true,
})
vim.api.nvim_set_hl(0, 'ModeN', {
  bg = colors.red,
  fg = colors.lightbg,
  bold = true,
})
vim.api.nvim_set_hl(0, 'ModeVSep', {
  fg = colors.cyan,
  bg = colors.lightbg,
  bold = true,
})
vim.api.nvim_set_hl(0, 'ModeV', {
  bg = colors.cyan,
  fg = colors.lightbg,
  bold = true,
})
vim.api.nvim_set_hl(0, 'ModeRSep', {
  fg = colors.orange,
  bg = colors.lightbg,
  bold = true,
})
vim.api.nvim_set_hl(0, 'ModeR', {
  bg = colors.orange,
  fg = colors.lightbg,
  bold = true,
})

vim.api.nvim_set_hl(0, 'StatusLineFile', {
  fg = colors.white,
  bg = colors.lightbg,
})
vim.api.nvim_set_hl(0, 'StatusLineFileSep', {
  bg = colors.statusline_bg,
  fg = colors.lightbg,
})

vim.api.nvim_set_hl(0, 'StatusLinePositionIcon', {
  fg = colors.black,
  bg = colors.green,
})
vim.api.nvim_set_hl(0, 'StatusLinePositionIconSep', {
  bg = colors.grey,
  fg = colors.green,
})
vim.api.nvim_set_hl(0, 'StatusLineLocationSep', {
  fg = colors.grey,
  bg = colors.statusline_bg,
})
vim.api.nvim_set_hl(0, 'StatusLineError', {
  fg = colors.red,
})
vim.api.nvim_set_hl(0, 'StatusLineInfo', {
  fg = colors.green,
})
vim.api.nvim_set_hl(0, 'StatusLineHint', {
  fg = colors.dark_purple,
})
vim.api.nvim_set_hl(0, 'StatusLineWarn', {
  fg = colors.yellow,
})

-- ['s'] = { 'SELECT', default.colors.nord_blue },
-- ['S'] = { 'S-LINE', default.colors.nord_blue },
-- [''] = { 'S-BLOCK', default.colors.nord_blue },
-- ['r'] = { 'PROMPT', default.colors.teal },
-- ['rm'] = { 'MORE', default.colors.teal },
-- ['r?'] = { 'CONFIRM', default.colors.teal },
-- ['!'] = { 'SHELL', default.colors.green },

-- mode_map copied from:
-- https://github.com/nvim-lualine/lualine.nvim/blob/5113cdb32f9d9588a2b56de6d1df6e33b06a554a/lua/lualine/utils/mode.lua
-- Copyright (c) 2020-2021 hoob3rt
-- MIT license, see LICENSE for more details.
local mode_map = {
  ['n'] = 'NORMAL',
  ['no'] = 'O-PENDING',
  ['nov'] = 'O-PENDING',
  ['noV'] = 'O-PENDING',
  ['no\22'] = 'O-PENDING',
  ['niI'] = 'NORMAL',
  ['niR'] = 'NORMAL',
  ['niV'] = 'NORMAL',
  ['nt'] = 'NORMAL',
  ['v'] = 'VISUAL',
  ['vs'] = 'VISUAL',
  ['V'] = 'V-LINE',
  ['Vs'] = 'V-LINE',
  ['\22'] = 'V-BLOCK',
  ['\22s'] = 'V-BLOCK',
  ['s'] = 'SELECT',
  ['S'] = 'S-LINE',
  ['\19'] = 'S-BLOCK',
  ['i'] = 'INSERT',
  ['ic'] = 'INSERT',
  ['ix'] = 'INSERT',
  ['R'] = 'REPLACE',
  ['Rc'] = 'REPLACE',
  ['Rx'] = 'REPLACE',
  ['Rv'] = 'V-REPLACE',
  ['Rvc'] = 'V-REPLACE',
  ['Rvx'] = 'V-REPLACE',
  ['c'] = 'COMMAND',
  ['cv'] = 'EX',
  ['ce'] = 'EX',
  ['r'] = 'REPLACE',
  ['rm'] = 'MORE',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  ['t'] = 'TERMINAL',
}

M.get_icon = function(filename, extension)
  if not filename then
    if vim.bo.modified then
      return ' %#WinBarModified# %*'
    end

    if vim.bo.filetype == 'terminal' then
      filename = 'terminal'
      extension = 'terminal'
    else
      filename = vim.fn.expand('%:t')
    end
  end

  local cached = icon_cache[filename]
  if not cached then
    if not extension then
      extension = vim.fn.fnamemodify(filename, ':e')
    end
    local file_icon = require('nvim-web-devicons').get_icon(filename, extension)
    cached = ' ' .. file_icon .. ' '
    icon_cache[filename] = cached
  end
  return cached
end

M.get_filename = function()
  local has_icon, icon = pcall(M.get_icon)
  if has_icon then
    return icon .. '%t'
  else
    return ' %t'
  end
end

M.get_loc = function()
  return string.format(' %3d:%-2d ', unpack(vim.api.nvim_win_get_cursor(0)))
end

M.get_position = function()
  local current_line = vim.fn.line('.')
  local total_line = vim.fn.line('$')

  if current_line == 1 then
    return ' Top '
  elseif current_line == vim.fn.line('$') then
    return ' Bot '
  end
  local result, _ = math.modf((current_line / total_line) * 100)
  return ' ' .. string.format('%2d', result) .. '%% '
end

M.table_contains = function(table, element)
  if table ~= nil then
    if table[element] ~= nil then
      return true
    end
    return false
  else
    return false
  end
end

M.git_diff = function(diff, hl_group, sign)
  local changes = M.table_contains(vim.b.gitsigns_status_dict, diff)
  if changes then
    local value = vim.b.gitsigns_status_dict[diff]
    if diff == 'head' then
      return '%#' .. hl_group .. '#' .. sign .. value .. '%*'
    end
    if value > 0 then
      local text = '%#' .. hl_group .. '#' .. sign .. value .. '%*'
      return text
    else
      return ''
    end
  else
    return ''
  end
end

M.get_git_added = function()
  return M.git_diff('added', 'StatusLineGitAdd', '  ')
end

M.get_git_changed = function()
  return M.git_diff('changed', 'StatusLineGitChanged', '  ')
end

M.get_git_removed = function()
  return M.git_diff('removed', 'StatusLineGitRemoved', '  ')
end

M.get_git_branch = function()
  return M.git_diff('head', 'StatusLineGitBranch', '  ')
end

M.get_mode = function()
  if not is_current() then
    --return "%#WinBarInactive# win #" .. vim.fn.winnr() .. " %*"
    return '%#WinBarInactive#  #' .. vim.fn.winnr() .. '  %*'
  end
  local mode_code = vim.api.nvim_get_mode().mode
  local mode = mode_map[mode_code] or string.upper(mode_code)
  local modeStr = '%#Mode' .. mode:sub(1, 1)
  return modeStr .. '# ' .. mode .. '  %*' .. modeStr .. 'Sep#%*'
end

local get_sign = function(severity)
  local icons = {
    Info = { text = ' ' },
    Error = { text = ' ' },
    Hint = { text = ' ' },
    Warn = { text = ' ' },
  }
  return icons[severity].text
end

M.get_diag = function()
  local d = vim.diagnostic.get(0)
  if #d == 0 then
    return ''
  end

  local min_severity = 100
  for _, diag in ipairs(d) do
    if diag.severity < min_severity then
      min_severity = diag.severity
    end
  end
  local severity = ''
  if min_severity == vim.diagnostic.severity.ERROR then
    severity = 'Error'
  elseif min_severity == vim.diagnostic.severity.WARN then
    severity = 'Warn'
  elseif min_severity == vim.diagnostic.severity.INFO then
    severity = 'Info'
  elseif min_severity == vim.diagnostic.severity.HINT then
    severity = 'Hint'
  else
    return ''
  end

  return get_sign(severity)
end

M.get_diag_counts = function()
  local d = vim.diagnostic.get(0)
  if #d == 0 then
    return ''
  end

  local grouped = {}
  for _, diag in ipairs(d) do
    local severity = diag.severity
    if not grouped[severity] then
      grouped[severity] = 0
    end
    grouped[severity] = grouped[severity] + 1
  end

  local result = ''
  local S = vim.diagnostic.severity
  if grouped[S.ERROR] then
    result = result .. '%#StatusLineError#' .. get_sign('Error') .. grouped[S.ERROR] .. '%* '
  end
  if grouped[S.WARN] then
    result = result .. '%#StatusLineWarn#' .. get_sign('Warn') .. grouped[S.WARN] .. '%* '
  end
  if grouped[S.INFO] then
    result = result .. '%#StatusLineInfo#' .. get_sign('Info') .. grouped[S.INFO] .. '%* '
  end
  if grouped[S.HINT] then
    result = result .. '%#StatusLineHint#' .. get_sign('Hint') .. grouped[S.HINT] .. '%* '
  end
  return result
end

vim.cmd([[
  highlight WinBar           guifg=#BBBBBB gui=bold
  highlight WinBarNC         guifg=#888888 gui=bold
  highlight WinBarLocation   guifg=#888888 gui=bold
  highlight WinBarModified   guifg=#d7d787 gui=bold
  highlight WinBarGitDirty   guifg=#d7afd7 gui=bold
  highlight WinBarIndicator  guifg=#5fafd7 gui=bold
  highlight WinBarInactive   guibg=#3a3a3a guifg=#777777 gui=bold
]])

local winbar_filetype_exclude = {
  [''] = true,
  ['NvimTree'] = true,
  ['Outline'] = true,
  ['Trouble'] = true,
  ['alpha'] = true,
  ['dashboard'] = true,
  ['lir'] = true,
  ['neo-tree'] = true,
  ['neogitstatus'] = true,
  ['packer'] = true,
  ['spectre_panel'] = true,
  ['startify'] = true,
  ['toggleterm'] = true,
}

M.get_winbar = function()
  -- floating window
  local cfg = vim.api.nvim_win_get_config(0)
  if cfg.relative > '' or cfg.external then
    return ''
  end

  if winbar_filetype_exclude[vim.bo.filetype] then
    return '%{%v:lua.status.active_indicator()%}'
  end

  if vim.bo.buftype == 'terminal' then
    return '%{%v:lua.status.get_mode()%}%{%v:lua.status.get_icon()%} TERMINAL #%n %#WinBarLocation# %{b:term_title}%*'
  else
    local buftype = vim.bo.buftype
    -- real files do not have buftypes
    if isempty(buftype) then
      return table.concat({
        -- '%{%v:lua.status.get_mode()%}',
        '%{%v:lua.status.get_filename()%}',
        '%<',
        '%{%v:lua.status.get_location()%}',
        '%=',
        '%{%v:lua.status.get_diag()%}',
        '%{%v:lua.status.get_git_dirty()%}',
      })
    else
      -- Meant for quickfix, help, etc
      return '%{%v:lua.status.get_mode()%}%( %h%) %f'
    end
  end
end

M.get_statusline = function()
  local parts = {
    '%#Main#  %*%#MainSep#%*',
    '%{%v:lua.status.get_mode()%}',
    '%<',
    '%#StatusLineFile#%{%v:lua.status.get_filename()%} %*',
    '%#StatusLineFileSep#%*',
    '%{%v:lua.status.get_git_branch()%}',
    '%{%v:lua.status.get_git_added()%}',
    '%{%v:lua.status.get_git_changed()%}',
    '%{%v:lua.status.get_git_removed()%}',
    -- '%#StatusLineMod#%{IsBuffersModified()}%*',
    '%=',
    '%{%v:lua.status.get_diag_counts()%}',
    '%#StatusLineLocationSep#%*',
    '%#StatusLineLocation# %{%v:lua.status.get_loc()%}%*',
    '%#StatusLinePosition#%{%v:lua.status.get_position()%}%*',
    '%#StatusLinePositionIconSep#%*%#StatusLinePositionIcon#  %*',
  }
  return table.concat(parts)
end

M.active_indicator = function()
  if is_current() then
    return '%#WinBarIndicator#▔▔▔▔▔▔▔▔%*'
  else
    return ''
  end
end

M.get_git_dirty = function()
  local dirty = vim.b.gitsigns_status
  if isempty(dirty) then
    return ' '
  else
    return '%#WinBarGitDirty# %*'
  end
end

M.get_location = function()
  local success, result = pcall(function()
    if not is_current() then
      return ''
    end
    local provider = require('nvim-navic')
    if not provider.is_available() then
      return ''
    end

    local location = provider.get_location({})
    if not isempty(location) and location ~= 'error' then
      return '%#WinBarLocation#  ' .. location .. '%*'
    else
      return ''
    end
  end)

  if not success then
    return ''
  end
  return result
end

vim.cmd([[
  " [+] if only current modified, [+3] if 3 modified including current buffer.
  " [3] if 3 modified and current not, "" if none modified.
  function! IsBuffersModified()
      let cnt = len(filter(getbufinfo(), 'v:val.changed == 1'))
      return cnt == 0 ? "" : ( &modified ? "[+". (cnt>1?cnt:"") ."]" : "[".cnt."]" )
  endfunction
]])

_G.status = M
vim.o.winbar = '%{%v:lua.status.get_winbar()%}'
vim.o.statusline = '%{%v:lua.status.get_statusline()%}'

return M
