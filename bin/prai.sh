#!/usr/bin/env zsh
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title prai
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📖
# @raycast.packageName ProofRead

# Documentation:
# @raycast.author umiyosh
# @raycast.description Execute proof reading script via prai

source ~/python_v3.13/bin/activate
$HOME/dvlp/prai/pr.sh

echo "proof readed"
afplay /System/Library/Sounds/Submarine.aiff
