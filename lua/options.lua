local opt = vim.opt -- to set options
local g = vim.g -- a table to access global variables

g.loaded_gzip = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1

g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_2html_plugin = 1

g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1

-- g.loaded_netrw = 1
-- g.loaded_netrwPlugin = 1
-- g.loaded_netrwSettings = 1
-- g.loaded_netrwFileHandlers = 1

opt.completeopt = { "menuone", "noinsert", "noselect" }
opt.colorcolumn = { 80 }
opt.expandtab = false -- Preserve tabs
opt.number = true -- Show line numbers
opt.relativenumber = true -- Relative line numbers
opt.fileformat = "unix"
opt.mouse = "a"
opt.shiftwidth = 2 -- Size of an indent
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.wrap = false
-- opt.scrolloff = 4                   -- Lines of context
-- opt.shiftround = true               -- Round indent
-- opt.sidescrolloff = 8               -- Columns of context
opt.smartcase = true -- Do not ignore case with capitals
opt.smartindent = true -- Insert indents automatically
-- opt.splitbelow = true               -- Put new windows below current
-- opt.splitright = true               -- Put new windows right of current
-- opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
-- opt.hidden = true                  -- Enable background buffers
opt.ignorecase = true -- Ignore case
-- opt.joinspaces = false              -- No double spaces with join
opt.lazyredraw = true
opt.list = true
opt.fillchars:append({ eob = " " })
-- opt.listchars:append('eol:↴')
opt.updatetime = 300
opt.laststatus = 3
opt.signcolumn = "yes"
opt.showmode = false
opt.ruler = false
