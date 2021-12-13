-------------------- HELPERS -------------------------------
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

g.mapleader=' '

-------------------- PLUGINS -------------------------------
-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]

require('colors')

-------------------- OPTIONS -------------------------------
opt.completeopt = {'menuone', 'noinsert', 'noselect'}  -- Completion options (for deoplete)
opt.colorcolumn = {80}
opt.expandtab = true                -- Use spaces instead of tabs
opt.number = true                   -- Show line numbers
opt.relativenumber = true           -- Relative line numbers
opt.fileformat = 'unix'
opt.mouse = 'a'
opt.shiftwidth = 2                  -- Size of an indent
opt.tabstop = 2                     -- Number of spaces tabs count for
opt.termguicolors = true            -- True color support
opt.wrap = true
-- opt.scrolloff = 4                   -- Lines of context
-- opt.shiftround = true               -- Round indent
-- opt.sidescrolloff = 8               -- Columns of context
-- opt.smartcase = true                -- Do not ignore case with capitals
opt.smartindent = true              -- Insert indents automatically
-- opt.splitbelow = true               -- Put new windows below current
-- opt.splitright = true               -- Put new windows right of current
-- opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
-- opt.hidden = true                  -- Enable background buffers
-- opt.ignorecase = true               -- Ignore case
-- opt.joinspaces = false              -- No double spaces with join
opt.list = true
opt.fillchars:append { eob = " " }
-- opt.listchars:append("eol:↴")
cmd [[set signcolumn=yes]]

-------------------- TELESCOPE ------------------------------
require('telescope').load_extension('fzf')
require('telescope').load_extension('vw')
require('telescope').load_extension('luasnip')
require('telescope').setup({
  defaults = {
    layout_config = {
      bottom_pane = {
        preview_cutoff = 0,
      },
    },
  },
  pickers = {
    git_files = { theme = 'ivy' },
    live_grep = { theme = 'ivy' },
    find_files = { theme = 'ivy' },
  }
})

-------------------- MAPPINGS ------------------------------
_G.project_files = function()
  local opts = {}
  local ok = pcall(require"telescope.builtin".git_files, opts)
  if not ok then require"telescope.builtin".find_files(opts) end
end

map('v', '<leader>y', '"+y')       -- Copy to clipboard in visual modes
map('n', '<leader>p', '"+p')       -- Copy to clipboard in visual modes

map('i', '<C-w>', '<C-g>u<C-w>')  -- Make <C-w> undo-friendly
-- <Tab> to navigate the completion menu
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

map('n', '<C-l>', '<cmd>noh<CR>')    -- Clear highlights
map('c', 'W', 'w')
map('', '<leader>o', '<cmd>lua project_files()<CR>')
map('', '<leader>c', ':Telescope colorscheme <CR>')
map('', '<leader>f', ':Telescope live_grep <CR>')
map('n', '<leader>s', ':source ~/.config/nvim/init.lua<CR>')
map('', '<leader>t', ':Telescope diagnostics bufnr=0<CR>')
cmd [[
:cnoreabbrev wq w<bar>BufDel
:cnoreabbrev q BufDel
:cnoreabbrev Q q
]]

-------------------- TREE-SITTER ---------------------------
require('treesitter')

-------------------- LSP -----------------------------------
require('lsp.config')
require('cmp-conf')

-------------------- LUALINE -------------------------------
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'rose-pine',
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch',
                  {'diagnostics', sources={'nvim_diagnostic'}, colored = true}},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

--------------------- VIMWIKI ------------------------------
cmd [[
let g:vimwiki_list = [{'path': '~/Dropbox/wiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0
]]

-------------------- COMMANDS ------------------------------
vim.api.nvim_set_var('jsdoc_formatter', 'tsdoc')
cmd 'au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}'

-- don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]
-- disable IndentLine for markdown files (avoid concealing)
cmd [[autocmd FileType markdown let g:indentLine_enabled=0]]
