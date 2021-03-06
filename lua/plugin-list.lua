local function get_config(name)
  return string.format('require("config/%s")', name)
end

vim.cmd([[packadd packer.nvim]])

local use = require('packer').use
require('packer').startup({
  function()
    use({ 'wbthomason/packer.nvim', opt = true }) -- Package manager

    use('lewis6991/impatient.nvim')
    use('nvim-lua/plenary.nvim')
    use({ 'stevearc/dressing.nvim' })
    use({ 'tweekmonster/startuptime.vim', cmd = 'StartupTime' })
    use({
      'folke/which-key.nvim',
      config = get_config('which-key'),
      event = 'User ActuallyEditing',
    })

    use({ 'psliwka/termcolors.nvim', cmd = 'TermcolorsShow' })

    use({
      'nvim-telescope/telescope.nvim',
      config = get_config('telescope'),
      requires = {
        { 'ElPiloto/telescope-vimwiki.nvim' },
        { 'benfowler/telescope-luasnip.nvim' },
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      },
      event = 'User ActuallyEditing',
    })

    -- Commenting and complex aligning
    use({ 'junegunn/vim-easy-align', cmd = { 'EasyAlign', 'LiveEasyAlign' } })
    use({ 'tpope/vim-repeat', event = 'User ActuallyEditing' })
    use({ 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' })
    use({
      'phaazon/hop.nvim',
      config = get_config('hop'),
      event = 'User ActuallyEditing',
    })
    use({
      'lukas-reineke/indent-blankline.nvim',
      -- after = 'rose-pine',
      config = get_config('indent-blankline'),
      event = 'User ActuallyEditing',
    })

    -- Autoclose braces and surround selection with braces...
    -- use({ 'tpope/vim-surround', event = 'User ActuallyEditing' })
    use({
      'echasnovski/mini.nvim',
      config = function()
        require('config.mini-comment')
        require('config.mini-starter')
        require('config.mini-pairs')
        require('config.mini-surround')
        require('config.mini-session')
        require('config.mini-tabline')
      end,
    })

    -- Themes
    use({ 'victornswd/base46' })
    use({ 'wbthomason/vim-nazgul', event = 'User ActuallyEditing' })
    use({
      'rose-pine/neovim',
      as = 'rose-pine',
      event = 'User ActuallyEditing',
    })

    -- Statusline
    use({ 'kyazdani42/nvim-web-devicons' })
    use({ 'ojroques/nvim-bufdel' })

    use({
      'hrsh7th/nvim-cmp',
      requires = {
        { 'hrsh7th/cmp-nvim-lua' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer' },
        { 'L3MON4D3/luasnip' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'rafamadriz/friendly-snippets' },
        { 'hrsh7th/cmp-path' },
        { 'lukas-reineke/cmp-rg' },
        { 'williamboman/nvim-lsp-installer', config = get_config('lsp.installer') },
        { 'neovim/nvim-lspconfig', config = get_config('lsp.config') },
      },
      config = get_config('cmp-conf'),
    })
    use({
      'ray-x/lsp_signature.nvim', -- NOTE: is this plugin helpful or distracting?
      'jose-elias-alvarez/nvim-lsp-ts-utils',
      after = 'nvim-lspconfig',
    })

    use({
      'jose-elias-alvarez/null-ls.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'neovim/nvim-lspconfig',
      },
      -- after = 'neovim/nvim-lspconfig',
      config = get_config('null-ls'),
    })

    use({
      'nvim-treesitter/nvim-treesitter',
      config = get_config('treesitter'),
      run = ':TSUpdate',
      event = 'BufRead',
      -- event = 'User ActuallyEditing'
    })
    use({ 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' })
    use({ 'andymass/vim-matchup', after = 'nvim-treesitter' })
    use({
      'folke/todo-comments.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = get_config('todo-comments'),
      -- event = 'BufRead'
      event = 'User ActuallyEditing',
    })
    -- TODO: see if Trouble is still required
    -- use {
    --   "folke/trouble.nvim",
    --   requires = "kyazdani42/nvim-web-devicons",
    --   config = function()
    --     require("trouble").setup()
    --   end
    -- }

    -- Syntax
    use({
      'norcalli/nvim-colorizer.lua',
      config = get_config('colorizer'),
      ft = { 'css', 'javascript', 'vim', 'html', 'lua' },
    })
    use({
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = get_config('gitsigns'),
      after = 'nvim-treesitter',
    })

    -- Dev helpers (linting, project spacing...)
    use({ 'editorconfig/editorconfig-vim', event = 'User ActuallyEditing' })
    use({
      'yardnsm/vim-import-cost',
      run = 'npm install',
      ft = { 'javascript', 'javascript.jsx', 'typescript' },
      cmd = 'ImportCost',
    })
    use({
      'danymat/neogen',
      config = get_config('neogen'),
      requires = 'nvim-treesitter/nvim-treesitter',
      after = 'nvim-treesitter',
    })
    use({ 'vimwiki/vimwiki', branch = 'dev', event = 'User ActuallyEditing' })
    use({ 'ThePrimeagen/harpoon', requires = 'nvim-lua/plenary.nvim' })
    use({ 'edluffy/specs.nvim', config = get_config('specs') })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if _G.packer_bootstrap then
      require('packer').sync()
    end
  end,
  config = {
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath('config') .. '/lua/packer_compiled.lua',
    max_jobs = 20,
    git = {
      clone_timeout = 100, -- Timeout, in seconds, for git clones
    },
  },
})
