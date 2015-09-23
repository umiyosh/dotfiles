#!/usr/bin/env bash
set -eu

function deployDotfiles() {
  DOT_FILES=( .tigrc .ideavimrc .agignore .zshrc .zshrc.peco \
              .zshrc.alias .zshrc.linux .zshrc.osx .zshenv \
              .ctags .gdbinit .gemrc .gitconfig .gitignore \
              .inputrc .irbrc .sbtconfig .screenrc .vimrc \
              .gvimrc .vrapperrc import.scala .tmux.conf \
              .dir_colors .rdebugrc .rvmrc .perltidyrc .mackup.cfg
             )
  DOT_DIRS=(.zsh .vim .peco )

  # dotfiles
  for file in ${DOT_FILES[@]}
  do
    if [[ -L $HOME/$file ]]; then
      mv $HOME/$file $HOME/${file}.orig.$(date +"%Y%m%d%H%M%S")
    fi
    if [[ ! -f $HOME/$file ]]; then
      ln -s $HOME/dotfiles/$file $HOME/$file
    fi
  done

  # dotdirs
  for directory in ${DOT_DIRS[@]}
  do
    if [[ ! -d $HOME/${directory}/ ]]; then
     ln -s $HOME/dotfiles/${directory} $HOME/${directory}
    fi
  done

  # local dotfile
  if [[ -e $HOME/Dropbox/.zshrc.local ]]; then
    ln -s $HOME/Dropbox/conf/.zshrc.local $HOME/.zshrc.local
  fi
}

function changeShell() {
  if [[ ! "$SHELL" =~ .+zsh$ ]]; then
    sudo chsh -s $(which zsh)
  fi
}

function deployLocalBin() {
  if [[ ! -d $HOME/local/bin ]]; then
    mkdir -p $HOME/local/bin/
    ln -s $HOME/dotfiles/bin/git_diff_wrapper $HOME/local/bin/git_diff_wrapper
    ln -s $HOME/dotfiles/bin/php-xdebug $HOME/local/bin/php-xdebug
  fi
}

function deploySnippets() {
  if [[ ! -d $HOME/.vim/snippets ]]; then
    git clone https://github.com/umiyosh/snippets.git $HOME/.vim/snippets/
  fi
}

function installAntigen() {
  ## antigen
  if [[ ! -d $HOME/.zsh/extention/antigen/ ]]; then
   git clone https://github.com/zsh-users/antigen.git $HOME/.zsh/extention/antigen/
  fi
}

function installAutojump() {
## zsh-autojump
  if ! autojump --stat 1>/dev/null 2>&1; then
    case "${OSTYPE}" in
    darwin*)
      brew install autojump
      ;;
    linux*)
      git clone https://github.com/joelthelion/autojump.git $HOME/.zsh/extention/autojump
      cd $HOME/.zsh/extention/autojump/
      ./install.py
      cd $HOME/dotfiles/
      ;;
    esac
  fi
}

function installPeco() {
  ## peco
  if ! which peco; then
    case "${OSTYPE}" in
    darwin*)
      brew tap peco/peco
      brew install peco
      brew install migemogrep
      ;;
    linux*)
      go get github.com/peco/peco/cmd/peco
      go get github.com/peco/migemogrep
      ;;
    esac
  fi
}

function setupVimPlugins() {
  # vim
  ## vunndle and BundleInstall and make vimproc
  if [[ ! -d $HOME/.vim/bundle/vundle/ ]]; then
    mkdir -p $HOME/.vim/bundle/
    git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle/
    vim -Nu $HOME/dotfiles/.vimrc.bundle +BundleInstall! +qall
    cd $HOME/.vim/bundle/vimproc/
    case "${OSTYPE}" in
    darwin*)
      make -f make_mac.mak
      ;;
    linux*)
      make -f make_unix.mak
      ;;
    esac
    cd $HOME/dotfiles/
  else
    vim -Nu $HOME/dotfiles/.vimrc.bundle +BundleInstall +qall
  fi
  if [[ -z $CIRCLECI ]]; then
    vim +GoInstallBinaries +qall
  fi
}

deployDotfiles
changeShell
deployLocalBin
deploySnippets
installAntigen
installAutojump
installPeco
setupVimPlugins

