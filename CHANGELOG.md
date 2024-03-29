# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.4.0] - 2023-03-02

### Removed

- Removed `Hop` because I wasn't using it

### Changed

- Changed `packer.nvim` to [`lazy.nvim`](https://github.com/folke/lazy.nvim)
- Modified install steps in `README`
- Toned down `emmet-ls` results in JSX/TSX
- Reduced the number of installed languages in Treesitter, with autoinstall

### Added

- Added `mini.bracketed` for new jumps
- Added [mason-null-ls](https://github.com/jay-babu/mason-null-ls.nvim) to keep
  null-ls sources in the same spot as mason
- Added auto-install and auto-setup of null-ls sources
- Added [Codeium](https://www.codeium.com/) support. **NOTE:** AI completion
  helpers are commented out in `plugins.lua`
- Added [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)
- Added [telescope-undo](https://github.com/debugloop/telescope-undo.nvim),
  which is similar to [undo-tree](https://github.com/debugloop/telescope-undo.nvim)
- Added [statuscol](https://github.com/luukvbaal/statuscol.nvim) for interactive
  column (nvim 0.9+)
- Added some Treesitter performance optimizations, thanks to
  [mars90226](https://github.com/mars90226/dotvim/blob/master/lua/vimrc/plugins/nvim_treesitter.lua#L349-L449)

## [0.3.1] - 2022-10-05

### Removed

- Removed `vim-import-cost` because it wasn't working

### Changed

- Testing no-wrap
- Change [StyLua](https://github.com/JohnnyMorganz/StyLua) rules to something
  closer to default
- Switch from [vim-easy-align](https://github.com/junegunn/vim-easy-align) to
  [mini-align](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-align.md)
- Switch to [LSP Zero](https://github.com/VonHeikemen/lsp-zero.nvim) to simplify
  LSP handling

### Added

- Added more ASCII art
- `<C-[1-4]>` goes to Harpoon position
- Added [boole.nvim](https://github.com/nat-418/boole.nvim) for more toggle
  options
- Added the `++p` flag to files saving to always create a new file even if
  folder in the path doesn't exist
- Added the [VimBeGood](https://github.com/ThePrimeagen/vim-be-good) game

## [0.3.0] - 2022-10-05

### Removed

- Removed `document-colors` in favor of the new & maintained `colorizer.lua`
- Removed the keymap for <C-l> because it is default behavior
- Removed `mini.session` in favor of `harpoon`

### Changed

- Simplified install procedure
- Switch navic to [aerial.nvim](https://github.com/stevearc/aerial.nvim)
- Move keymaps to each individual config file
- Indent-blankline updates
- Rearrange and clean up the plugin list

### Added

- [DAP](https://github.com/mfussenegger/nvim-dap),
  [DAP ui](https://github.com/rcarriga/nvim-dap-ui) & DAP for node
- Copilot. Requires account and setting up with `:Copilot setup`
- LSP for Astro, Prisma and SQL
- Show search occurence at the end of the line
- LSP diagnostic on hover
- LSP virtual text at the end of the line

## [0.2.2] - 2022-08-12

### Removed

- Removed support for Neovim 0.7 due to the enhancements on the 0.8 branch

### Changed

- Changed to the overhauled NvChad themes. Updated the theme switcher as well
- Switched LSP installer to the new
  [mason.nvim](https://github.com/williamboman/mason.nvim)
- Changed some LSP & completion settings
- Updated LSP settings to the default lspconfig behavior
- Changed feline status to a custom statusline

### Added

- [Harpoon](https://github.com/ThePrimeagen/harpoon) to better manage "marks"
- Configured the winbar. Still a WIP
- [nvim-navic](https://github.com/SmiteshP/nvim-navic) to show code context in
  the winbar

## [0.2.1] - 2022-04-26

### Changed

- Forced **null-ls** to handle Lua formatting
- Fail silently if `packer_compiled` is not present
- Simplify install process

## [0.2.0] - 2022-04-22

### Changed

- Themes now use [NvChad](https://github.com/NvChad/NvChad) Base16 colorscheme
  and highlights
- Statusline plugin is now [Feline](https://github.com/feline-nvim/feline.nvim)
  instead of [Lualine](https://github.com/nvim-lualine/lualine.nvim) due to
  better color support from the theme
- [Mini.pairs](https://github.com/echasnovski/mini.nvim#minipairs) now handles
  auto-pairing brackets, parentheses etc.
- [Mini.comment](https://github.com/echasnovski/mini.nvim#minicomment) now
  handles commenting
- [Mini.tabline](https://github.com/echasnovski/mini.nvim#minitabline) now
  handles the buferlist
- Switched to [Neogen](https://github.com/danymat/neogen) for code annotations
- Changed mappings to the nvim default way. **which-key** is now used only for
  prompts

### Added

- [Termcolors](https://github.com/psliwka/termcolors.nvim) plugin to generate a
  theme for kitty terminal from the colorscheme
- [null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim) now handles
  formatting and linting with configs for JS, TS, lua, elm, bash. Formatters and
  linters need to be installed globally
- [Mini.Starter](https://github.com/echasnovski/mini.nvim#ministarter) for a
  startup dashboard
- [Mini.Sessions](https://github.com/echasnovski/mini.nvim#minisessions) for a
  session manager
- Added [Specs.nvim](https://github.com/edluffy/specs.nvim) for a visual nod on
  cursor jumps

## [0.1.1] - 2022-02-11

### Changed

- Changed mappings to [which-key](https://github.com/folke/which-key.nvim) for
  better documentation and for the helpful prompts
- Changed the way autocomplete works:
  - no autoselect
  - replace with selection on mid-word autocompletH

### Added

- Buffer titles now show LSP indicators
- A more complete list of key mappings in README
- A screenshot of the project

## [0.1.0] - 2022-01-11

### Added

- Lua config
- Preference for Lua plugins
- Start up in under 50ms
- Built-in LSP with autoinstalls
- Autoinstall on first load (with the custom start command)
- Config in separate files for easier updating and experimenting
- Support for Neovim 0.6 & 0.7
