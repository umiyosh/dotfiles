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
source ~/dotfiles/.zshrc.selector

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


[[ -z "$TMUX" && ! -z "$PS1" ]] && tmux

# [Command Completion by Default · Issue \#345 · moovweb/gvm](https://github.com/moovweb/gvm/issues/345)
[[ -s ~/.gvm/scripts/completion ]] && source ~/.gvm/scripts/completion

# profiler
# usage: modifie .zshenv and modifie this
# if type zprof > /dev/null 2>&1; then
  # zprof | less
# fi
