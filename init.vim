scriptencoding utf-8
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

"基本設定
source ~/dotfiles/nvim_basic.vim
"StatusLine設定
source ~/dotfiles/nvim_statusline.vim
"インデント設定
source ~/dotfiles/nvim_indent.vim
"Tags関連
source ~/dotfiles/nvim_tags.vim
"検索関連
source ~/dotfiles/nvim_search.vim
"移動関連
source ~/dotfiles/nvim_moving.vim
"編集関連
source ~/dotfiles/nvim_editing.vim
"エンコーディング関連
source ~/dotfiles/nvim_encoding.vim
"その他
source ~/dotfiles/nvim_misc.vim
"補完関連
source ~/dotfiles/nvim_completion.vim
"terminal関連
source ~/dotfiles/nvim_terminal.vim
"表示関連
source ~/dotfiles/nvim_apperance.vim

" 外に見せたくない環境変数など設定用
if filereadable(expand('~/nvim_local.vim'))
  source ~/nvim_local.vim
endif

" Load .vimrc.local if it exists.
if filereadable(expand('~/dotfiles_private/nvim_local.vim'))
  source ~/dotfiles_private/nvim_local.vim
endif

" plugin settings
if exists('g:vscode')
    " VSCode extension
    " source ~/dotfiles/nvim_plugsetup_vscode.vim
else
    source ~/dotfiles/nvim_plugsetup_neovim.vim
endif

" カラースキーム
source ~/dotfiles/nvim_colors.vim
