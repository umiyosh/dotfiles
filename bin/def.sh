#!/usr/bin/env bash
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title dict
# @raycast.mode silent
# @raycast.argument1 { "type": "text", "placeholder": "Word to look up" }

# Optional parameters:
# @raycast.icon 📘
# @raycast.packageName System

# Documentation:
# @raycast.author umiyosh
# @raycast.description Look up the specified word in the macOS Dictionary app using dict:// URL scheme.

open "dict://$1"
