echo "loading cpp custom settings..."
setlocal foldmethod=syntax
setlocal tabstop=2
setlocal formatoptions-=2
setlocal shiftwidth=2
setlocal foldnestmax=1

function! s:CommentMyLine()
  s:^://\ :e
endfunction
function! s:UncommentMyLine()
  s:^//\ ::e
endfunction

nnoremap <script> <buffer> <Leader>c :call <SID>CommentMyLine()<cr><cr>
nnoremap <script> <buffer> <Leader>x :call <SID>UncommentMyLine()<cr><cr>
vnoremap <script> <buffer> <Leader>c :call <SID>CommentMyLine()<cr><cr>
vnoremap <script> <buffer> <Leader>x :call <SID>UncommentMyLine()<cr><cr>
