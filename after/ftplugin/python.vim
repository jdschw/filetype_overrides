echo "loading python custom settings..."
setlocal fo+=croql
setlocal fo-=t
setlocal foldmethod=syntax
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

nnoremap <script> <buffer> <Leader>c :call <SID>CommentMyPythonLine()<cr><cr>
nnoremap <script> <buffer> <Leader>x :call <SID>UncommentMyPythonLine()<cr><cr>
vnoremap <script> <buffer> <Leader>c :call <SID>CommentMyPythonLine()<cr><cr>
vnoremap <script> <buffer> <Leader>x :call <SID>UncommentMyPythonLine()<cr><cr>
