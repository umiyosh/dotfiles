#!/bin/bash

DOT_FILES=( .zshrc .zshrc.alias .zshrc.linux .zshrc.osx .zshenv .ctags .emacs.el .gdbinit .gemrc .gitconfig .gitignore .inputrc .irbrc .sbtconfig .screenrc .vimrc .gvimrc .vrapperrc import.scala .tmux.conf .dir_colors .rdebugrc .rvmrc )

# dotfiles
for file in ${DOT_FILES[@]}
do
    if [[ ! -L $HOME/$file ]]; then
        mv $HOME/$file $HOME/${file}.orig.$(date +"%Y%m%d%H%M%S")
    fi
    if [[ ! -f $HOME/$file ]]; then
        ln -s $HOME/dotfiles/$file $HOME/$file
    fi
done

if [[ ! -d $HOME/.zsh/ ]]; then
   ln -s $HOME/dotfiles/.zsh $HOME/.zsh
fi

if [[ ! -d $HOME/.vim/ ]]; then
    ln -s $HOME/dotfiles/.vim/ $HOME/.vim/
fi

if [[ ! -d $HOME/local/bin ]]; then
    mkdir -p $HOME/local/bin/
    ln -s $HOME/dotfiles/bin/git_diff_wrapper $HOME/local/bin/git_diff_wrapper
fi

if [[ ! -d $HOME/.vim/snippets ]]; then
    git clone https://github.com/umiyosh/snippets.git $HOME/.vim/snippets/
fi

# zsh extention
## antigen
if [[ ! -d ~/.zsh/extention/antigen/ ]]; then
   git clone https://github.com/zsh-users/antigen.git ~/.zsh/extention/antigen/
fi

## zsh-autojump
if ! autojump --stat 1>/dev/null 2>&1; then
    case "${OSTYPE}" in
    darwin*)
        brew install autojump
        ;;
    linux*)
        git clone git://github.com/joelthelion/autojump.git ~/.zsh/extention/autojump
        cd ~/.zsh/extention/autojump/
        ./install.sh --local
        cd ~/dotfiles/
        ;;
    esac
fi

# vim
## vunndle and BundleInstall and make vimproc
if [[ ! -d ~/.vim/bundle/vundle/ ]]; then
    mkdir -p ~/.vim/bundle/
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle/
    vim -Nu ~/dotfiles/.vimrc.bundle +BundleInstall! +qall
    cd
    cd ~/.vim/bundle/vimproc/
    case "${OSTYPE}" in
    darwin*)
        make -f make_mac.mak
        ;;
    linux*)
        make -f make_unix.mak
        ;;
    esac
fi
