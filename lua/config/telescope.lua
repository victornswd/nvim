require('telescope').load_extension('fzf')
require('telescope').load_extension('vw')
require('telescope').load_extension('luasnip')
require('telescope').setup({
  defaults = {
    layout_config = {
      bottom_pane = {
        preview_cutoff = 0,
      },
    },
  },
  pickers = {
    git_files = { theme = 'ivy' },
    live_grep = { theme = 'ivy' },
    find_files = { theme = 'ivy' },
  }
})


