set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

if exists('g:vscode')
    " VSCode extension
else
    source ~/.vimrc
    source ~/dotfiles/.vimrc.neovim.plugsetup
endif
