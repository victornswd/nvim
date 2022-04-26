# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.1] - 2022-04-26

### Changed

- Forced **null-ls** to handle Lua formatting
- Fail silently if `packer_compiled` is not present
- Simplify install process

## [0.2.0] - 2022-04-22

### Changed

- Themes now use [NvChad](https://github.com/NvChad/NvChad) Base16 colorscheme and highlights
- Statusline plugin is now [Feline](https://github.com/feline-nvim/feline.nvim)
  instead of [Lualine](https://github.com/nvim-lualine/lualine.nvim) due to
  better color support from the theme
- [Mini.pairs](https://github.com/echasnovski/mini.nvim#minipairs) now handles
  auto-pairing brackets, parentheses etc.
- [Mini.comment](https://github.com/echasnovski/mini.nvim#minicomment) now handles commenting
- [Mini.tabline](https://github.com/echasnovski/mini.nvim#minitabline) now handles the buferlist
- Switched to [Neogen](https://github.com/danymat/neogen) for code annotations
- Changed mappings to the nvim default way. **which-key** is now used only for prompts

### Added

- [Termcolors](https://github.com/psliwka/termcolors.nvim) plugin to generate a
  theme for kitty terminal from the colorscheme
- [null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim) now handles
  formatting and linting with configs for JS, TS, lua, elm, bash. Formatters and
  linters need to be installed globally
- [Mini.Starter](https://github.com/echasnovski/mini.nvim#ministarter) for a startup dashboard
- [Mini.Sessions](https://github.com/echasnovski/mini.nvim#minisessions) for a session manager
- Added [Specs.nvim](https://github.com/edluffy/specs.nvim) for a visual nod on cursor jumps

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
