function! GitBranch()
  if exists('*gitbranch#name')
    let branch = '%4*' " color
    let branch .= ' ⎇  '
    let branch .= gitbranch#name()
    let branch .= ' '
    return branch
  endif
endfunction

function! ParseErrorList(str)
  let result = ''
  if a:str =~ '^E'
    let result .= '%5* '
    let result .= a:str
    let result .= ' '
  elseif a:str =~ '^:' " warnings start with ':' because of the split fn
    let result .= '%1* '
    let result .= 'W'
    let result .= a:str
    let result .= ' '
  endif
  return result
endfunction

function! Linter()
  let lint = ''
  let errors = neomake#statusline#LoclistStatus()
  " get output length; if 0 then the file passed linting
  if strlen(errors) ==# 0
    let lint .= '%4*'
    let lint .= ' ✔ '
  else
    let errorList = split(errors, 'W')

    for i in errorList
      let lint .= ParseErrorList(i)
    endfor
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

function! PositionInFile()
  return '%0*  %r%w %P  '
endfunction

function! LeftSide()
  let left = ''
  let left .= GitBranch()
  let left .= FileName()

  return left
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
