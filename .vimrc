scriptencoding utf-8
"基本設定
source ~/dotfiles/.vimrc.basic

"StatusLine設定
source ~/dotfiles/.vimrc.statusline
"インデント設定
source ~/dotfiles/.vimrc.indent
"Tags関連
source ~/dotfiles/.vimrc.tags
"検索関連
source ~/dotfiles/.vimrc.search
"移動関連
source ~/dotfiles/.vimrc.moving
"編集関連
source ~/dotfiles/.vimrc.editing
"エンコーディング関連
source ~/dotfiles/.vimrc.encoding
"その他
source ~/dotfiles/.vimrc.misc
"vunlde.vimで管理してるpluginを読み込む
" source ~/dotfiles/.vimrc.plug
"補完関連
source ~/dotfiles/.vimrc.completion
"Color関連
" source ~/dotfiles/.vimrc.colors
"terminal関連
source ~/dotfiles/.vimrc.terminal
"表示関連
source ~/dotfiles/.vimrc.apperance
"プラグインに依存するアレ
" source ~/dotfiles/.vimrc.plugins_setting

" 外に見せたくない環境変数など設定用
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

" Load .vimrc.local if it exists.
if filereadable(expand('~/dotfiles_private/.vimrc.local'))
  source ~/dotfiles_private/.vimrc.local
endif

