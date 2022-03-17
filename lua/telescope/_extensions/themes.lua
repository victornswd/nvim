local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local sorters = require('telescope.sorters')

local function clear_cmdline()
  vim.defer_fn(function()
    vim.cmd('echo')
  end, 0)
end

-- 1st arg - r or w
-- 2nd arg - file path
-- 3rd arg - content if 1st arg is w
-- return file data on read, nothing on write
local function file_fn(mode, filepath, content)
  local data
  local fd = assert(vim.loop.fs_open(filepath, mode, 438))
  local stat = assert(vim.loop.fs_fstat(fd))
  if stat.type ~= 'file' then
    data = false
  else
    if mode == 'r' then
      data = assert(vim.loop.fs_read(fd, stat.size, 0))
    else
      assert(vim.loop.fs_write(fd, content, 0))
      data = true
    end
  end
  assert(vim.loop.fs_close(fd))
  return data
end

local function change_theme(current_theme, new_theme)
  if current_theme == nil or new_theme == nil then
    print('Error: Provide current and new theme name')
    return false
  end
  if current_theme == new_theme then
    return
  end

  local file = vim.fn.stdpath('config') .. '/lua/colors/' .. 'init.lua'

  -- store in data variable
  local data = assert(file_fn('r', file))
  -- escape characters which can be parsed as magic chars
  current_theme = current_theme:gsub('%p', '%%%0')
  new_theme = new_theme:gsub('%p', '%%%0')
  local find = 'theme = .?' .. current_theme .. '.?'
  local replace = 'theme = "' .. new_theme .. '"'
  local content = string.gsub(data, find, replace)
  -- see if the find string exists in file
  if content == data then
    print('Error: Cannot change default theme with ' .. new_theme .. ', edit ' .. file .. ' manually')
    return false
  else
    assert(file_fn('w', file, content))
  end
end

local function next_color(prompt_bufnr)
  actions.move_selection_next(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd = 'colorscheme ' .. selected[1]
  vim.cmd(cmd)
end

local function prev_color(prompt_bufnr)
  actions.move_selection_previous(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd = 'colorscheme ' .. selected[1]
  vim.cmd(cmd)
end

local function enter(prompt_bufnr)
  local current_theme = vim.g.theme
  local selected = action_state.get_selected_entry()
  local final_theme = selected[1]
  -- local cmd = 'colorscheme ' .. final_theme
  -- vim.cmd(cmd)

  -- ask for confirmation to set as default theme
  local ans = string.lower(vim.fn.input('Set ' .. final_theme .. ' as default theme ? [y/N] ')) == 'y'
  clear_cmdline()
  if ans then
    change_theme(current_theme, final_theme)
  else
    -- will be used in restoring nvchad theme var
    final_theme = current_theme
  end
  require('colors').reload_theme(final_theme)
  vim.g.theme = final_theme

  actions.close(prompt_bufnr)
end

local colors = vim.fn.getcompletion('', 'color')

local opts = {
  prompt_title = 'Change Colorscheme',
  finder = finders.new_table(colors),
  sorter = sorters.get_generic_fuzzy_sorter({}),

  attach_mappings = function(prompt_bufnr, map)
    map('i', '<CR>', enter)
    map('i', '<Down>', next_color)
    map('i', '<Up>', prev_color)

    map('n', 'j', next_color)
    map('n', 'k', prev_color)

    return true
  end,
}

function colors()
  pickers.new(opts):find()
end

return require('telescope').register_extension({
  exports = {
    themes = colors,
  },
})
