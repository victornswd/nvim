vim.g.copilot_filetypes = { xml = false, markdown = false }

-- Show copilot suggestion as ghost text but still use tab with cmp
-- <C-a> will autofill the copilot suggestion
vim.g.copilot_no_tab_map = true

-- vim.cmd([[ imap <silent><script><expr> <C-a> copilot#Accept("\<CR>") ]])
vim.keymap.set('i', '<C-a>', 'copilot#Accept("\\<CR>")', { silent = true, expr = true, script = true })

-- <C-]>                   Dismiss the current suggestion.
-- <M-]>                   Cycle to the next suggestion, if one is available.
-- <M-[>                   Cycle to the previous suggestion.

-- random number