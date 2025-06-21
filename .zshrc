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

# profiler
# usage: modifie .zshenv and modifie this
# if type zprof > /dev/null 2>&1; then
  # zprof | less
# fi


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/a14073/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
    # eval "$__conda_setup"
# else
    # if [ -f "/Users/a14073/anaconda3/etc/profile.d/conda.sh" ]; then
        # . "/Users/a14073/anaconda3/etc/profile.d/conda.sh"
    # else
        # export PATH="/Users/a14073/anaconda3/bin:$PATH"
    # fi
# fi
# unset __conda_setup
# <<< conda initialize <<<


# Shell-GPT integration ZSH v0.2
_sgpt_zsh() {
if [[ -n "$BUFFER" ]]; then
    _sgpt_prev_cmd=$BUFFER
    BUFFER+="⌛"
    zle -I && zle redisplay
    BUFFER=$(sgpt --shell <<< "$_sgpt_prev_cmd" --no-interaction)
    zle end-of-line
fi
}
zle -N _sgpt_zsh
bindkey '^x' _sgpt_zsh
# Shell-GPT integration ZSH v0.2

# pnpm
export PNPM_HOME="/Users/a14073/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
. "/Users/a14073/.deno/env"