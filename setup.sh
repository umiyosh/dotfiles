#!/bin/bash

DOT_FILES=( .zsh .zshrc .zshrc.alias .zshrc.linux .zshrc.osx .zshenv .ctags .emacs.el .gdbinit .gemrc .gitconfig .gitignore .inputrc .irbrc .sbtconfig .screenrc .vimrc .gvimrc .vrapperrc import.scala .tmux.conf .dir_colors .rdebugrc)

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
