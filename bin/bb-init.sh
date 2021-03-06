#!/usr/bin/env bash

# Create private repo on bitbucket.org

url=https://bitbucket.org/umiyosh_

projectRoot=$(git rev-parse --show-toplevel)
if [[ $? -ne 0 ]]; then
  if [[ ! -e ./README.md ]]; then
    curl -L http://git.io/Xy0Chg -o README.md
  fi
  git init
  git add .
  git commit -m 'initial commited'
  projectRoot=$(git rev-parse --show-toplevel)
fi
projectName=$(basename "$projectRoot")
bb create --private $projectName
git remote add origin $url/$projectName
git push origin master

