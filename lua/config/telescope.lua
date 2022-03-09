require('telescope').setup({
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    prompt_prefix = '   ',
    selection_caret = '  ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'ascending',

    layout_strategy = 'bottom_pane',
    layout_config = {
      height = 25,
      bottom_pane = {
        preview_cutoff = 0,
      },
    },

    file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_ignore_patterns = { 'node_modules' },
    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    path_display = { 'truncate' },
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
  },
})

-- local extensions = { 'vw', 'luasnip', 'fzf', 'themes', 'terms'}
-- pcall(function()
--   for _, ext in ipairs(extensions) do
-- require'telescope'.load_extension(ext)
-- end
-- end)

require('telescope').load_extension('fzf')
require('telescope').load_extension('vw')
require('telescope').load_extension('luasnip')
