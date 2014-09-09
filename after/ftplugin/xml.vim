echo "loading xml custom settings..."

" setlocal foldmethod=indent
setlocal foldnestmax=3

function! s:CommentMyLine()
  s:^\(\s*\)\(.*\)$:\1<!-- \2 -->:e
endfunction
function! s:UncommentMyLine()
  s:\(\s*\)<!-- \(.*\) -->:\1\2:e
endfunction

nnoremap <script> <buffer> <Leader>c :call <SID>CommentMyLine()<cr><cr>
nnoremap <script> <buffer> <Leader>x :call <SID>UncommentMyLine()<cr><cr>
vnoremap <script> <buffer> <Leader>c :call <SID>CommentMyLine()<cr><cr>
vnoremap <script> <buffer> <Leader>x :call <SID>UncommentMyLine()<cr><cr>
