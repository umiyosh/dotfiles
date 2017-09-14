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
    h )
      printf "rm [-f | -i] [-dPRrvW] file ...\n"
      exit 2
      ;;
    * )
      ;;
  esac
done

if [[ $REC_FLG -eq 1 ]]; then
  trash-put $@
else
  trash-rm
fi

