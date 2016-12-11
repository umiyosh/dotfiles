#!/usr/bin/env zsh

projectRoot=$(git rev-parse --show-toplevel)

if [[ $? -ne 0 ]]; then
  hub init .
  if [[ ! -e ./README.md ]]; then
    touch README.md
  fi
  git add .
  git commit -m 'initial commited'
  projectRoot=$(git rev-parse --show-toplevel)
fi
hub create -p
hub push origin master
hub browse
