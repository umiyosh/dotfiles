#!/usr/bin/env zsh
set -e

nvim -Nu "$HOME/dotfiles/.vimrc.plug" +PlugUpdate! +qall

