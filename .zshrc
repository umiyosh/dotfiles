## basic configuration
source ~/dotfiles/.zshrc.basic

## Prompt Setting
source ~/dotfiles/.zshrc.prompt

## Complition Setting
source ~/dotfiles/.zshrc.complition

## keybind Setting
source ~/dotfiles/.zshrc.keybind

# zgen: plugin or extensive stuff
source ~/dotfiles/.zshrc.zgen

## Terminal Setting
source ~/dotfiles/.zshrc.terminal

## PATH Setting
source ~/dotfiles/.zshrc.path

## Alias Setting
source ~/dotfiles/.zshrc.alias

# Incremental search
# Note: I have't use peco. So I'll change the filename in near future.
source ~/dotfiles/.zshrc.peco

# zshrc Setting per OSTYPE
case "${OSTYPE}" in
# Mac(Unix)
darwin*)
  [ -f ~/dotfiles/.zshrc.osx ] && source ~/dotfiles/.zshrc.osx
  ;;
# Linux
linux*)
  [ -f ~/dotfiles/.zshrc.linux ] && source ~/dotfiles/.zshrc.linux
  ;;
esac

## Setting for each language
source ~/dotfiles/.zshrc.devenv

## local zshrc settings
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# profiler
# usage: modifie .zshenv and modifie this
# if type zprof > /dev/null 2>&1; then
  # zprof | less
# fi

if hash mvim; then
    export EDITOR='mvim'
fi

[[ -z "$TMUX" && ! -z "$PS1" ]] && tmux

