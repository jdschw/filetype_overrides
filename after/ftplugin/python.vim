echo "loading python custom settings..."
setlocal fo+=croql
setlocal fo-=t
setlocal foldmethod=syntax
setlocal tabstop=2
setlocal shiftwidth=2
setlocal nosmartindent
function! CommentMyPythonLine()
  s/^/#\ /e
endfunction
function! UncommentMyPythonLine()
  s/^#\ //e
endfunction
nnoremap <buffer> <leader>m :w<cr> :!/usr/bin/python %<cr>
" nnoremap <buffer> <Leader>c :silent s/^/#\ /<cr>:silent noh<cr>
" nnoremap <buffer> <Leader>x :silent s/^#\ //<cr>:silent noh<cr>
" vnoremap <buffer> <Leader>c :s/^/#\ /<cr>:noh<cr>
" vnoremap <buffer> <Leader>x :s/^#\ //<cr>:noh<cr>

nnoremap <buffer> <Leader>c :call CommentMyPythonLine()<cr><cr>
nnoremap <buffer> <Leader>x :call UncommentMyPythonLine()<cr><cr>
vnoremap <buffer> <Leader>c :call CommentMyPythonLine()<cr><cr>
vnoremap <buffer> <Leader>x :call UncommentMyPythonLine()<cr><cr>
