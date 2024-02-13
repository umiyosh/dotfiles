url_encode() {
  python -c "import urllib.parse; print(urllib.parse.quote(\"$*\"))"
}

current_time=$(date "+%H:%M")

memo=$(url_encode $(echo "$*" | tr '\n' ' '))

open -g "obsidian://advanced-uri?vault=ObsidianVault&daily=true&mode=append&data=-%20${current_time}%20${memo}"
