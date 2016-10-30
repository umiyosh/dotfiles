scriptencoding utf-8
"-------------------------------------------------------------------------------
" ステータスライン StatusLine
"-------------------------------------------------------------------------------
set laststatus=2 " 常にステータスラインを表示

"カーソルが何行目の何列目に置かれているかを表示する
set ruler

" vim-powerlineでフォントにパッチを当てないなら以下をコメントアウト
let g:Powerline_symbols = 'fancy'

"自動的に QuickFix リストを表示する
autocmd QuickfixCmdPost make,grep,grepadd,vimgrep,vimgrepadd botright cwin
autocmd QuickfixCmdPost lmake,lgrep,lgrepadd,lvimgrep,lvimgrepadd botright lwin

function! GetB()
  let l:c = matchstr(getline('.'), '.', col('.') - 1)
  let l:c = iconv(l:c, &encoding, &fileencoding)
  return String2Hex(l:c)
endfunction
" help eval-examples
" The function Nr2Hex() returns the Hex string of a number.
func! Nr2Hex(nr)
  let l:n = a:nr
  let l:r = ''
  while l:n
    let l:r = '0123456789ABCDEF'[l:n % 16] . l:r
    let l:n = l:n / 16
  endwhile
  return l:r
endfunc
" The function String2Hex() converts each character in a string to a two
" character Hex string.
func! String2Hex(str)
  let l:out = ''
  let l:ix = 0
  while l:ix < strlen(a:str)
    let l:out = l:out . Nr2Hex(char2nr(a:str[l:ix]))
    let l:ix = l:ix + 1
  endwhile
  return l:out
endfunc
