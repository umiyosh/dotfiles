#!/usr/bin/env bash
set -eu

query="$*"

open "https://chatgpt.com/?q=${query}&hints=search&ref=ext&temporary-chat=true"
