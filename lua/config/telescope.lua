local i, _ = string.find(vim.g.theme, "-NvChad")
if i then
  require("base46").load_highlight("telescope")
end

local ok, telescope = pcall(require,"telescope")
if not ok then
  return
end

telescope.setup({
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",

    layout_strategy = "bottom_pane",
    layout_config = {
      height = 25,
      bottom_pane = {
        preview_cutoff = 0,
      },
    },

    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
  },
})

-- local extensions = { 'vw', 'luasnip', 'fzf', 'themes', 'terms'}
-- pcall(function()
--   for _, ext in ipairs(extensions) do
-- require'telescope'.load_extension(ext)
-- end
-- end)

require("telescope").load_extension("fzf")
require("telescope").load_extension("vw")
require("telescope").load_extension("luasnip")
require("telescope").load_extension("themes")

-- keymap

_G.project_files = function()
  local opts = {} -- define here if you want to define something
  vim.fn.system("git rev-parse --is-inside-work-tree")
  if vim.v.shell_error == 0 then
    require("telescope.builtin").git_files(opts)
  else
    require("telescope.builtin").find_files(opts)
  end
end

vim.keymap.set("n", "<leader>f", function()
  pcall(require("telescope.builtin").live_grep)
end, { desc = "Search for word in folder" })
vim.keymap.set("n", "<leader>h", function()
  pcall(require("telescope.builtin").keymaps)
end, { desc = "Show key maps" })
vim.keymap.set("n", "<leader>c", function()
  pcall(require("telescope").extensions.themes.themes)
end, { desc = "Colorschemes" })

vim.keymap.set("n", "<leader>t", function()
  pcall(require("telescope.builtin").diagnostics(), { bufnr = 0 })
end, { desc = "Show file diagnostics" })
vim.keymap.set("n", "<leader>o", project_files, { desc = "Open file search" })
