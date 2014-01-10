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

"-- GetMyPythonFold
function! GetMyPythonFold(lnum)
  let this_indent = IndentLevel(a:lnum)

  if IsInterestingLine(a:lnum)
    return '>' . (this_indent+1)
  endif

  if getline(a:lnum) =~? '^\s*#.*$'
    return '='
  endif

  let next_indent = IndentLevel(NextNoncommentLine(a:lnum))
  let lines_of_interest = LastInterestingLine(a:lnum)
  let last_interesting_line = lines_of_interest[0]
  let last_predented_line = lines_of_interest[1]
  let last_indent = IndentLevel(last_interesting_line)

  if last_interesting_line == 0
    return 0
  endif

  if getline(a:lnum) =~? '\v^\s*$'
    if next_indent <= last_indent
      return next_indent
    else
      return last_indent+1
    endif
  endif

  if last_interesting_line == last_predented_line
    return last_indent+1
  elseif last_indent < IndentLevel(last_predented_line)
    return last_indent+1
  endif

  return last_indent

endfunction

"-- IsInterestingLine
function! IsInterestingLine(lnum)
  if getline(a:lnum) =~? '^\s*\(def \|class \).*$'
    return 1
  elseif getline(a:lnum) =~? '^if .*$'
    return 1
  else
    return 0
  endif
endfunction


"-- IndentLevel
function! IndentLevel(lnum)
  return indent(a:lnum) / &shiftwidth
endfunction

"-- LastInterestingLine
function! LastInterestingLine(lnum)
  let current = a:lnum
  let my_indent = IndentLevel(a:lnum)

  let my_last_interesting_line = 0
  let my_last_predented_line = 0
  while current > 0 && (my_last_interesting_line == 0 || my_last_predented_line == 0)

    if my_last_interesting_line == 0 && IsInterestingLine(current)
      let my_last_interesting_line = current
    endif

    if my_last_predented_line == 0 &&
\       getline(current) !~? '^\s*#.*$' &&
\       getline(current) !~? '\v^\s*$' &&
\       IndentLevel(current) < my_indent
      let my_last_predented_line = current
    endif

    let current -= 1
  endwhile

  return [my_last_interesting_line, my_last_predented_line]
endfunction

"-- NextNoncommentLine
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


