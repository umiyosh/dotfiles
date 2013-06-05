# users generic .zshrc file for zsh(1)


## Environment variable configuration
#
# LANG
# http://curiousabt.blog27.fc2.com/blog-entry-65.html
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

## Backspace key
#
bindkey "^?" backward-delete-char

## local zshrc設定
#
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

## Default shell configuration
#
# set prompt
# colors enables us to idenfity color by $fg[red].
autoload colors
colors
case ${UID} in
    0)
        setopt prompt_subst
        source ~/dotfiles/.zshrc.prompt
        ;;
    *)
        #
        # Color
        #
        DEFAULT=$'%{\e[1;0m%}'
        RESET="%{${reset_color}%}"
        #GREEN=$'%{\e[1;32m%}'
        GREEN="%{${fg[green]}%}"
        #BLUE=$'%{\e[1;35m%}'
        BLUE="%{${fg[blue]}%}"
        RED="%{${fg[red]}%}"
        CYAN="%{${fg[cyan]}%}"
        WHITE="%{${fg[white]}%}"
        #
        # Prompt
        #
        setopt prompt_subst
        source ~/dotfiles/.zshrc.prompt

        # Show git branch when you are in git repository
        # http://d.hatena.ne.jp/mollifier/20100906/p1

        autoload -Uz add-zsh-hook
        autoload -Uz vcs_info

        zstyle ':vcs_info:*' enable git svn hg bzr
        zstyle ':vcs_info:*' formats '(%s)-[%b]'
        zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
        zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
        zstyle ':vcs_info:bzr:*' use-simple true

        autoload -Uz is-at-least
        if is-at-least 4.3.10; then
          # この check-for-changes が今回の設定するところ
          zstyle ':vcs_info:git:*' check-for-changes true
          zstyle ':vcs_info:git:*' stagedstr "+"    # 適当な文字列に変更する
          zstyle ':vcs_info:git:*' unstagedstr "-"  # 適当の文字列に変更する
          zstyle ':vcs_info:git:*' formats '(%s)-[%c%u%b]'
          zstyle ':vcs_info:git:*' actionformats '(%s)-[%c%u%b|%a]'
        fi

        function _update_vcs_info_msg() {
            psvar=()
            LANG=en_US.UTF-8 vcs_info
            psvar[2]=$(_git_not_pushed)
            [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
        }
        add-zsh-hook precmd _update_vcs_info_msg

        function _git_not_pushed()
        {
          if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
            head="$(git rev-parse HEAD)"
            for x in $(git rev-parse --remotes)
            do
              if [ "$head" = "$x" ]; then
                return 0
              fi
            done
            echo "{?}"
          fi
          return 0
        }

    ;;
esac

# 指定したコマンド名がなく、ディレクトリ名と一致した場合 cd する
setopt auto_cd

# cd でTabを押すとdir list を表示
setopt auto_pushd

# ディレクトリスタックに同じディレクトリを追加しないようになる
setopt pushd_ignore_dups

# 補完候補リストを詰めて表示
setopt list_packed

# auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示
setopt list_types

# 補完候補が複数ある時に、一覧表示する
setopt auto_list

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

# カッコの対応などを自動的に補完する
setopt auto_param_keys

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl

# 補完キー（Tab,  Ctrl+I) を連打するだけで順に補完候補を自動で補完する
setopt auto_menu

# sudoも補完の対象
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# 色付きで補完する
zstyle ':completion:*' list-colors di=34 fi=0
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 複数のリダイレクトやパイプなど、必要に応じて tee や cat の機能が使われる
setopt multios

# 最後がディレクトリ名で終わっている場合末尾の / を自動的に取り除かない
setopt noautoremoveslash

# beepを鳴らさないようにする
setopt nolistbeep

# Match without pattern
# ex. > rm *~398
# remove * without a file "398". For test, use "echo *~398"
setopt extended_glob

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes
#   to end of it)
#
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# glob(*)によるインクリメンタルサーチ
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

## Command Line Stack
show_buffer_stack() {
  POSTDISPLAY="
stack: $LBUFFER"
  zle push-line-or-edit
}
zle -N show_buffer_stack
setopt noflowcontrol
bindkey '^Q' show_buffer_stack

# ctrl-w, ctrl-bキーで単語移動
bindkey "^W" forward-word
bindkey "^B" backward-word
bindkey "∑" backward-kill-word
# back-wordでの単語境界の設定
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " _-./;@"
zstyle ':zle:*' word-style unspecified

## antigen :pluginとか拡張的なものとか
source ~/dotfiles/.zshrc.antigen

## Command history configuration
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# 登録済コマンド行は古い方を削除
setopt hist_ignore_all_dups

# historyの共有
setopt share_history

# 余分な空白は詰める
setopt hist_reduce_blanks

# add history when command executed.
setopt inc_append_history

# history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store

# コマンドラインでも # 以降をコメントと見なす
#setopt interactive_comments

# コマンド名に / が含まれているとき PATH 中のサブディレクトリを探す
setopt path_dirs

# for, repeat, select, if, function などで簡略文法が使えるようになる
#setopt short_loops

# ^でcd ..する
function cdup() {
echo
cd ..
zle reset-prompt
}
zle -N cdup

# URLをコピペしたときに自動でエスケープ
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# 勝手にpushd
setopt autopushd

# エラーメッセージ本文出力に色付け
e_normal=`echo -e "¥033[0;30m"`
e_RED=`echo -e "¥033[1;31m"`
e_BLUE=`echo -e "¥033[1;36m"`

function make() {
    LANG=C command make "$@" 2>&1 | sed -e "s@[Ee]rror:.*@$e_RED&$e_normal@g" -e "s@cannot¥sfind.*@$e_RED&$e_normal@g" -e "s@[Ww]arning:.*@$e_BLUE&$e_normal@g"
}
function cwaf() {
    LANG=C command ./waf "$@" 2>&1 | sed -e "s@[Ee]rror:.*@$e_RED&$e_normal@g" -e "s@cannot¥sfind.*@$e_RED&$e_normal@g" -e "s@[Ww]arning:.*@$e_BLUE&$e_normal@g"
}

## zsh editor
#
autoload zed

## zshargs
# http://d.hatena.ne.jp/lurker/20070115/1168831103
autoload zargs

## Prediction configuration
#
autoload predict-on
#predict-off

## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"

case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -alG"
    zle -N expand-to-home-or-insert
    ;;
linux*)
    alias la="ls -al"
    ;;
