echo "loading vim custom settings..."

" setlocal foldexpr=getline(v:lnum)=~'^\\s*%%\\s.*$'?'>1':getline(v:lnum+1)=~'^\\s*%*$'&&getline(v:lnum+2)=~'^\\s*%%\\s.*$'?'<1':getline(v:lnum+1)=~'^\\s*%%\\s.*$'?'<1':-1
" setlocal foldexpr=getline(v:lnum)=~'^\\s*"--\\s.*$'?'>1':getline(v:lnum+1)=~'^\\s*"--\\s.*$'?'<1':-1
setlocal foldexpr=getline(v:lnum)=~'^\\"--.*$'?'>1':getline(v:lnum+1)=~'^\\s*$'&&getline(v:lnum+2)=~'^\\"--.*$'?'<1':-1
setlocal foldmethod=expr

function! s:CommentMyLine()
  s:^:"\ :e
endfunction
function! s:UncommentMyLine()
  s:^"\ ::e
endfunction

nnoremap <script> <buffer> <Leader>c :call <SID>CommentMyLine()<cr><cr>
nnoremap <script> <buffer> <Leader>x :call <SID>UncommentMyLine()<cr><cr>
vnoremap <script> <buffer> <Leader>c :call <SID>CommentMyLine()<cr><cr>
vnoremap <script> <buffer> <Leader>x :call <SID>UncommentMyLine()<cr><cr>
