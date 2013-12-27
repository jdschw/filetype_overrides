echo "loading python custom settings..."
setlocal fo+=croql
setlocal fo-=t
" setlocal foldmethod=syntax
setlocal foldmethod=expr
" setlocal foldexpr=getline(v:lnum)=~'\\(\\s*\\)\\(def\\\|class\\).*$'?'>1':getline(v:lnum+1)=~'^\\s*$'&&getline(v:lnum+2)=~'^\\1\\2.*$'?'<1':-1
setlocal foldexpr=GetMyPythonFold(v:lnum)

setlocal tabstop=2
setlocal shiftwidth=2
setlocal nosmartindent
function! s:CommentMyLine()
  s/^/#\ /e
endfunction
function! s:UncommentMyLine()
  s/^#\ //e
endfunction
nnoremap <buffer> <leader>m :w<cr> :!/usr/bin/python %<cr>
" nnoremap <buffer> <Leader>c :silent s/^/#\ /<cr>:silent noh<cr>
" nnoremap <buffer> <Leader>x :silent s/^#\ //<cr>:silent noh<cr>
" vnoremap <buffer> <Leader>c :s/^/#\ /<cr>:noh<cr>
" vnoremap <buffer> <Leader>x :s/^#\ //<cr>:noh<cr>

nnoremap <script> <buffer> <Leader>c :call <SID>CommentMyLine()<cr><cr>
nnoremap <script> <buffer> <Leader>x :call <SID>UncommentMyLine()<cr><cr>
vnoremap <script> <buffer> <Leader>c :call <SID>CommentMyLine()<cr><cr>
vnoremap <script> <buffer> <Leader>x :call <SID>UncommentMyLine()<cr><cr>


function! GetMyPythonFold(lnum)
  let last_indent = IndentLevel(LastInterestingLine(a:lnum))
  let this_indent = IndentLevel(a:lnum)
  let next_indent = IndentLevel(NextNoncommentLine(a:lnum))

  if getline(a:lnum) =~? '^\s*#.*$'
    return '='
  endif

  if getline(a:lnum) =~? '\v^\s*$'
    if next_indent <= last_indent
      return next_indent
    else
      return '='
    endif
  endif

  if IsInterestingLine(a:lnum)
    return '>' . next_indent
  endif
  if this_indent <= last_indent
    return this_indent
  endif

  return '='
endfunction


function! IsInterestingLine(lnum)
  if getline(a:lnum) =~? '^\s*\(def \|class \).*$'
    return 1
  elseif getline(a:lnum) =~? '^if .*$'
    return 1
  else
    return 0
  endif
endfunction


function! IndentLevel(lnum)
  return indent(a:lnum) / &shiftwidth
endfunction


function! LastInterestingLine(lnum)
  let current = a:lnum

  while current > 0
    if IsInterestingLine(current)
      return current
    endif

    let current -= 1
  endwhile

  return -2
endfunction

function! NextNoncommentLine(lnum)
  let numlines = line('$')
  let current = a:lnum + 1

  while current <= numlines
    if getline(current) =~? '\v\S' && getline(current) !~? '^\s*#.*$'
      return current
    endif

    let current += 1
  endwhile

  return -2
endfunction


