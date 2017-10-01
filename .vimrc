if has('python3')
endif

scriptencoding utf-8
"vunlde.vimで管理してるpluginを読み込む
source ~/dotfiles/.vimrc.plug

"基本設定
source ~/dotfiles/.vimrc.basic
"StatusLine設定
source ~/dotfiles/.vimrc.statusline
"インデント設定
source ~/dotfiles/.vimrc.indent
"表示関連
source ~/dotfiles/.vimrc.apperance
"補完関連
source ~/dotfiles/.vimrc.completion
"Tags関連
source ~/dotfiles/.vimrc.tags
"検索関連
source ~/dotfiles/.vimrc.search
"移動関連
source ~/dotfiles/.vimrc.moving
"Color関連
source ~/dotfiles/.vimrc.colors
"編集関連
source ~/dotfiles/.vimrc.editing
"エンコーディング関連
source ~/dotfiles/.vimrc.encoding
"その他
source ~/dotfiles/.vimrc.misc
"プラグインに依存するアレ
source ~/dotfiles/.vimrc.plugins_setting

" 外に見せたくない環境変数など設定用
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
