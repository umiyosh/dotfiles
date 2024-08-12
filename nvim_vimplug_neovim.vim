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
  Plug 'mattn/vim-goimports', { 'for' : 'go' }
" }}}

" Completion {{{
  Plug 'Shougo/neosnippet'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'antoinemadec/coc-fzf'
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
  " pythonの環境周り
  Plug 'jmcantrell/vim-virtualenv' , { 'for': 'python' }
  " python formatter
  Plug 'mindriot101/vim-yapf' , { 'for': 'python' }
  " pydocstring
  Plug 'heavenshell/vim-pydocstring' , { 'for': 'python' }
  " バッファ上のコードを実行してvimに送信するプラグイン。
  Plug 'thinca/vim-quickrun'
  " perldocやphpmanual等のリファレンスをvim上で見る
  Plug 'thinca/vim-ref'
  " SQLUtilities : SQL整形、生成ユーティリティ
  Plug 'vim-scripts/SQLUtilities'
  " ソースコード上のメソッド宣言、変数宣言の一覧を表示
  Plug 'liuchengxu/vista.vim'
  " golang line debugger
  Plug 'sebdah/vim-delve', { 'for' : 'go' }
  " vim-test
  Plug 'vim-test/vim-test'
  Plug 'tpope/vim-dispatch'
  " TODO: remove "gotests-vim" because of not working
  " gotests
  Plug 'buoto/gotests-vim', { 'for' : 'go' }
  " terraform
  Plug 'hashivim/vim-terraform', { 'for' : 'terraform' }
  " yank yaml full path
  Plug 'cuducos/yaml.nvim'
  " ai programming
  " Plug 'nvim-lua/plenary.nvim'
  " Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'canary' }
  " Plug 'madox2/vim-ai'
  Plug 'MunifTanjim/nui.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'folke/trouble.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'jackMort/ChatGPT.nvim'

" }}}

" Syntax {{{
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  " Rainbow Parentheses with treesitter
  Plug 'hiphish/rainbow-delimiters.nvim'
  " m-demare/hlargs.nvim
  Plug 'm-demare/hlargs.nvim'
  Plug 'nvim-treesitter/nvim-treesitter-context'
  " helm
  Plug 'towolf/vim-helm'
  " haml"
  Plug 'vim-scripts/Haml'
  " JavaScript
  Plug 'vim-scripts/JavaScript-syntax'
  " jQuery
  Plug 'vim-scripts/jQuery'
  " nginx conf
  Plug 'vim-scripts/nginx.vim'
  " markdown
  Plug 'tpope/vim-markdown', { 'for' : 'markdown' }
  Plug 'nelstrom/vim-markdown-folding', { 'for' : 'markdown' }

  " css3 syntax
  Plug 'hail2u/vim-css3-syntax'
  " json.vim
  Plug 'elzr/vim-json', { 'for' : 'json' }
  " plantuml
  Plug 'aklt/plantuml-syntax'
  " vcl for varnish
  Plug 'smerrill/vcl-vim-plugin'
  " tweekmonster/hl-goimport.vim
  Plug 'tweekmonster/hl-goimport.vim', { 'for' : 'go' }
  " RRethy/vim-illuminate
  Plug 'RRethy/vim-illuminate'
  Plug 'norcalli/nvim-colorizer.lua'
" }}}

" Utility {{{
  " vimproc : vimから非同期実行。vimshelleで必要
  Plug 'Shougo/vimproc.vim'
  " lambdalisue/fern.vim : 左ペインにファイル一覧を表示するプラグイン。
  " TODO 別のプラグインに置き換えたい候補
  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/fern-git-status.vim'
  Plug 'lambdalisue/nerdfont.vim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  Plug 'lambdalisue/glyph-palette.vim'
  " vimからGit操作する
  Plug 'tpope/vim-fugitive'
  " Github連携強化のプラグイン。GBrowseで開くとかのやつ
  Plug 'tpope/vim-rhubarb'
  " gitgutter
  Plug 'airblade/vim-gitgutter'
  " ステータスラインをカッコよくする
  Plug 'vim-airline/vim-airline'
  if has('nvim')
    " 'akinsho/bufferline.nvim'
    Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
  endif
  " 分割を維持してバッファ削除
  Plug 'rgarver/Kwbd.vim'
  " 現在開いている以外のバッファを全部削除
  Plug 'duff/vim-bufonly'
  " Use vim as a binary editor
  Plug 'Shougo/vinarise'
  " markdownのアウトライン表示
  Plug 'vim-voom/VOoM'
  " taskpaper.vim
  Plug 'davidoc/taskpaper.vim'
  " foldtextの見た目をよくする
  Plug 'LeafCage/foldCC'
  " repeat.vim
  Plug 'tpope/vim-repeat'
  " DirDiff.vim
  Plug 'vim-scripts/DirDiff.vim'
  " benchvimrc-vim
  " Plug 'mattn/benchvimrc-vim'
  " カーソル下のワードをDashで検索する
  Plug 'rizzatti/dash.vim'
  " rickhowe/diffchar.vim
  Plug 'rickhowe/diffchar.vim'
  " haya14busa/vim-asterisk
  " アスタリスク入力後にカーソルが移動しないのを防ぐ効果がある。
  Plug 'haya14busa/vim-asterisk'
  " ryanoasis/vim-devicons
  Plug 'ryanoasis/vim-devicons'
  if has('nvim')
    " kevinhwang91/nvim-bqf
    Plug 'kevinhwang91/nvim-bqf'
  endif
  function! UpdateRemotePlugins(...)
    " Needed to refresh runtime files
    let &rtp=&rtp
    UpdateRemotePlugins
  endfunction
  " tyru/open-browser.vim
  Plug 'tyru/open-browser.vim'
  " itchyny/vim-cursorword
  Plug 'itchyny/vim-cursorword'
  "
" }}}

" ColorSchema{{{{
  " color schema 256
  Plug 'sainnhe/gruvbox-material'
" }}}

" Incremental Search {{{{
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
" }}}
call plug#end()

filetype plugin indent on

