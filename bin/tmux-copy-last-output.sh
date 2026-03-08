#!/bin/sh
# prefix + y: 直前コマンド(プロンプト行含む)+出力をクリップボードへコピー
# OSC 133 A マーカー (zle-line-init) + tmux 3.4+ previous-prompt / next-prompt
pane="$1"
tmux copy-mode -t "$pane"
sleep 0.05
tmux send-keys -t "$pane" -X previous-prompt
tmux send-keys -t "$pane" -X begin-selection
tmux send-keys -t "$pane" -X next-prompt
tmux send-keys -t "$pane" -X cursor-up
tmux send-keys -t "$pane" -X end-of-line
tmux send-keys -t "$pane" -X copy-selection-and-cancel
