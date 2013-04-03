#!/bin/bash

DOT_FILES=( .zsh .zshrc .zshrc.alias .zshrc.linux .zshrc.osx .zshenv .ctags .emacs.el .gdbinit .gemrc .gitconfig .gitignore .inputrc .irbrc .sbtconfig .screenrc .vimrc .gvimrc .vrapperrc import.scala .tmux.conf .dir_colors .rdebugrc .rvmrc )

for file in ${DOT_FILES[@]}
do
    if [[ ! -d $HOME/$file ]]; then
        ln -s $HOME/dotfiles/$file $HOME/$file
    fi
done

if [[ -d $HOME/.vim/ ]]; then
    if [[ ! -d $HOME/.vim/dict ]]; then
        ln -s $HOME/dotfiles/.vim/dict $HOME/.vim/dict
    fi
else
    mkdir $HOME/.vim/
    ln -s $HOME/dotfiles/.vim/dict $HOME/.vim/dict
fi

# zsh extention
## auto-fu.zsh.git : 自動補完強化
git clone https://github.com/hchbaw/auto-fu.zsh.git ~/.zsh/extention/
## このブランチが今現在うまく動くようなので
cd ~/.zsh/extention/auto-fu.zsh ;git checkout -b pu origin/pu ;cd ~/dotfiles/
