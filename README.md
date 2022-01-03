
# nvim init.lua

## Prerequisites

* [Neovim](http://neovim.io/) 0.5+
* [ripgrep](https://github.com/BurntSushi/ripgrep) is required for string search
  in Telescope
* [Read this](https://github.com/tree-sitter/tree-sitter-haskell#building-on-macos) 
  if you are using this config on a Mac, or just disable `tree-sitter-haskell` 
  in the config
* [NerdFont](https://www.nerdfonts.com/font-downloads) with ligature support for
  the status line. I use FiraCode ;)
* `xclip`/`xsel` required on Linux for access to the global clipboard

## Getting started

* clone repo
* symlink init.lua & lua folder to your nvim config folder, by default:
  ```bash
  ln -s ~/<this repo location>/init.lua ~/.config/nvim/init.lua
  ln -s ~/<this repo location>/lua ~/.config/nvim/lua
  ```
* if they exist, remove `packer_compiled.lua` from `~/.config/nvim/plugin` or
  `~/.config/nvim/plugin` and `~/.local/share/nvim/site/`. If you don't want to 
  bother with this check the [Troubleshooting](#troubleshooting) section
* run `nvim --headless -u install.lua -c 'autocmd User PackerComplete quitall'`
* open nvim as normal
* enjoy!

## Some keybindings

| Keys                     | Action                           |
|------------------------- | -------------------------------- |
| `<Space>o`               | open files                       |
| `<Space>s`               | reload `init.lua`. Useful if you edited your nvim config and don't want to restart your nvim   |
| `<Space>t`               | open diagnostics list            |
| `<Tab>`/`<Shift><Tab>`   | navigate autocomplete            |
| `<Space>y`/`<Space>p`    | copy-paste to global clipboard   |

## Troubleshooting

**Installation failed**
If the installation failed you can just open nvim with `nvim -u install.lua` and
just run `:PackerSync` manually. This can also be ran if you currently have a
Packer based config and don't want to manually delete the plugin folder.
