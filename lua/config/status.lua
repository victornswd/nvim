-- StatusLine adapted from https://github.com/cseickel/dotfiles/blob/main/config/nvim/lua/status.lua
local M = {}

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

M.lsp_loading = function()
  local Lsp = vim.lsp.util.get_progress_messages()[1]

  if Lsp then
    local msg = Lsp.message or ''
    local percentage = Lsp.percentage or 0
    local title = Lsp.title or ''
    local spinners = {
      '',
      '',
      '',
    }

    local success_icon = {
      '',
      '',
      '',
    }

    local ms = vim.loop.hrtime() / 1000000
    local frame = math.floor(ms / 120) % #spinners

    if percentage >= 70 then
      return string.format(' %%<%s %s %s (%s%%%%) ', success_icon[frame + 1], title, msg, percentage)
    end

    return string.format(' %%<%s %s %s (%s%%%%) ', spinners[frame + 1], title, msg, percentage)
  end

  return ''
end

M.lsp_connected = function()
  if next(vim.lsp.buf_get_clients()) ~= nil then
    return ' LSP'
  else
    return ''
  end
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
  ['starter'] = true,
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
        '%{%v:lua.status.aerial()%}',
        '%=',
        '%{%v:lua.status.get_diag()%}',
        '%{%v:lua.status.get_git_dirty()%}',
        '%{%v:lua.status.get_filename()%}',
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
    '%=',
    '%#StatusLineGitBranch# %{%v:lua.status.lsp_connected()%}%*',
    '%#StatusLineGitAdd# %{%v:lua.status.lsp_loading()%}%*',
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

M.gotoSymbolName = function(minwid, no, mouse)
  if no == 2 and mouse == 'l' then
    local function split_string(str)
      local first, second = string.match(str, '^(.*)000(.*)$')
      return first, second
    end

    local first, second = split_string(minwid)
    vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { tonumber(first), tonumber(second) })
  end
end

M.aerial = function()
  local aerial = require('aerial')

  local function format_status(symbols)
    local parts = {}
    for _, symbol in ipairs(symbols) do
      table.insert(
        parts,
        '%'
          .. symbol.lnum
          .. '000'
          .. symbol.col
          .. '@v:lua.status.gotoSymbolName@%#Aerial'
          .. symbol.kind
          .. 'Icon#'
          .. symbol.icon
          .. symbol.name
          .. '%*%X'
      )
    end
    return table.concat(parts, ' ▶ ')
  end

  local symbols = aerial.get_location(true)
  local symbols_structure = format_status(symbols)
  return symbols_structure
end

_G.status = M

vim.o.winbar = '%{%v:lua.status.get_winbar()%}'
vim.o.statusline = '%{%v:lua.status.get_statusline()%}'

return M
