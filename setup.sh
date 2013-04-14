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

if [[ ! -d $HOME/local/bin ]]; then
    mkdir -p $HOME/local/bin/
    ln -s $HOME/dotfiles/bin/git_diff_wrapper $HOME/bin/git_diff_wrapper
fi

if [[ ! -d $HOME/.vim/snippets ]]; then
    git clone https://github.com/umiyosh/snippets.git $HOME/.vim/snippets/
fi

# zsh extention
## auto-fu.zsh.git : 自動補完強化
git clone https://github.com/hchbaw/auto-fu.zsh.git ~/.zsh/extention/auto-fu.zsh
## このブランチが今現在うまく動くようなので
cd ~/.zsh/extention/auto-fu.zsh ;git checkout -b pu origin/pu ;cd ~/dotfiles/

## zaw :zshのunite
git clone https://github.com/zsh-users/zaw.git ~/.zsh/extention/zaw

## zsh-completions.git : 補完対象追加
git clone https://github.com/zsh-users/zsh-completions.git ~/.zsh/extention/zsh-completions

## zsh-autojump
case "${OSTYPE}" in
darwin*)
    brew install autojump
    ;;
linux*)
    git clone git://github.com/joelthelion/autojump.git ~/.zsh/extention/autojump
    cd ~/.zsh/extention/autojump/
    sudo ./install.sh --zsh
    cd ~/dotfiles/
    ;;
esac

# vim
## vunndle
if [[ ! -d ~/.vim/bundle/vundle/ ]]; then
    mkdir -p ~/.vim/bundle/
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle/
fi
