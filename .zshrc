## basic configuration
source ~/dotfiles/.zshrc.basic

## Prompt Setting (Oh My Posh -> fallback to powerline)
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

if [[ -z "$TMUX" && -n "$PS1" ]]; then      # tmux外 & 対話シェルの場合
  if [[ -n "$CMUX_WORKSPACE_ID" ]]; then # cmux workspaceごとにtmux serverを分離
    cmux_tmux_socket="cmux-${CMUX_WORKSPACE_ID//[^A-Za-z0-9_.-]/_}"
    exec tmux -L "$cmux_tmux_socket"
  elif [[ -n "$SSH_CLIENT" ]]; then # SSH経由の接続 (Termiusなど)
    exec tmux new-session -A -s "claude"   # attach or create
  else # Mac本体のターミナルなど、ローカルでの接続
    tmux
  fi
fi

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
    BUFFER=$(sgpt --shell --model gpt-5.6-terra --temperature 1 <<< "$_sgpt_prev_cmd" --no-interaction)
    zle end-of-line
fi
}
zle -N _sgpt_zsh
bindkey '^x' _sgpt_zsh
# Shell-GPT integration ZSH v0.2

# pnpm
export PNPM_HOME=~/Library/pnpm
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
. "${HOME}/.deno/env"

# cmux 配下の tmux ペインでは cmux のシェル連携が読み込まれず、claude が cmux の
# 差し替え版（状態通知のフックを注入する）を通らないため、サイドバーにエージェントの
# 状態が出ない。tmux サーバーから引き継いだ差し替え版のディレクトリを PATH の先頭へ戻す。
# インストーラーが .zshrc の末尾へ PATH を追記しても負けないよう、初期化がすべて
# 終わった最初のプロンプトの直前に 1 度だけ行う（cmux の _cmux_fix_path と同じ方式）。
if [[ -n "$TMUX" && -n "$CMUX_SURFACE_ID" && -x "${CMUX_CLAUDE_WRAPPER_SHIM_ROOT:-}/claude" ]]; then
  _cmux_shim_first() {
    path=("$CMUX_CLAUDE_WRAPPER_SHIM_ROOT" ${path:#$CMUX_CLAUDE_WRAPPER_SHIM_ROOT})
    add-zsh-hook -d precmd _cmux_shim_first
  }
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd _cmux_shim_first
fi

# cmux 配下の tmux ペインで cd したら、選択中のペインに限り、移動先を cmux のサイドバーへ知らせる。
# ペインやウィンドウの切り替えは .tmux.conf のフックが知らせるが、tmux にはディレクトリ移動の
# フックが無いため、ここから同じ処理（@cmux_report_pwd）を呼ぶ。
if [[ -n "$TMUX" && -n "$CMUX_SURFACE_ID" ]]; then
  _cmux_tmux_report_pwd() {
    (( ZSH_SUBSHELL == 0 )) || return 0
    [[ "$(tmux display -p -t "$TMUX_PANE" '#{pane_active}#{window_active}' 2>/dev/null)" == 11 ]] || return 0
    tmux run-shell -b -t "$TMUX_PANE" '#{E:@cmux_report_pwd}' 2>/dev/null
  }
  autoload -Uz add-zsh-hook
  add-zsh-hook chpwd _cmux_tmux_report_pwd
fi

# gvmのcdフックを最終的に無効化（Claude Code環境対策）
# この行は絶対に.zshrcの最後に置くこと
unset -f cd 2>/dev/null

# >>> otty shell integration >>>
# Added by Otty — toggle in Settings > Shell > Shell Integration.
# Inert unless launched by Otty (it sets $OTTY_SHELL_INTEGRATION).
if [ -n "$OTTY_SHELL_INTEGRATION" ] && [ -r "$OTTY_SHELL_INTEGRATION/otty-integration.zsh" ]; then
  . "$OTTY_SHELL_INTEGRATION/otty-integration.zsh"
fi
# <<< otty shell integration <<<


# Added by Antigravity CLI installer
export PATH="~/.local/bin:$PATH"
