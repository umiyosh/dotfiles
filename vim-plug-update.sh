#!/usr/bin/env zsh
set -e

nvim -Nu "$HOME/dotfiles/nvim_vimplug_neovim.vim" +PlugUpdate! +qall

