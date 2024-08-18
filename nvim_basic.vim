scriptencoding utf-8
"-------------------------------------------------------------------------------
" 基本設定 Basics
"-------------------------------------------------------------------------------
let g:mapleader = ','                       " キーマップリーダー
set scrolloff=5                             " スクロール時の余白確保
set textwidth=0                             " 一行に長い文章を書いていても自動折り返しをしない
set nobackup                                " バックアップ取らない
set autoread                                " 他で書き換えられたら自動で読み直す
set noswapfile                              " スワップファイル作らない
set nowritebackup                           " Do not create wirte backup"
set hidden                                  " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start              " バックスペースでなんでも消せるように
set formatoptions=lmoq                      " テキスト整形オプション，マルチバイト系を追加
set visualbell t_vb=                        " ビープをならさない
set browsedir=buffer                        " Exploreの初期ディレクトリ
set whichwrap=b,s,h,l,<,>,[,]               " カーソルを行頭、行末で止まらないようにする
set showcmd                                 " コマンドをステータス行に表示
set showmode                                " 現在のモードを表示
set viminfo='10000,<1000,s100,\"10000       " viminfoファイルの設定
set viminfo+=:10000                         " command line hisory size
set viminfo+=/10000                         " serach pattern hisory size
set modelines=0                             " モードラインは無効
set notitle                                 " 「VIMを使ってくれてありがとう」無し
set autoread                                " 外部から変更あった場合は自動読み込みする
set nowrapscan                              " 検索マッチ終端までいったらそこで止める。
set noundofile                              " undofileは作らない
set history=10000                           " コマンド・検索パターンの履歴数
set updatetime=500
set ttimeoutlen=50
set shortmess=a
set cmdheight=2
set mmp=5000
set signcolumn=yes:2

" autoreadの頻度を上げる
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

" ターミナルでマウスを使用できるようにする
set mouse=nv
set guioptions+=nv

"ヤンクした文字は、システムのクリップボードに入れる"
set clipboard=unnamed
" 挿入モードでCtrl+kを押すとクリップボードの内容を貼り付けられるようにする "
imap <C-p>  <ESC>"*pa

" Ev/Rvでvimrcの編集と反映
command! Ev edit $MYVIMRC
command! Rv source $MYVIMRC

set helpfile=$VIMRUNTIME/doc/help.txt

" ファイルタイプ判定をon
filetype plugin on

"crontab編集時はバックアップファイルを作成しない
"http://d.hatena.ne.jp/yuyarin/20100225/1267084794
set backupskip=/tmp/*,/private/tmp/*

"最後にヤンクしたテキストのペースト
nnoremap <C-p> "0p
nnoremap <C-P> "0P

