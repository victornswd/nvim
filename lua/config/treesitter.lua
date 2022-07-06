require('base46').load_highlight('syntax')
require('base46').load_highlight('treesitter')

require('nvim-treesitter.install').compilers = { 'gcc' }
local ts = require('nvim-treesitter.configs')
ts.setup({
  ensure_installed = 'all',
  -- FIXME: check this issue https://github.com/claytonrcarter/tree-sitter-phpdoc/issues/15
  ignore_install = { 'phpdoc' },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true
  },
  indent = {
    enable = false
  },
  context_commentstring = {
    enable = true,
    -- enable_autocmd = false,
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
