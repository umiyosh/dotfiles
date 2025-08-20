#!/bin/bash
# .bashrc for AI coding agents
# Based on .zshrc configuration

## Basic PATH configuration
export PATH=$PATH:$HOME/local/bin:/usr/local/git/bin
export PATH=$PATH:$HOME/dotfiles/bin
export PATH=$PATH:/sbin:/usr/local/bin
export MANPATH=$MANPATH:/opt/local/man:/usr/local/share/man

# Python
export PATH=~/.local/bin:$PATH
if [ -f ~/python_v3.13/bin/activate ]; then
  source ~/python_v3.13/bin/activate
fi

# direnv (bash compatible)
if command -v direnv &> /dev/null; then
  eval "$(direnv hook bash)"
fi

# Node.js
export PATH=$PATH:${HOME}/.nodebrew/current/bin

# Golang with GVM
if [ -f $HOME/.gvm/scripts/gvm ]; then
  source $HOME/.gvm/scripts/gvm
  # Disable GVM's cd auto-switching (GitHub issue #479)
  unset -f cd 2>/dev/null || true
fi

# rbenv
if command -v rbenv &> /dev/null; then
  export PATH="$HOME/.rbenv/shims:$PATH"
  eval "$(rbenv init -)"
fi

# Java
export JAVA_HOME=/opt/homebrew/opt/openjdk@11
export PATH=$JAVA_HOME/bin:$PATH

# Google Cloud SDK
if [ -f "${HOME}/google-cloud-sdk/path.bash.inc" ]; then
  source "${HOME}/google-cloud-sdk/path.bash.inc"
fi
if [ -f "${HOME}/google-cloud-sdk/completion.bash.inc" ]; then
  source "${HOME}/google-cloud-sdk/completion.bash.inc"
fi

# Kubernetes
export PATH="${PATH}:${HOME}/.krew/bin"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/a14073/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Deno
if [ -f "/Users/a14073/.deno/env" ]; then
  . "/Users/a14073/.deno/env"
fi

# tfenv
if [ -f $HOME/tfenv/bin/tfenv ]; then
  export PATH=$PATH:$HOME/tfenv/bin/
fi

# OpenSSL
export PATH="/usr/local/opt/openssl/bin:$PATH"
export CFLAGS="-I/usr/local/opt/openssl/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"

# Python libexec
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# tflint
export PATH=/usr/local/tflint/bin:$PATH

# OS-specific settings
case "${OSTYPE}" in
  darwin*)
    PATH=$HOME/.cabal/bin:$PATH
    export PATH=$PATH:/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/
    export PATH=/usr/local/bin:/usr/local/sbin:$PATH
    export PATH=/opt/local/bin:/opt/local/sbin/:~/bin:$PATH
    MANPATH=/usr/local/man:$MANPATH
    export MANPATH
    INFOPATH=/usr/local/info:$INFOPATH
    export INFOPATH
    export NODE_PATH=/usr/local/lib/node:$PATH
    export PATH=/usr/local/share/npm/bin:$PATH
    ;;
esac

# Basic aliases
alias ll="ls -la"
alias 'ps?'='pgrep -l -f'

# Git aliases
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline -10'

# Ensure cd is not overridden (final check)
unset -f cd 2>/dev/null || true

# Local bashrc settings
[ -f ~/.bashrc.local ] && source ~/.bashrc.local