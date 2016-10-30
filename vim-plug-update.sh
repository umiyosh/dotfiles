#!/usr/bin/env zsh
set -e

vim -Nu "$HOME/dotfiles/.vimrc.plug" +PlugUpdate! +qall

