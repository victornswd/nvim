set nocompatible
set t_Co=256
filetype off

" Plugins installed by vim-plug
call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'mxw/vim-jsx' | Plug 'pangloss/vim-javascript'
Plug 'isRuslan/vim-es6'
Plug 'junegunn/seoul256.vim'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/syntastic'
Plug 'editorconfig/editorconfig-vim'
Plug 'ap/vim-css-color'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

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

