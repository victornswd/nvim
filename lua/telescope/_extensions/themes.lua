local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local sorters = require('telescope.sorters')

function next_color(prompt_bufnr)
  actions.move_selection_next(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd = 'colorscheme ' .. selected[1]
  vim.cmd(cmd)
end

function prev_color(prompt_bufnr)
  actions.move_selection_previous(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd = 'colorscheme ' .. selected[1]
  vim.cmd(cmd)
end

function enter(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd = 'colorscheme ' .. selected[1]
  vim.cmd(cmd)
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
