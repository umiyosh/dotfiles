scriptencoding utf-8
if has('vim_starting')
  set runtimepath+=~/.vim/plugged/vim-plug
  if !isdirectory(expand('~/.vim/plugged/vim-plug'))
    echo 'install vim-plug...'
    call feedkeys(' ')
    call system('mkdir -p ~/.vim/plugged/vim-plug')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
  end
endif

filetype off
call plug#begin('~/.vim/plugged')
" Edit {{{
  " コメントアウトを簡単にするやつ
  Plug 'scrooloose/nerdcommenter'
  " インデントガイド
  Plug 'lukas-reineke/indent-blankline.nvim'
  " 高機能整形・桁揃えプラグイン
  Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }
  " undo履歴を追える (need python support)
  " TODO: git作業している間はほとんど使わないし、このプラグイン自体削除してもいいかも
  Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
  " 選択範囲を指定文字で囲む
  Plug 'tpope/vim-surround'
  " 簡単にoperatorを定義できるようにする
  Plug 'kana/vim-operator-user'
  " operator-replace : yankしたものでreplaceする
  Plug 'kana/vim-operator-replace'
  " textobj-user : 簡単にVimエディタのテキストオブジェクトをつくれる
  Plug 'kana/vim-textobj-user'
  " vim-textobj-fold : 折りたたまれたアレをtext-objectに
  Plug 'kana/vim-textobj-fold'
  " vim-textobj-indent : インデントされたものをtext-objectに
  Plug 'kana/vim-textobj-indent'
  " editorconfig
  Plug 'editorconfig/editorconfig-vim'
  " https://mattn.kaoriya.net/software/vim/20200106103137.htm
  " 不足しているパッケージを挿入してくれるやつ。
  Plug 'mattn/vim-goimports', { 'for' : 'go' }
" }}}

" Completion {{{
  " さまざまな言語のスニペットを使いやすく提供してくれるやつ
  Plug 'Shougo/neosnippet'
  " LSP使った開発環境。補完、エラー検出など、いろいろやってくれるやつ
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " coc.nvimの組み込みファジーファインダーをfzfで置き換えるもの
  Plug 'antoinemadec/coc-fzf'
  " LLMを使ってコードを提案してくれるやつ
  Plug 'github/copilot.vim'
" }}}

" Searching/Moving{{{
  " camelcasemotion : CamelCaseやsnake_case単位でのワード移動
  Plug 'vim-scripts/camelcasemotion'
  " 「%」による対応括弧へのカーソル移動機能を拡張
  Plug 'andymass/vim-matchup'
  " eregex.vim : vimの正規表現をrubyやperlの正規表現な入力でできる :%S/perlregex/
  Plug 'othree/eregex.vim'
  " hop.nvim : easymotion的な動作を提供してキーボードでの移動を効率化
  Plug 'smoka7/hop.nvim'
" }}}

" Programming {{{
  " Pythonの仮想環境内でインストールされたパッケージをVimから利用できるようにするやつ
  " TODO: このリポジトリはもうアーカイブされリードオンリーモードになっているので大体品を探した方が良い。
  Plug 'jmcantrell/vim-virtualenv' , { 'for': 'python' }
  " python formatter
  Plug 'mindriot101/vim-yapf' , { 'for': 'python' }
  " pydocstring
  Plug 'heavenshell/vim-pydocstring' , { 'for': 'python' }
  " バッファ上のコードを実行してvimに送信するプラグイン。
  Plug 'thinca/vim-quickrun'
  " ソースコード上のメソッド宣言、変数宣言の一覧を表示
  Plug 'liuchengxu/vista.vim'
  " golang line debugger
  Plug 'sebdah/vim-delve', { 'for' : 'go' }
  " vimからテストを実行するやつ
  Plug 'vim-test/vim-test'
  " テストを非同期実行するために入れたやつ
  Plug 'tpope/vim-dispatch'
  " TODO: remove "gotests-vim" because of not working
  " gotests
  Plug 'buoto/gotests-vim', { 'for' : 'go' }
  " terraformのSyntax highlightとかのやつ
  " TODO: ツリーシッターを使えばいらないんじゃないかって思った。
  Plug 'hashivim/vim-terraform', { 'for' : 'terraform' }
  " K8sのxplainを使うために、カーソル下のkeyをフルパスで取得するやつ
  " TODO : インストールはされているが、設定が有効化されていない。
  Plug 'cuducos/yaml.nvim'
  " LLMとのチャットインターフェースを提供してくれるやつ {{{
    Plug 'MunifTanjim/nui.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'folke/trouble.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'jackMort/ChatGPT.nvim'
  " }}}

