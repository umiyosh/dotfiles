#!/usr/bin/env bash
set -xe

function deployDotfiles() {
  DOT_FILES=( .tigrc .ideavimrc .agignore .zshrc .zshrc.selector \
              .zshrc.alias .zshrc.linux .zshrc.osx .zshenv \
              .ctags .gdbinit .gemrc .gitconfig .gitignore \
              .inputrc .irbrc .sbtconfig \
              .gvimrc .tmux.conf \
              .dir_colors .rdebugrc .perltidyrc .mackup.cfg \
              .zprofile .direnvrc
             )
  DOT_DIRS=(.zsh .vim .selector )

  # dotfiles
  for file in "${DOT_FILES[@]}"
  do
    if [[ ! -f $HOME/$file ]]; then
      ln -s "$HOME/dotfiles/$file" "$HOME/$file"
    fi
  done

  # dotdirs
  for directory in "${DOT_DIRS[@]}"
  do
    if [[ ! -d $HOME/${directory}/ ]]; then
     ln -s "$HOME/dotfiles/${directory}" "$HOME/${directory}"
    fi
  done

# TODO : ^-- SC2086 (info): Double quote to prevent globbing and word splitting.
 if [[ ! -d $HOME/.config/nvim/ ]]; then
   mkdir -p $HOME/.config/nvim/
 fi
 ln -s "$HOME/dotfiles/init.vim" "$HOME/.config/nvim/"

}

function changeShell() {
  if [[ ! "$SHELL" =~ .+zsh$ ]]; then
    if [[ -z $CIRCLECI ]]; then
      if [[ ${OSTYPE} =~ "^darwin" ]]; then
        sudo which zsh |sudo tee -a /private/etc/shells
      fi
      chsh -s "$(command -v zsh)"
    fi
  fi
}

function deployLocalBin() {
  if [[ ! -d $HOME/local/bin ]]; then
    mkdir -p "$HOME/local/bin/"
    ln -s "$HOME/dotfiles/bin/git_diff_wrapper" "$HOME/local/bin/git_diff_wrapper"
    ln -s "$HOME/dotfiles/bin/php-xdebug" "$HOME/local/bin/php-xdebug"
  fi
}

function deploySnippets() {
  if [[ ! -d $HOME/.vim/snippets ]]; then
    git clone https://github.com/umiyosh/snippets.git "$HOME/.vim/snippets/"
  fi
}

function installZgen() {
  ## zgen
  if [[ ! -d $HOME/.zsh/extention/zgen/ ]]; then
   git clone https://github.com/tarjoilija/zgen.git "$HOME/.zsh/extention/zgen/"
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
      git clone https://github.com/joelthelion/autojump.git "$HOME/.zsh/extention/autojump"
      cd "$HOME/.zsh/extention/autojump/"
      ./install.py
      cd "$HOME/dotfiles/"
      ;;
    esac
  fi
}

function installFzf() {
  if ! hash fzf; then
    case "${OSTYPE}" in
    darwin*)
      brew install fzf
      ;;
    linux*)
      git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
      ~/.fzf/install --no-key-bindings --no-completion --no-update-rc
      ;;
    esac
  fi
}

function setupVimPlugins() {
  # vim
  ## vunndle and BundleInstall and make vimproc
  ## TODO : SC2262 (warning): This alias can't be defined and used in the same parsing unit. Use a function instead.
  if [[ -e /usr/local/bin/mvim ]]; then
    alias vim='mvim -v'
  fi
  alias vim='mvim -v'
  if [[ ! -d $HOME/.vim/plugged ]]; then
    vim -Nu "$HOME/dotfiles/nvim_vimplug.vim" +PlugInstall! +qa
    cd "$HOME/.vim/plugged/vimproc.vim/"
    case "${OSTYPE}" in
    darwin*)
      make -f make_mac.mak
      ;;
    linux*)
      make -f make_unix.mak
      ;;
    esac
    cd "$HOME/dotfiles/"
  else
    # TODO 将来VS Codeで出し分けする場合、直接ファイル指定している場所を適正化する必要がある
    vim -Nu "$HOME/dotfiles/nvim_vimplug.vim" +PlugInstall! +qa
  fi
}

: "install" && {
  deployDotfiles
  changeShell
  deployLocalBin
  deploySnippets
  installZgen
  installAutojump
  installFzf
  setupVimPlugins
}
