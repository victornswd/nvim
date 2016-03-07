set nocompatible
set t_Co=256
set encoding=utf-8
filetype off

" define a group `vimrc` and initialize.
" http://rbtnn.hateblo.jp/entry/2014/12/28/010913<Paste>
augroup vimrc
  autocmd!
augroup END

" Plugins installed by vim-plug
call plug#begin('~/.vim/plugged')

" Commenting and complex aligning
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'

" Status line and buffer/tab line
Plug 'itchyny/lightline.vim'

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
Plug 'ternjs/tern_for_vim'
Plug 'Valloric/YouCompleteMe'

call plug#end()

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
set numberwidth=4
let g:gitgutter_sign_column_always = 1
set colorcolumn=80
highlight OverLength ctermbg=darkRed ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" Update Vim without restarting
map <leader>s :source ~/.config/nvim/init.vim<CR>

" Strip trailing whitespace
" TODO: add new line, change tabs to spaces
autocmd vimrc BufWritePre * :%s/\s\+$//e

" Tern Stuff
"enable keyboard shortcuts
let g:tern_map_keys=1
"show argument hints
let g:tern_show_argument_hints='on_hold'

" Lightline configs
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode' ],
      \             [ 'gitbranch', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'LightLineBranch'
      \ }
      \ }

function! LightLineBranch()
  return exists('*gitbranch#name') ?  '⎇  ' . gitbranch#name(): ''
endfunction
