# and comment out plofiler dump command at .zshrc
# zmodload zsh/zprof
#
export EDITOR='mvim'
export XDG_CONFIG_HOME="$HOME/.config"
. "$HOME/.cargo/env"
# gvm を source した直後に
unfunction cd 2>/dev/null || true