esac


case "${OSTYPE}" in
# MacOSX
darwin*)
    PATH=$HOME/.cabal/bin:$PATH
    export PATH=$PATH:/opt/local/bin:/opt/local/sbin/
    export PATH=$PATH:/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/
    ;;
freebsd*)
    case ${UID} in
    0)
        updateports()
        {
            if [ -f /usr/ports/.portsnap.INDEX ]
            then
                portsnap fetch update
            else
                portsnap fetch extract update
            fi
            (cd /usr/ports/; make index)

            portversion -v -l \<
        }
        alias appsupgrade='pkgdb -F && BATCH=YES NO_CHECKSUM=YES portupgrade -a'
        ;;
    esac
    ;;
esac


## terminal configuration
# http://journal.mycom.co.jp/column/zsh/009/index.html
unset LSCOLORS

case "${TERM}" in
xterm)
    export TERM=xterm-color

    ;;
kterm)
    export TERM=kterm-color
    # set BackSpace control character

    stty erase
    ;;

cons25)
    unset LANG
  export LSCOLORS=ExFxCxdxBxegedabagacad

    export LS_COLORS='di=01;32:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30'
    zstyle ':completion:*' list-colors \
        'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;

kterm*|xterm*)
    export CLICOLOR=1
    export LSCOLORS=ExFxCxDxBxegedabagacad

    zstyle ':completion:*' list-colors \
        'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    _preexec_screenwindow() {
        echo -ne "\ek#${1%% *}\e\\"
    }
    _precmd_screenwindow() {
        echo -ne "\ek#$(basename $(pwd))\e\\"
    }
    add-zsh-hook preexec _preexec_screenwindow
    add-zsh-hook precmd _precmd_screenwindow

    ;;

dumb)
    echo "Welcome Emacs Shell"
    ;;
esac



export EDITOR=vim
export PATH=$PATH:$HOME/local/bin:/usr/local/git/bin
export PATH=$PATH:$HOME/dotfiles/bin
export PATH=$PATH:/sbin:/usr/local/bin
export MANPATH=$MANPATH:/opt/local/man:/usr/local/share/man

expand-to-home-or-insert () {
        if [ "$LBUFFER" = "" -o "$LBUFFER[-1]" = " " ]; then
                LBUFFER+="~/"
        else
                zle self-insert
        fi
}

# C-M-h でチートシートを表示する
cheat-sheet () { zle -M "`cat ~/dotfiles/.zsh/cheat-sheet`" }
zle -N cheat-sheet
# bindkey "^[^h" cheat-sheet

