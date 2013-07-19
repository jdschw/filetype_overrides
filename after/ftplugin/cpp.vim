echo "loading cpp custom settings..."
setlocal foldmethod=syntax
setlocal tabstop=2
setlocal formatoptions-=2
setlocal shiftwidth=2
setlocal foldnestmax=1

function! CommentMyLine()
  s:^://\ :e
endfunction
function! UncommentMyLine()
  s:^//\ ::e
endfunction

nnoremap <buffer> <Leader>c :call CommentMyLine()<cr><cr>
nnoremap <buffer> <Leader>x :call UncommentMyLine()<cr><cr>
vnoremap <buffer> <Leader>c :call CommentMyLine()<cr><cr>
vnoremap <buffer> <Leader>x :call UncommentMyLine()<cr><cr>
