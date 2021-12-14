local packer = nil
local function init()
  if packer == nil then
    packer = require 'packer'
    packer.init { disable_commands = true }
  end

  local use = require('packer').use
  require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- Package manager

    use 'lewis6991/impatient.nvim'
    use 'dstein64/vim-startuptime'

    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use {'ElPiloto/telescope-vimwiki.nvim' }

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
    use {'lukas-reineke/indent-blankline.nvim'}

    -- Autoclose braces and surround selection with braces...
    use {'cohama/lexima.vim'}
    use {'tpope/vim-surround'}

    -- Theme
    use {'wbthomason/vim-nazgul'}
    use {'rafamadriz/themes.nvim'}
    use({
      'rose-pine/neovim',
      as = 'rose-pine',
    })

    -- Statusline
    use {'hoob3rt/lualine.nvim'}
    use {'kyazdani42/nvim-web-devicons'}
    use {'ap/vim-buftabline'}
    use {'ojroques/nvim-bufdel'}

    -- Autocompletion
    use {'neovim/nvim-lspconfig'}
    use {'williamboman/nvim-lsp-installer'}
    use({
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
    use {
      "benfowler/telescope-luasnip.nvim"
    }

    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {'p00f/nvim-ts-rainbow'}
    use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup()
      end
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
      -- ft = { 'css', 'javascript', 'vim', 'html' },
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
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