" }}}

" Syntax {{{
  " Tree-sitterを使ってシンタックスハイライトを行うやつ
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  " 対応する括弧を色違いで表示してくれるやつ。
  Plug 'hiphish/rainbow-delimiters.nvim'
  " 引数をシンタックスハイライトしてくれるやつ。Tree-sitterを使っている。
  Plug 'm-demare/hlargs.nvim'
  " 画面に収まりきらない関数定義部分を表示してくれるやつ。
  Plug 'nvim-treesitter/nvim-treesitter-context'
  " helmのシンタックスハイライト
  Plug 'towolf/vim-helm'
  " JSONファイルの視認性と編集体験を向上するやつ
  Plug 'elzr/vim-json', { 'for' : 'json' }
  " plantuml シンタックスハイライト
  Plug 'aklt/plantuml-syntax'
  " varnish設定ファイルのシンタックスハイライト
  Plug 'smerrill/vcl-vim-plugin'
  " カーソルの下の単語を自動ハイライトするやつ
  Plug 'RRethy/vim-illuminate'
  " カラーコードを実際の色で表示してくれるやつ
  Plug 'norcalli/nvim-colorizer.lua'
" }}}

" Utility {{{
  " vimproc : vimから非同期実行。vimshelleで必要
  Plug 'Shougo/vimproc.vim'
  " 左ペインにファイル一覧を表示するやつ {{{
  " TODO 別のプラグインに置き換えたい候補
    Plug 'lambdalisue/fern.vim'
    Plug 'lambdalisue/fern-git-status.vim'
    Plug 'lambdalisue/nerdfont.vim'
    Plug 'lambdalisue/fern-renderer-nerdfont.vim'
    Plug 'lambdalisue/glyph-palette.vim'
  " }}}
  " vimからGit操作する
  Plug 'tpope/vim-fugitive'
  " Github連携強化のプラグイン。GBrowseで開くとかのやつ
  Plug 'tpope/vim-rhubarb'
  " 編集した行のgit差分を左側に表示してくれるやつ
  Plug 'airblade/vim-gitgutter'
  " ステータスラインをカッコよくするやつ
  Plug 'vim-airline/vim-airline'
  " バッファーを上部に表示してくれるやつ
  Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
  " Markdownの見出し単位の折りたたみを提供するやつ
  Plug 'nelstrom/vim-markdown-folding', { 'for' : 'markdown' }
  " 分割を維持してバッファ削除。複数のバッファを一つ狙い撃ちで消すときに特に使っているやつ
  Plug 'rgarver/Kwbd.vim'
  " 現在開いている以外のバッファを全部削除するやつ. BufOnlyコマンド
  Plug 'duff/vim-bufonly'
  " バイナリエディターの機能を提供してくれるやつ
  Plug 'Shougo/vinarise'
  " markdownのアウトライン表示
  Plug 'vim-voom/VOoM'
  " foldtextの情報量を増やして折り畳みの体験をよくするやつ
  Plug 'LeafCage/foldCC'
  " .(ドット)で繰り返し操作を拡張してくれるやつ
  Plug 'tpope/vim-repeat'
  " ディレクトリ間の再帰的なDiff表示してくれるやつ
  Plug 'vim-scripts/DirDiff.vim'
  " カーソル下のワードをDashで検索する
  Plug 'rizzatti/dash.vim'
  " rickhowe/diffchar.vim
  Plug 'rickhowe/diffchar.vim'
  " アスタリスク入力後にカーソルが移動しないのを防ぐ効果がある。
  Plug 'haya14busa/vim-asterisk'
  " nerdfontのグリフを使ってファイルタイプを表示してくれるやつ
  Plug 'ryanoasis/vim-devicons'
  " QuickFixWindowにプレビューを追加したり、見栄えを良くしてくれるやつ
  Plug 'kevinhwang91/nvim-bqf'
  function! UpdateRemotePlugins(...)
    " Needed to refresh runtime files
    let &rtp=&rtp
    UpdateRemotePlugins
  endfunction
  " 編集ファイル内のURLをいい感じにブラウザで開いてくれるやつ
  Plug 'tyru/open-browser.vim'
  " benchvimrc-vim
  " Plug 'mattn/benchvimrc-vim'
" }}}

" ColorSchema{{{{
  " color schema gruvbox
  Plug 'sainnhe/gruvbox-material'
" }}}

" Incremental Search {{{{
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
" }}}
call plug#end()

filetype plugin indent on

