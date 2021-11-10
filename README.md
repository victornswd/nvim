
# nvim init.lua

## Prerequisites

* [Silver Searcher](https://github.com/ggreer/the_silver_searcher) for file 
  searching inside FZF
* [Read this](https://github.com/tree-sitter/tree-sitter-haskell#building-on-macos) 
  if you are using this config on a Mac, or just disable `tree-sitter-haskell` 
  in the config
* [NerdFont](https://www.nerdfonts.com/font-downloads) with ligature support for
  the status line. I use FiraCode ;)
* `xclip`/`xsel` required on Linux for access to the global clipboard

## Getting started

* clone repo
* symlink init.lua & lua folder to your nvim config folder, by default:
  ```
  ln -s ~/<this repo location>/init.lua ~/.config/nvim/init.lua
  ln -s ~/<this repo location>/lua ~/.config/nvim/lua
  ```
* open nvim and ignore the errors (for now)
* run `:PackerInstall` and wait for it to finish
* restart nvim
* run `:LspInstallInfo` and select what [LSP](https://microsoft.github.io/language-server-protocol/)
  you want (navigate menu with `↑, ↓/j, k`, install with `i`, uninstall with `X`)
* enjoy!

## Some keybindings

* `<Space>o` - open files
* `<Space>s` - reload `init.lua`. Useful if you edited your nvim config and don't 
  want to restart your nvim
* `<Space>t` - open diagnostics list
* `<Tab>` - navigate autocomplete
* `<Space>y`/`<Space>p` - copy-paste to global clipboard


## TODO:

* fix lsp icons
* clean up commented stuff
* Trouble/lsp side flicker
* lsp keys
* research Neorg
* LSP servers installer only one array
* null-ls?
