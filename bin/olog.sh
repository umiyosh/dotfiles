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
