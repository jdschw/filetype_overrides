echo "loading python custom settings..."
setlocal fo+=croql
setlocal fo-=t
" setlocal foldmethod=syntax
setlocal foldmethod=expr
"setlocal foldexpr=GetMyPythonFold(v:lnum)

setlocal foldnestmax=2
setlocal tabstop=4
setlocal shiftwidth=4
setlocal textwidth=120
setlocal nosmartindent
function! s:CommentMyLine()
  s/^#\ //e
  s:\v^(.+):# \1:e
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
nnoremap <script> <buffer> <Leader>u :call <SID>UncommentMyLine()<cr><cr>
vnoremap <script> <buffer> <Leader>c :call <SID>CommentMyLine()<cr><cr>
vnoremap <script> <buffer> <Leader>u :call <SID>UncommentMyLine()<cr><cr>

"-- GetMyPythonFold
" All this stuff works, but it takes a long time!!!
" function! GetMyPythonFold(lnum)
"   " If we are starting a new sweep of the buffer (i.e. the current line
"   " being folded comes before the previous line that was folded), initialize
"   " the cache of results of calls to `s:NumContainingDefs`
"   if !exists('b:last_folded_line') || b:last_folded_line > a:lnum
"       let b:cache_last_interesting_line = {}
"       let b:cache_last_predented_line = {}
"   endif
"   let b:last_folded_line = a:lnum

"   let this_indent = IndentLevel(a:lnum)

"   if IsInterestingLine(a:lnum)
"     return '>' . (this_indent+1)
"   endif

"   let next_indent = IndentLevel(NextNoncommentLine(a:lnum))
"   let lines_of_interest = LastInterestingLine(a:lnum)
"   let last_interesting_line = lines_of_interest[0]
"   let last_predented_line = lines_of_interest[1]
"   let last_indent = IndentLevel(last_interesting_line)

"   let this_line = getline(a:lnum)
"   if this_line =~? '^\s*#.*$' ||
" \     this_line =~? '^\s*):\s*' ||
" \     this_line =~? '^\s*);\s*'
"     return last_indent+1
"   endif

"   if last_interesting_line == 0
"     return 0
"   endif

"   if this_line =~? '\v^\s*$'
"     if next_indent <= last_indent
"       return next_indent
"     else
"       return last_indent+1
"     endif
"   endif

"   if last_interesting_line == last_predented_line
"     return last_indent+1
"   elseif last_indent < IndentLevel(last_predented_line)
"     return last_indent+1
"   endif

"   return last_indent

" endfunction

"-- IsInterestingLine
" function! IsInterestingLine(lnum)
"   if getline(a:lnum) =~? '^\s*\(def \|class \).*$'
"     return 1
"   elseif getline(a:lnum) =~? '^if .*$'
"     return 1
"   else
"     return 0
"   endif
" endfunction


"-- IndentLevel
" function! IndentLevel(lnum)
"   return indent(a:lnum) / &shiftwidth
" endfunction

"-- LastInterestingLine
" function! LastInterestingLine(lnum)
"   let current = a:lnum
"   let my_indent = IndentLevel(a:lnum)

"   let my_last_interesting_line = 0
"   let my_last_predented_line = 0
"   while current > 0 && (my_last_interesting_line == 0 || my_last_predented_line == 0)

"     if my_last_interesting_line == 0 && IsInterestingLine(current)
"       let my_last_interesting_line = current
"     endif

"     let this_line = getline(current)
"     if my_last_predented_line == 0 &&
" \       this_line !~? '^\s*#.*$' &&
" \       this_line !~? '\v^\s*$' &&
" \       this_line !~? '^\s*):\s*' &&
" \       this_line !~? '^\s*);\s*' &&
" \       IndentLevel(current) < my_indent
"       let my_last_predented_line = current
"     endif

"     let current -= 1
"   endwhile

"   return [my_last_interesting_line, my_last_predented_line]
" endfunction

"-- NextNoncommentLine
" function! NextNoncommentLine(lnum)
"   let numlines = line('$')
"   let current = a:lnum + 1

"   while current <= numlines
"     if getline(current) =~? '\v\S' && getline(current) !~? '^\s*#.*$'
"       return current
"     endif

"     let current += 1
"   endwhile

"   return -2
" endfunction


