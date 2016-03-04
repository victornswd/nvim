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
Plug 'morhetz/gruvbox'

" Syntax highlighting
Plug 'sheerun/vim-polyglot'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'ap/vim-css-color'

" Dev helpers (linting, project spacing...)
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/syntastic'
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
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_css_checkers = ['stylelint']

" Theme configs
set background=dark
let g:airline_powerline_fonts = 1
let g:gruvbox_italic=1
colorscheme gruvbox

" Style tabline
let g:airline#extensions#tabline#enabled = 1

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
autocmd BufWritePre * :%s/\s\+$//e
