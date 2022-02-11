# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
