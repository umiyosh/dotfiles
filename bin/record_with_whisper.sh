#!/usr/bin/env zsh

# クリップボードを空にする
pbcopy < /dev/null

# SuperWhisper を開いて、record モードにする
open superwhisper://record

# クリップボードが空の場合は、何か入力されるまで待機する
while [ -z "$(pbpaste)" ]; do
    sleep 0.5
done
