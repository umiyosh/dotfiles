#!/usr/bin/env bash

if ! git rev-parse --show-toplevel 1>/dev/null 2>&1; then
  hub init .
  if [[ ! -e ./README.md ]]; then
    touch README.md
  fi
  git add .
  git commit -m 'initial commited'
fi
hub create -p
hub push origin master
hub browse
