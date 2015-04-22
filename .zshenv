# perlbrew
if [[ -s $HOME/perl5/perlbrew/etc/bashrc ]]; then
  source $HOME/perl5/perlbrew/etc/bashrc
fi

[[ -f $HOME/.zshenv.local ]] && source "$HOME/.zshenv.local"

eval "$($HOME/Dropbox/bin/addticket/bin/addticket init -)"

export PATH=$PATH:${HOME}/.nodebrew/current/bin
export PATH=$PATH:${HOME}/.composer/vendor/bin

