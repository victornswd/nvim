local use = require('packer').use
require('packer').startup{function()
  use 'wbthomason/packer.nvim' -- Package manager

  use 'lewis6991/impatient.nvim'
  use 'tweekmonster/startuptime.vim'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {'ElPiloto/telescope-vimwiki.nvim' }
  use 'benfowler/telescope-luasnip.nvim'

  -- Commenting and complex aligning
  use {'junegunn/vim-easy-align'}
  use {'tpope/vim-repeat'}
  use {'b3nj5m1n/kommentary',
    config = function()
      require('kommentary.config').configure_language("default", {
      prefer_single_line_comments = true,
    })
    end
  }
  use {
    'phaazon/hop.nvim',
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }
  use {'lukas-reineke/indent-blankline.nvim'}

  -- Autoclose braces and surround selection with braces...
  use {'windwp/nvim-autopairs',
    config = function ()
      require('nvim-autopairs').setup(
        { enable_check_bracket_line = false }
      )
    end
  }
  use {'tpope/vim-surround'}

  -- Themes
  use {'wbthomason/vim-nazgul'}
  use {'rafamadriz/themes.nvim'}
  use({
    'rose-pine/neovim',
    as = 'rose-pine',
  })

  -- Statusline
  use {'hoob3rt/lualine.nvim', after = 'rose-pine'}
  use {'kyazdani42/nvim-web-devicons', event = 'VimEnter'}
  use {'ap/vim-buftabline', event = 'VimEnter'}
  use {'ojroques/nvim-bufdel', event = 'VimEnter'}

  -- Autocompletion
  use {'neovim/nvim-lspconfig'}
  use {'williamboman/nvim-lsp-installer'}
  use({
      'ray-x/lsp_signature.nvim', -- FIXME: set it up
      'jose-elias-alvarez/nvim-lsp-ts-utils', --  FIXME: set it up
  })
  -- TODO: write an actual config for null-ls
  -- use({
  --   'jose-elias-alvarez/null-ls.nvim',
  --   requires = {
  --     'nvim-lua/plenary.nvim',
  --     'neovim/nvim-lspconfig',
  --   },
  -- })

  -- Completion
  use({
    'hrsh7th/nvim-cmp',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lua',
    'lukas-reineke/cmp-rg',
    event = 'InsertEnter'
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
  use {'p00f/nvim-ts-rainbow'}
  use {'andymass/vim-matchup'}
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end,
    event = 'VimEnter'
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
    config = [[require('colorizer').setup {'css', 'javascript', 'vim', 'html', lua}]],
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function () require('gitsigns').setup() end
  }

  -- Dev helpers (linting, project spacing...)
  use {'editorconfig/editorconfig-vim'}
  use {
    'yardnsm/vim-import-cost',
    run = 'npm install',
    ft = {'javascript', 'javascript.jsx','typescript'}
  }
  use {
    'heavenshell/vim-jsdoc', -- FIXME: switch to vim-doge
    run = 'make install',
    ft = {'javascript', 'javascript.jsx','typescript'}
  }
  -- use {
  --   'prettier/vim-prettier',
  --   run = 'npm install',
  --   ft = {'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'}
  -- }
  use { 'vimwiki/vimwiki', branch = 'dev', event = 'VimEnter' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if _G.packer_bootstrap then
    require('packer').sync()
  end

end,
config = {
  -- Move to lua dir so impatient.nvim can cache it
  compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua',
  profile = {
    enable = true,
    threshold = 1
  }
}
}
