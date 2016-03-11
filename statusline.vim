set statusline=
set statusline+=%4*\ %{GitBranch()}\                    " Git branch
set statusline+=%1*\ %t\ %m                             " File+modified
set statusline+=%2*\ %=\                                " Left/Right separator
set statusline+=%2*\ %y\                                " FileType
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}    " Encoding
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\[%{&ff}\] " Encoding2
set statusline+=%8*\ LN/Col:\ %02l/%02c\                " Rownumber/Colnumber
set statusline+=%0*\ \ %r%w\ %P\ \                      " Readonly? Top/bot
set statusline+=\ %4*\%{Lint()}                             " Linter

function! GitBranch()
  return exists('*gitbranch#name') ?  '⎇  ' . gitbranch#name(): ''
endfunction

function! Lint()
  if exists('*neomake#statusline#LoclistStatus')
    if strlen( neomake#statusline#LoclistStatus('') ) <# 2
      return ' ✔ '
    else
      " if str contains E -> red, if W -> orange
      return neomake#statusline#LoclistStatus('')
    endif
  endif
endfunction

" Colors that work nicely with gruvbox theme
" https://github.com/morhetz/gruvbox#palette
hi User1 ctermbg=130 ctermfg=223 guibg=#af3a03 guifg=#ebdbb2
hi User2 ctermbg=234 ctermfg=243 guibg=#1d2021 guifg=#7c6f64
hi User3 ctermbg=236 ctermfg=245 guibg=#32302f guifg=#928374
hi User4 ctermbg=142 ctermfg=234 guibg=#b8bb26 guifg=#1d2021 cterm=bold gui=bold
hi User5 ctermbg=darkRed ctermfg=white
" hi User7
hi User8 ctermbg=241 ctermfg=234 guibg=#665c54 guifg=#1d2021
" hi User9
hi User0 ctermbg=245 ctermfg=239 guibg=#928374 guifg=#504945 cterm=bold gui=bold

