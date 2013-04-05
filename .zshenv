# perlbrew
if [[ -s $HOME/perl5/perlbrew/etc/bashrc ]]; then
    source $HOME/perl5/perlbrew/etc/bashrc
fi

if [[ -s $HOME/.rvm/scripts/rvm ]]
then
    source "$HOME/.rvm/scripts/rvm"
fi
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ -f $HOME/.zshenv.local ]] && source "$HOME/.zshenv.local"

