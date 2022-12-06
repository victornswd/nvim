require("gitsigns").setup()
local i, j = string.find(vim.g.theme, "-NvChad")
if i then
  require("base46").load_highlight("git")
end
