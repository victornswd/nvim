local i, _ = string.find(vim.g.theme, "-NvChad")
if i then
  require("base46").load_highlight("whichkey")
end

require("which-key").setup({
  -- triggers_blacklist = {
  --   i = { '<leader>', 'space', 'j', 'k' },
  --   v = { 'j', 'k' },
  -- },
})
