local function get_config(name)
  return string.format('require("config/%s")', name)
end

vim.cmd.packadd("packer.nvim")

local use = require("packer").use
require("packer").startup({
  function()
    -- Package manager and internal dependencies
    use({ "wbthomason/packer.nvim", opt = true })

    use({ "lewis6991/impatient.nvim" })
    use({ "kyazdani42/nvim-web-devicons" })
    use({ "nvim-lua/plenary.nvim" })
    use({ "stevearc/dressing.nvim" })

    -- Themes
    use({ "victornswd/base46" })

    -- Treesitter
    use({
      "nvim-treesitter/nvim-treesitter",
      config = get_config("treesitter"),
      run = ":TSUpdate",
      event = "User ActuallyEditing",
    })
    use({ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" })
    use({ "andymass/vim-matchup", config = get_config("matchup"), after = "nvim-treesitter" })
    use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      after = "nvim-treesitter",
      config = get_config("todo-comments"),
    })
    use({
      "JoosepAlviste/nvim-ts-context-commentstring",
      after = "nvim-treesitter",
    })

    -- Dev helpers (documentation, pickers, editor config, etc)
    use({
      "nvim-telescope/telescope.nvim",
      config = get_config("telescope"),
      requires = {
        { "ElPiloto/telescope-vimwiki.nvim" },
        { "benfowler/telescope-luasnip.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      },
      event = "User ActuallyEditing",
    })
    use({ "gpanders/editorconfig.nvim", event = "User ActuallyEditing" })
    use({
      "danymat/neogen",
      config = get_config("neogen"),
      requires = "nvim-treesitter/nvim-treesitter",
      keys = "<Leader>dd",
    })
    use({ "vimwiki/vimwiki", branch = "dev", event = "User ActuallyEditing" })

    -- UI flourishes
    use({
      "lukas-reineke/indent-blankline.nvim",
      config = get_config("indent-blankline"),
      event = "User ActuallyEditing",
    })
    use({
      "NvChad/nvim-colorizer.lua",
      config = get_config("colorizer"),
      ft = { "css", "javascript", "vim", "html", "lua", "typescript", "typescriptreact", "react", "astro" },
    })
    use({
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = get_config("gitsigns"),
      after = "nvim-treesitter",
    })
    use({
      "stevearc/aerial.nvim",
      config = get_config("aerial"),
    })
    use({ "edluffy/specs.nvim", config = get_config("specs") })

    -- DX flourishes
    use({ "ThePrimeagen/harpoon", requires = "nvim-lua/plenary.nvim" })
    use({ "ojroques/nvim-bufdel" })
    use({
      "phaazon/hop.nvim",
      config = get_config("hop"),
      event = "User ActuallyEditing",
    })
    use({
      "echasnovski/mini.nvim",
      config = function()
        require("config.mini-starter")
        vim.defer_fn(function()
          require("config.mini-comment")
          require("config.mini-pairs")
          require("config.mini-surround")
          require("config.mini-tabline")
          require("config.mini-ai")
          require("config.mini-align")
        end, 10)
      end,
    })
    use({
      "folke/which-key.nvim",
      config = get_config("which-key"),
      event = "User ActuallyEditing",
    })
    use({
      "nat-418/boole.nvim",
      config = get_config("boole"),
    })

    -- Command loaded plugins
    use({ "tweekmonster/startuptime.vim", cmd = "StartupTime" })
    use({ "psliwka/termcolors.nvim", cmd = "TermcolorsShow" })
    use({ "ThePrimeagen/vim-be-good", opt = true, cmd = "VimBeGood" })

    -- LSP Zero
    use({
      "VonHeikemen/lsp-zero.nvim",
      config = get_config("lsp-zero"),
      requires = {
        -- LSP Support
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },

        -- Autocompletion
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua" },

        -- Snippets
        { "L3MON4D3/LuaSnip" },
        { "rafamadriz/friendly-snippets" },
      },
    })

    use({
      "ray-x/lsp_signature.nvim",
      "jose-elias-alvarez/typescript.nvim",
      after = "nvim-lspconfig",
    })
    use({
      "jose-elias-alvarez/null-ls.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "neovim/nvim-lspconfig",
      },
    })
    use({
      "zbirenbaum/copilot.lua",
      config = get_config("copilot"),
      event = "InsertEnter",
    })
    use("marilari88/twoslash-queries.nvim")

    -- Debugging
    use({
      "mfussenegger/nvim-dap",
    })
    use({
      "mxsdev/nvim-dap-vscode-js",
      wants = "vscode-js-debug",
      requires = { "mfussenegger/nvim-dap" },
      after = { "nvim-dap" },
    })
    use({
      "rcarriga/nvim-dap-ui",
      config = get_config("dap"),
      keys = "<Leader>db",
    })
    use({
      "microsoft/vscode-js-debug",
      opt = true,
      run = 'npm install --legacy-peer-deps && npm run compile',
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if _G.packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
    max_jobs = 20,
    git = {
      clone_timeout = 100, -- Timeout, in seconds, for git clones
    },
  },
})
