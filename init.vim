set t_Co=256
if &t_Co > 256 || has("gui_running")
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
set encoding=utf-8

" Tabs are 2 spaces by default
set expandtab
set tabstop=2
set shiftwidth=2

" define a group `vimrc` and initialize.
" http://rbtnn.hateblo.jp/entry/2014/12/28/010913<Paste>
augroup vimrc
  autocmd!
augroup END

" Plugins installed by vim-plug
call plug#begin('~/.vim/plugged')

" Commenting and complex aligning
Plug 'junegunn/vim-easy-align'
Plug 'tomtom/tcomment_vim'
Plug 'Yggdroot/indentLine'

" Status line and buffer/tab line
Plug 'ap/vim-buftabline'

" Fuzzy finder for files, find-in-files...
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Theme
Plug 'morhetz/gruvbox'

" Syntax highlighting
Plug 'sheerun/vim-polyglot'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'ap/vim-css-color'

" Dev helpers (linting, project spacing...)
Plug 'editorconfig/editorconfig-vim'
Plug 'benekastah/neomake'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/vim-gitbranch'
Plug 'heavenshell/vim-jsdoc'
Plug 'shougo/deoplete.nvim'
Plug 'carlitux/deoplete-ternjs', { 'do': 'sudo npm i -g tern' }
Plug 'flowtype/vim-flow', { 'do': 'sudo npm i -g flow' }

" Autoclose braces and surround selection with braces...
Plug 'cohama/lexima.vim'
Plug 'tpope/vim-surround'

call plug#end()

" https://github.com/junegunn/fzf/issues/337
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'

" Map the leader key to SPACE
let mapleader="\<SPACE>"

" Allow JSX in normal JS files
let g:jsx_ext_required = 0

" Syntax highlighting for often used libraries
let g:used_javascript_libs = 'underscore,react,jquery'

" Set up ESLint for JS & JSX files & Style Lint for CSS
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_css_enabled_makers = ['stylelint']
let g:neomake_javascript_eslint_exe = './node_modules/.bin/eslint'
autocmd vimrc BufWritePost,BufEnter * Neomake " run Neomake on load/save
autocmd vimrc QuitPre * let g:neomake_verbose = 0 " don't run Neomake on :wq

" Theme configs
set background=dark
let g:gruvbox_italic=1
colorscheme gruvbox

" Style line numbers, gutter and 80char limit
set number
set relativenumber
set numberwidth=4
let g:buftabline_numbers=1
let g:gitgutter_sign_column_always = 1
set colorcolumn=80
highlight OverLength ctermbg=darkRed ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" Update Vim without restarting
map <leader>s :source ~/.config/nvim/init.vim<CR>

" Statusline
set noshowmode " disable mode because it comes from the custom statusline
source $HOME/dev/nvimrc/colors.vim
source $HOME/dev/nvimrc/statusline.vim

let g:neomake_warning_sign = {
\ 'texthl': 'User1',
\ }

let g:neomake_error_sign = {
\ 'texthl': 'ErrorMsg',
\ }

" Strip trailing whitespace
" TODO: add new line, change tabs to spaces
autocmd vimrc BufWritePre * :%s/\s\+$//e

" Use deoplete.
set completeopt-=preview " disable definitions
let g:deoplete#enable_at_startup = 1
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = 0

" Keyboard shortcuts
map <leader>o :Files <CR>
map gb :TCommentBlock<CR>

" :wq & :q close buffer instead of default actions
:cnoreabbrev wq w<bar>bd
:cnoreabbrev q bd
command! W write
command! Q quit

" Use system clipboard with <Leader>y & <Leader>p
" NOTE: nvim needs xsel for this to work
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
