require 'nvim-treesitter.install'.compilers = { "gcc" }
local ts = require 'nvim-treesitter.configs'
ts.setup {
  ensure_installed = 'all',
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true
  },
  indent = {
    enable = false
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  matchup = {
    enable = true,   -- mandatory, false will disable the whole extension
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}