# zsh の exntended_glob と HEAD^^^ を共存させる。
# http://subtech.g.hatena.ne.jp/cho45/20080617/1213629154
typeset -A abbreviations
abbreviations=(
  "HEAD^"     "HEAD\\^"
  "HEAD^^"    "HEAD\\^\\^"
  "HEAD^^^"   "HEAD\\^\\^\\^"
  "HEAD^^^^"  "HEAD\\^\\^\\^\\^\\^"
  "HEAD^^^^^" "HEAD\\^\\^\\^\\^\\^"
)

magic-abbrev-expand () {
  local MATCH
  LBUFFER=${LBUFFER%%(#m)[-_a-zA-Z0-9^]#}
  LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
}

magic-abbrev-expand-and-insert () {
  magic-abbrev-expand
  zle self-insert
}

magic-abbrev-expand-and-accept () {
  magic-abbrev-expand
  zle accept-line
}

no-magic-abbrev-expand () {
  LBUFFER+=' '
}

zle -N magic-abbrev-expand
zle -N magic-abbrev-expand-and-insert
zle -N magic-abbrev-expand-and-accept
zle -N no-magic-abbrev-expand
bindkey "\r"  magic-abbrev-expand-and-accept # M-x RET はできなくなる
bindkey " "   magic-abbrev-expand-and-insert
bindkey "."   magic-abbrev-expand-and-insert
bindkey "^x " no-magic-abbrev-expand

# 3秒以上かかった処理は詳細表示
# http://d.hatena.ne.jp/Yoshiori/20120814/1344913023
REPORTTIME=3

function rmf(){
   for file in $*
   do
      __rm_single_file $file
   done
}

function __rm_single_file(){
       if ! [ -d ~/.Trash/ ]
       then
               command /bin/mkdir ~/.Trash
       fi

       if ! [ $# -eq 1 ]
       then
               echo "__rm_single_file: 1 argument required but $# passed."
               exit
       fi

       if [ -e $1 ]
       then
               BASENAME=`basename $1`
               NAME=$BASENAME
               COUNT=0
               while [ -e ~/.Trash/$NAME ]
               do
                       COUNT=$(($COUNT+1))
                       NAME="$BASENAME.$COUNT"
               done

               command /bin/mv $1 ~/.Trash/$NAME
       else
               echo "No such file or directory: $file"
       fi
}

#=============================
# source auto-fu.zsh
#=============================
function zle-line-init () {
    auto-fu-init
}
zle -N zle-line-init
zstyle ':completion:*' completer _oldlist _complete _prefix _list _history

#=============================
# source zaw: zshのunite
#=============================
source ~/dotfiles/.zshrc.zaw.j
zstyle ':filter-select' case-insensitive yes
bindkey '^G' zaw
bindkey '^R' zaw-history
bindkey '^j' zaw-j

# zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root)
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[cursor]='bg=blue'
# To have paths colored instead of underlined
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
# To have commands starting with `rm -rf` in red:
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')

# zsh-completionsを利用する Github => zsh-completions
[ -d ~/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-completions.git/src ] && \
    fpath=(~/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-completions.git/src $fpath)

## alias設定
#
[ -f ~/dotfiles/.zshrc.alias ] && source ~/dotfiles/.zshrc.alias

case "${OSTYPE}" in
# Mac(Unix)
darwin*)
    # ここに設定
    [ -f ~/dotfiles/.zshrc.osx ] && source ~/dotfiles/.zshrc.osx
    ;;
# Linux
linux*)
    # ここに設定
    [ -f ~/dotfiles/.zshrc.linux ] && source ~/dotfiles/.zshrc.linux
    ;;
esac

## Completion configuration
#
# completion
# fpath=($fpath $HOME/local/functions(N))
fpath=(~/.zsh/functions/Completion ${fpath})

autoload -Uz compinit
compinit -u

zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B--- %d ---%b'

zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ln=35 di=36

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*:kill:*:processes' command 'ps x'
zstyle ':completion:*:-command-:*' \
    fake-parameters PERL5LIB # for perl
zstyle ':completion:*' completer _oldlist _complete _prefix _list _history

# menuselect中のキーバインド
zmodload zsh/complist
bindkey -M menuselect '^p' up-history
bindkey -M menuselect '^n' down-history
bindkey -M menuselect '^f' forward-char
bindkey -M menuselect '^b' backward-char

bindkey -M menuselect '^k' up-history
bindkey -M menuselect '^j' down-history
bindkey -M menuselect '^l' forward-char
bindkey -M menuselect '^h' backward-char

<<<<<<< HEAD
# ペーストが補完効いて遅いのでこうした
bindkey "^V" '^G^V'


=======
>>>>>>> parent of f332053... 使えないようなので
#screen 起動
if [[ -z "$STY" && $TERM_PROGRAM = iTerm.app ]] ; then
    screen -U
fi

