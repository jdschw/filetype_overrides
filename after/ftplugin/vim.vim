" setlocal foldexpr=getline(v:lnum)=~'^\\s*%%\\s.*$'?'>1':getline(v:lnum+1)=~'^\\s*%*$'&&getline(v:lnum+2)=~'^\\s*%%\\s.*$'?'<1':getline(v:lnum+1)=~'^\\s*%%\\s.*$'?'<1':-1
" setlocal foldexpr=getline(v:lnum)=~'^\\s*"--\\s.*$'?'>1':getline(v:lnum+1)=~'^\\s*"--\\s.*$'?'<1':-1
setlocal foldexpr=getline(v:lnum)=~'^\\"--.*$'?'>1':getline(v:lnum+1)=~'^\\s*$'&&getline(v:lnum+2)=~'^\\"--.*$'?'<1':-1
setlocal foldmethod=expr

function! CommentMyLine()
  s:^:"\ :e
endfunction
function! UncommentMyLine()
  s:^"\ ::e
endfunction

nnoremap <buffer> <Leader>c :call CommentMyLine()<cr><cr>
nnoremap <buffer> <Leader>x :call UncommentMyLine()<cr><cr>
vnoremap <buffer> <Leader>c :call CommentMyLine()<cr><cr>
vnoremap <buffer> <Leader>x :call UncommentMyLine()<cr><cr>
