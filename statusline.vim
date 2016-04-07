"
"
"
" Show Mode
" function! InsertStatuslineColor(mode)
"   if a:mode == 'i'
"     hi statusline ctermbg=magenta
"   elseif a:mode == 'r'
"     hi statusline ctermbg=blue
"   else
"     hi statusline ctermbg=red
"   endif
" endfunction
"
" au InsertEnter * call InsertStatuslineColor(v:insertmode)
" au InsertChange * call InsertStatuslineColor(v:insertmode)
" au InsertLeave * hi statusline ctermbg=green
"
"
"
function! GitBranch()
  if exists('*gitbranch#name')
    let branch = '%4*' " color
    let branch .= ' ⎇  '
    let branch .= gitbranch#name()
    let branch .= ' '
    return branch
  endif
endfunction

function! Linter()
  let lint = ''
    let errors = neomake#statusline#LoclistStatus()
    if errors =~ 'E'
      let lint .= '%2*'
      let lint .= errors
    elseif errors =~ 'W'
      let lint .= '%1*'
      let lint .= errors
    else
      let lint .= '%4*'
      let lint .= ' ✔ '
    endif
  return lint
endfunction

function! FileName()
  let name = ''
  let name .= '%1* ' " color
  let name .= '%t ' " filename
  let name .= '%m' " modified or not
  return name
endfunction

function! FileType()
  return '%2* %y '
endfunction

function! FileEnc()
  return '%3* %{(&fenc!=""?&fenc:&enc)}'
endfunction

function! EncScheme()
  return '%3* %{(&bomb?",BOM":"")}[%{&ff}]'
endfunction

function! Encoding()
  let enc = ''
  let enc .= FileEnc()
  let enc .= EncScheme()
  return enc
endfunction

function! CursorPosition()
  return '%8* LN/Col: %02l/%02c ' " Line No./Row No.
endfunction

function! LeftSide()
  let left = ''
  let left .= GitBranch()
  let left .= FileName()

  return left
endfunction

function! PositionInFile()
  return '%0*  %r%w %P  '
endfunction

function! RightSide()
  let right = ''
  let right .= FileType()
  let right .= Encoding()
  let right .= CursorPosition()
  let right .= PositionInFile()
  let right .= Linter()

  return right
endfunction

function! StatusLine()
  let sl = LeftSide()
  let sl .= '%2* %=' " separator
  let sl .= RightSide()

  return sl
endfunction

set statusline=%!StatusLine()
