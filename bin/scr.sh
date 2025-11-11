#!/usr/bin/env bash
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title scr
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🖥️
# @raycast.packageName System

# Documentation:
# @raycast.author umiyosh
# @raycast.description Start macOS screensaver

open -a /System/Library/CoreServices/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine

