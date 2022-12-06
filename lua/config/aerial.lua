require("aerial").setup({
  backends = { "lsp", "treesitter", "markdown", "man" },
  layout = {
    min_width = 30,
  },
  show_guides = true,
  filter_kind = false,
  guides = {
    mid_item = "├ ",
    last_item = "└ ",
    nested_top = "│ ",
    whitespace = "  ",
  },
})
