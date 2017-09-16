#!/usr/bin/env bash
set -eu

# Tash is ~/.local/share/Trash

OPTIND=''
REC_FLG=0

while getopts "option rf" OPT
do
  case $OPT in
    r )
      REC_FLG=1
      ;;
    f )
      ;;
    h )
      printf "rm [-f | -i] [-dPRrvW] file ...\n"
      exit 2
      ;;
    * )
      ;;
  esac
done

shift $((OPTIND - 1))

for file_path in $@; do
  if [[ $REC_FLG -eq 1 ]]; then
    trash-put $file_path
  else
    if [[ -d $file_path ]]; then
      rm $file_path
    fi
    trash-put $file_path
  fi
done

