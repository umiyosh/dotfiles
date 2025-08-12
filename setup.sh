#!/usr/bin/env bash
set -xe

function deployDotfiles() {
  DOT_FILES=( .tigrc .ideavimrc .agignore .zshrc .zshrc.selector \
              .zshrc.alias .zshrc.linux .zshrc.osx .zshenv \
              .gitconfig .gitignore \
              .tmux.conf .perltidyrc .mackup.cfg \
              .zprofile .direnvrc
             )
  DOT_DIRS=(.zsh .vim .selector )

  # dotfiles
  for file in "${DOT_FILES[@]}"
  do
    if [[ ! -e $HOME/$file ]] && [[ ! -L $HOME/$file ]]; then
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
 NVIM_CONFIG_DIR="$HOME/.config/nvim"
 if [[ ! -d "$NVIM_CONFIG_DIR" ]]; then
   mkdir -p "$NVIM_CONFIG_DIR"
 fi
 if [[ ! -L "$NVIM_CONFIG_DIR/init.lua" ]]; then
   ln -s "$HOME/dotfiles/init.lua" "$NVIM_CONFIG_DIR/init.lua"
 fi
 if [[ ! -L "$NVIM_CONFIG_DIR/lua" ]]; then
   ln -s "$HOME/dotfiles/lua" "$NVIM_CONFIG_DIR/lua"
 fi
 if [[ ! -L "$NVIM_CONFIG_DIR/ginit.vim" ]]; then
   ln -s "$HOME/dotfiles/ginit.vim" "$NVIM_CONFIG_DIR/ginit.vim"
 fi
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
  local target_dir
  target_dir="$(readlink "$HOME/.vim")/snippets"
  if [[ ! -e "$target_dir" ]]; then
    mkdir -p "$target_dir"
    git clone https://github.com/umiyosh/snippets.git "$target_dir"
  fi
}

function installZgen() {
  ## zgen
  local target_dir
  target_dir="$(readlink "$HOME/.zsh")/extention/zgen"
  if [[ ! -d "$target_dir" ]]; then
    mkdir -p "$target_dir"
    git clone https://github.com/tarjoilija/zgen.git "$target_dir"
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

function setupNeovimPlugins() {
  # Neovim with Lazy.nvim
  # Lazy.nvimのブートストラップとプラグインインストール
  if command -v nvim >/dev/null 2>&1; then
    echo "Installing Neovim plugins with Lazy.nvim..."
    nvim --headless "+Lazy! sync" +qa
  else
    echo "Neovim not found, skipping plugin installation"
  fi
}

function deployTmuxPowerline() {
  # Ensure XDG config dir exists
  local TP_SRC_DIR="$HOME/dotfiles/.config/tmux-powerline"
  local TP_DEST_DIR="$HOME/.config/tmux-powerline"

  if [[ ! -d "$HOME/.config" ]]; then
    mkdir -p "$HOME/.config"
  fi

  # Link config directory
  if [[ -L "$TP_DEST_DIR" ]]; then
    # If it's a symlink but points elsewhere, replace it
    local current_target
    current_target="$(readlink "$TP_DEST_DIR")"
    if [[ "$current_target" != "$TP_SRC_DIR" ]]; then
      rm -f "$TP_DEST_DIR"
      ln -s "$TP_SRC_DIR" "$TP_DEST_DIR"
    fi
  elif [[ -d "$TP_DEST_DIR" ]]; then
    # Backup existing dir then link
    local backup_dir
    backup_dir="${TP_DEST_DIR}.bak-$(date +%Y%m%d%H%M%S)"
    mv "$TP_DEST_DIR" "$backup_dir"
    ln -s "$TP_SRC_DIR" "$TP_DEST_DIR"
    echo "Backed up existing $TP_DEST_DIR to $backup_dir and created symlink."
  else
    ln -s "$TP_SRC_DIR" "$TP_DEST_DIR"
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
  setupNeovimPlugins
  deployTmuxPowerline
}
