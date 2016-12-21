## 基本設定
source ~/dotfiles/.zshrc.basic

## Default shell configuration
source ~/dotfiles/.zshrc.prompt

## 補間
source ~/dotfiles/.zshrc.complition

## keybind関連
source ~/dotfiles/.zshrc.keybind

## zgen :pluginとか拡張的なものとか
source ~/dotfiles/.zshrc.zgen

## terminal設定
source ~/dotfiles/.zshrc.terminal

## path関連
source ~/dotfiles/.zshrc.path

## alias設定
source ~/dotfiles/.zshrc.alias

## peco設定
source ~/dotfiles/.zshrc.peco

## OSTYPE毎のzshrc
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

## 各言語の設定
source ~/dotfiles/.zshrc.devenv

## local zshrc設定
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# profiler
# usage: modifie .zshenv and modifie this
# if type zprof > /dev/null 2>&1; then
  # zprof | less
# fi

[[ -z "$TMUX" && ! -z "$PS1" ]] && tmux
