require'telescope'.setup({
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

local extensions = { 'vw', 'luasnip', 'fzf' }
pcall(function()
   for _, ext in ipairs(extensions) do
      require'telescope'.load_extension(ext)
   end
end)
