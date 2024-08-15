#!/usr/bin/env zsh
set -e

nvim -Nu "$HOME/dotfiles/nvim_vimplug.vim" +PlugUpdate! +qall

