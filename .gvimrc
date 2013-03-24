colorscheme desert

"gvimでバックスラッシュが入力できないのでキーバインド追加
inoremap 促 \

"透明度
set transparency=7

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

