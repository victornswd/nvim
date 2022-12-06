-- you can configure Hop the way you like here; see :h hop-config
local hop = require("hop")
hop.setup()

vim.keymap.set("n", "<leader>/", hop.hint_patterns, { desc = "Hop Pattern" })
vim.keymap.set("n", "h", hop.hint_words, { desc = "Hop Word" })
vim.keymap.set("n", "l", hop.hint_lines, { desc = "Hop Line" })
vim.keymap.set("n", "s", hop.hint_char1, { desc = "Hop 1 Char" })
vim.keymap.set("n", "S", hop.hint_char2, { desc = "Hop 2 Char" })
