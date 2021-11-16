-------------------- HELPERS -------------------------------
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to callnged the default  Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

g.mapleader=' '

-------------------- PLUGINS -------------------------------
-- Install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if fn.empty(vim.fn.glob(install_path)) > 0 then
  fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager

  use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end}
  use {'junegunn/fzf.vim'}

  -- Commenting and complex aligning
  use {'junegunn/vim-easy-align'}
  use {'tpope/vim-repeat'}
  use {'tomtom/tcomment_vim'}
  use {'Yggdroot/indentLine'}

  -- Autoclose braces and surround selection with braces...
  use {'cohama/lexima.vim'}
  use {'tpope/vim-surround'}
  use {'andymass/vim-matchup'}

  -- Theme
  use {'morhetz/gruvbox'}

  -- Statusline
  use {'hoob3rt/lualine.nvim'}
  use {'kyazdani42/nvim-web-devicons'}
  use {'ap/vim-buftabline'}
  use {'ojroques/nvim-bufdel'}

  -- Autocompletion
  use {'neovim/nvim-lspconfig'}
  use {'williamboman/nvim-lsp-installer'}
  use {'glepnir/lspsaga.nvim'}
  -- use 'hrsh7th/cmp-nvim-lsp'
  -- use 'hrsh7th/cmp-buffer'
  -- use 'hrsh7th/cmp-path'
  -- use 'hrsh7th/cmp-cmdline'
  -- use 'hrsh7th/nvim-cmp'

  -- use 'hrsh7th/cmp-vsnip'
  -- use 'hrsh7th/vim-vsnip'
  -- use 'L3MON4D3/LuaSnip'
  -- use 'saadparwaiz1/cmp_luasnip'
  --
  -- use 'jose-elias-alvarez/null-ls.nvim'


  --- Lsp
  use({
      -- 'neovim/nvim-lspconfig',
      'ray-x/lsp_signature.nvim',
      'jose-elias-alvarez/nvim-lsp-ts-utils',
  })

  use({
      'jose-elias-alvarez/null-ls.nvim',
      requires = {
          'nvim-lua/plenary.nvim',
          'neovim/nvim-lspconfig',
      },
  })

  -- Completion
  use({
      'hrsh7th/nvim-cmp',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'lukas-reineke/cmp-rg',
  })
  use 'creativenull/diagnosticls-configs-nvim'

  -- Snippets
  use({
      'L3MON4D3/luasnip',
      requires = {
          'rafamadriz/friendly-snippets',
      },
  })

  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {'ojroques/nvim-lspfuzzy'}
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end
  }

  -- Syntax
  use {
    'norcalli/nvim-colorizer.lua',
    ft = { 'css', 'javascript', 'vim', 'html' },
    config = [[require('colorizer').setup {'css', 'javascript', 'vim', 'html'}]],
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function () require('gitsigns').setup() end
  }

  -- Dev helpers (linting, project spacing...)
  use {'editorconfig/editorconfig-vim'}
  use {'mattn/emmet-vim'}
  use {
    'yardnsm/vim-import-cost',
    run = 'npm install',
    ft = {'javascript', 'javascript.jsx','typescript'}
  }
  use {
    'heavenshell/vim-jsdoc',
    run = 'make install',
    ft = {'javascript', 'javascript.jsx','typescript'}
  }
  use {
    'prettier/vim-prettier',
    run = 'npm install',
    ft = {'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'}
  }
  use { 'vimwiki/vimwiki', branch = 'dev' }

end)
-------------------- OPTIONS -------------------------------
cmd 'colorscheme gruvbox'            -- Put your favorite colorscheme here
opt.completeopt = {'menuone', 'noinsert', 'noselect'}  -- Completion options (for deoplete)
opt.colorcolumn = {80}
opt.expandtab = true                -- Use spaces instead of tabs
opt.number = true                   -- Show line numbers
opt.relativenumber = true           -- Relative line numbers
opt.fileformat = 'unix'
opt.mouse = 'a'
opt.shiftwidth = 2                  -- Size of an indent
opt.tabstop = 2                     -- Number of spaces tabs count for
opt.termguicolors = true            -- True color support
opt.wrap = true
-- opt.scrolloff = 4                   -- Lines of context
-- opt.shiftround = true               -- Round indent
-- opt.sidescrolloff = 8               -- Columns of context
-- opt.smartcase = true                -- Do not ignore case with capitals
opt.smartindent = true              -- Insert indents automatically
-- opt.splitbelow = true               -- Put new windows below current
-- opt.splitright = true               -- Put new windows right of current
-- opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
-- opt.hidden = true                  -- Enable background buffers
-- opt.ignorecase = true               -- Ignore case
-- opt.joinspaces = false              -- No double spaces with join
-- opt.list = true                     -- Show some invisible characters

-------------------- MAPPINGS ------------------------------
-- https://github.com/junegunn/fzf/issues/337
cmd [[let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""']]

map('v', '<leader>y', '"+y')       -- Copy to clipboard in visual modes
map('n', '<leader>p', '"+p')       -- Copy to clipboard in visual modes

map('i', '<C-w>', '<C-g>u<C-w>')  -- Make <C-w> undo-friendly
-- <Tab> to navigate the completion menu
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

map('n', '<C-l>', '<cmd>noh<CR>')    -- Clear highlights
map('c', 'W', 'w')
map('', '<leader>o', ':Files <CR>')
map('', '<leader>b', ':Buffers <CR>')
map('n', '<leader>s', ':source ~/.config/nvim/init.lua<CR>')
map('', '<leader>t', ':TroubleToggle<CR>')
cmd [[
:cnoreabbrev wq w<bar>BufDel
:cnoreabbrev q BufDel
:cnoreabbrev Q q
]]

-------------------- TREE-SITTER ---------------------------
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
    enable = true
  },
  matchup = {
    enable = true,              -- mandatory, false will disable the whole extension
  }
}

-------------------- LSP -----------------------------------
require('lsp')
------------------------------------------------------------

require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-------------------- COMMANDS ------------------------------
vim.api.nvim_set_var('jsdoc_formatter', 'tsdoc')
cmd 'au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}'

-- don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]
-- disable IndentLine for markdown files (avoid concealing)
cmd [[autocmd FileType markdown let g:indentLine_enabled=0]]