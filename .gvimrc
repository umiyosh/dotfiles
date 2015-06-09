colorscheme molokai
" molokai setting
let g:rehash256 = 1
highlight Normal guibg=none
set cursorline
set cursorcolumn
autocmd VimEnter,ColorScheme * : highlight CursorLine gui=underline guibg=234
hi Visual  gui=reverse guifg=#3399ff guibg=#f0e68c
" ハイライト on
syntax enable
hi PmenuSel gui=reverse guifg=33 guibg=222 gui=reverse guifg=#3399ff guibg=#f0e68c

"gvimでバックスラッシュが入力できないのでキーバインド追加
inoremap 促 \

"透明度
set transparency=10

"visualモード時に勝手にヤンクしない
set guioptions-=a

"ウィンドウを最大化して起動
au GUIEnter * set lines=100
au GUIEnter * set columns=210

" 外に見せたくない環境変数など設定用
if filereadable(expand('~/.gvimrc.local'))
  source ~/.gvimrc.local
endi

" cabalのpath
let $PATH = $HOME.'/.cabal/bin:'.$PATH

set nowrapscan                   " 検索マッチ終端までいったらそこで止める。

