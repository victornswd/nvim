set nocompatible
set t_Co=256
set encoding=utf-8
filetype off

" Plugins installed by vim-plug
call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Theme
Plug 'junegunn/seoul256.vim'

" Syntax highlighting
Plug 'mxw/vim-jsx' | Plug 'pangloss/vim-javascript'
Plug 'isRuslan/vim-es6'
Plug 'ap/vim-css-color'

" Dev helpers (linting, project spacing...)
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'

call plug#end()

" Map the leader key to SPACE
let mapleader="\<SPACE>"

" Allow JSX in normal JS files
let g:jsx_ext_required = 0

" Set up ESLint for JS & JSX files & Style Lint for CSS
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_css_checkers = ['stylelint']

" Theme configs
set background=dark
let g:seoul256_background = 236
colorscheme seoul256

" Style line numbers, gutter and 80char limit
set number
set numberwidth=4
let g:gitgutter_sign_column_always = 1
set colorcolumn=80
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

