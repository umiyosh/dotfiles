# perlbrew
source $HOME/perl5/perlbrew/etc/bashrc

if [[ -s $HOME/.rvm/scripts/rvm ]]
then
    source "$HOME/.rvm/scripts/rvm"
fi
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

source "$HOME/.zshenv.local"

