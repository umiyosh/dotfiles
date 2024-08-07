scriptencoding utf-8
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

"基本設定
source ~/dotfiles/basic.vim
"StatusLine設定
source ~/dotfiles/statusline.vim
"インデント設定
source ~/dotfiles/indent.vim
"Tags関連
source ~/dotfiles/tags.vim
"検索関連
source ~/dotfiles/search.vim
"移動関連
source ~/dotfiles/moving.vim
"編集関連
source ~/dotfiles/editing.vim
"エンコーディング関連
source ~/dotfiles/encoding.vim
"その他
source ~/dotfiles/misc.vim
"補完関連
source ~/dotfiles/completion.vim
"terminal関連
source ~/dotfiles/terminal.vim
"表示関連
source ~/dotfiles/apperance.vim

" 外に見せたくない環境変数など設定用
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

" Load .vimrc.local if it exists.
if filereadable(expand('~/dotfiles_private/local.vim'))
  source ~/dotfiles_private/local.vim
endif

" plugin settings
if exists('g:vscode')
    " VSCode extension
    " source ~/dotfiles/.vimrc.vscode.plugsetup
else
    source ~/dotfiles/plugsetup_neovim.vim
endif

" カラースキーム
source ~/dotfiles/colors.vim
