#!/usr/bin/env zsh
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title olog
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📝
# @raycast.packageName Obsidian
# 引数を1つ（テキスト）受け取る。Raycast側でエンコードしない想定なので percentEncoded は false 推奨
# @raycast.argument1 {"type":"text","placeholder":"memo (query)","optional":false}

# Documentation:
# @raycast.author umiyosh
# @raycast.description Append a line to Obsidian Daily note via Advanced URI

url_encode() {
  python3 -c 'import sys, urllib.parse; print(urllib.parse.quote(urllib.parse.quote(sys.argv[1])))' "$*"
}

current_time=$(date "+%H:%M:%S")
input=$(echo "$*" | tr '\n' ' ')

# echo "Input: $input"
memo=$(url_encode "$input")
# echo "Memo: $memo"
# echo "URL: obsidian://advanced-uri?vault=ObsidianVault&daily=true&mode=append&data=-%20${current_time}%20${memo}"
open -g "obsidian://advanced-uri?vault=ObsidianVault&daily=true&mode=append&data=-%20${current_time}%20${memo}"
