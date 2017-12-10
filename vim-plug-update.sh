#!/usr/bin/env zsh
set -e

mvim -v -Nu "$HOME/dotfiles/.vimrc.plug" +PlugUpdate! +qall

