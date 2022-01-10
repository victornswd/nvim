local function get_config(name)
  return string.format('require("config/%s")', name)
end

local use = require('packer').use
require('packer').startup{function()
  use 'wbthomason/packer.nvim' -- Package manager

  use 'lewis6991/impatient.nvim'
  use 'nathom/filetype.nvim'
  use 'nvim-lua/plenary.nvim'
  use {'tweekmonster/startuptime.vim', cmd = 'StartupTime'}

  use {
    'nvim-telescope/telescope.nvim',
    config = get_config('telescope'),
    requires = {
      {'ElPiloto/telescope-vimwiki.nvim', after = 'telescope.nvim'},
      {'benfowler/telescope-luasnip.nvim', after = 'telescope.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim' , run ='make', after = 'telescope.nvim'}
    },
    cmd = {'lua require"telescope.builtin"', 'lua project_files()', 'Telescope'}
  }

  -- Commenting and complex aligning
  use {'junegunn/vim-easy-align', cmd = 'EasyAlign'}
  use {'tpope/vim-repeat', event = 'BufEnter'}
  use {'JoosepAlviste/nvim-ts-context-commentstring',
    after = 'nvim-treesitter'
  }
  use {'terrortylor/nvim-comment',
    config = get_config('comment'),
    after = 'nvim-ts-context-commentstring'
  }
  use {
    'phaazon/hop.nvim',
    config = get_config('hop'),
    cmd = {'HopWord', 'HopLine'}
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    after = 'rose-pine',
    config = get_config('indent-blankline'),
  }

  -- Autoclose braces and surround selection with braces...
  use {'windwp/nvim-autopairs',
    config = get_config('autopairs'),
    event = 'BufRead',
  }
  use {'tpope/vim-surround', event = 'BufRead'}

  -- Themes
  use {'wbthomason/vim-nazgul'}
  use {'rafamadriz/themes.nvim'}
  use({
    'rose-pine/neovim',
    as = 'rose-pine',
  })

  -- Statusline
  use {'hoob3rt/lualine.nvim',
    config = get_config('lualine'),
    after = 'rose-pine'
  }
  use {'kyazdani42/nvim-web-devicons'}
  use {'ap/vim-buftabline', event = 'BufAdd'} -- FIXME: change w/ lua
  use {'ojroques/nvim-bufdel'}

  -- TODO: write an actual config for null-ls
  -- use({
  --   'jose-elias-alvarez/null-ls.nvim',
  --   requires = {
  --     'nvim-lua/plenary.nvim',
  --     'neovim/nvim-lspconfig',
  --   },
  --   after="nvim-lspconfig"
  -- })

  use({
    'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/cmp-nvim-lua'},
      { 'hrsh7th/cmp-nvim-lsp'},
      { 'hrsh7th/cmp-buffer'},
      { 'L3MON4D3/luasnip'},
      { 'saadparwaiz1/cmp_luasnip'},
      { 'rafamadriz/friendly-snippets'},
      { 'hrsh7th/cmp-path'},
      {'lukas-reineke/cmp-rg'},
      {'williamboman/nvim-lsp-installer', config = get_config('lsp.config')},
      {'neovim/nvim-lspconfig', config = get_config('lsp.installer')}
    },
    config = get_config('cmp-conf'),
    -- event = 'InsertEnter'
  })

  use {'nvim-treesitter/nvim-treesitter',
    config = get_config('treesitter'),
    run = ':TSUpdate',
    event = 'BufRead'
  }
  use {'p00f/nvim-ts-rainbow', after = 'nvim-treesitter'}
  use {'andymass/vim-matchup', after = 'nvim-treesitter'}
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = get_config('todo-comments'),
    event = 'BufRead'
  }
  -- TODO: see if Trouble is still required
  -- use {
  --   "folke/trouble.nvim",
  --   requires = "kyazdani42/nvim-web-devicons",
  --   config = function()
  --     require("trouble").setup()
  --   end
  -- }

  -- Syntax
  use {
    'norcalli/nvim-colorizer.lua',
    config = get_config('colorizer'),
    ft = {'css', 'javascript', 'vim', 'html', 'lua'}
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = get_config('gitsigns'),
    after = 'nvim-treesitter'
  }

  -- Dev helpers (linting, project spacing...)
  use {'editorconfig/editorconfig-vim', event = 'BufRead'}
  use {
    'yardnsm/vim-import-cost',
    run = 'npm install',
    ft = {'javascript', 'javascript.jsx','typescript'},
    cmd = 'ImportCost'
  }
  use {
    'kkoomen/vim-doge',
    run = function ()
      vim.fn['doge#install']()
    end,
    ft = {'javascript', 'javascript.jsx','typescript', 'php', 'python'}
  }
  use { 'vimwiki/vimwiki',
    branch = 'dev',
    event = 'VimEnter'
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if _G.packer_bootstrap then
    require('packer').sync()
  end

end,
config = {
  -- Move to lua dir so impatient.nvim can cache it
  compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua',
  max_jobs = 100,
  profile = {
    enable = true,
    threshold = 1
  }
}
}
