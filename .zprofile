export PATH=$PATH:$HOME/bin/
export PATH=$PATH:/opt/local/bin:/opt/local/sbin/
export PATH=$PATH:/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/
export PATH=$PATH:$HOME/local/bin:/usr/local/git/bin
export PATH=$PATH:$HOME/dotfiles/bin
export PATH=$PATH:$HOME/dotfiles_private/bin
export PATH=$PATH:/sbin:/usr/local/bin
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH=$PATH:${HOME}/.nodebrew/current/bin
export PATH=$PATH:${HOME}/.composer/vendor/bin
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
if [[ -f $HOME/.gvm/scripts/gvm ]]; then
  source $HOME/.gvm/scripts/gvm
fi


## local zshrc settings for macvim
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

eval "$(/opt/homebrew/bin/brew shellenv)"

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
