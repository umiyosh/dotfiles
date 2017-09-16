#!/usr/bin/env bash
set -eu

# Tash is ~/.local/share/Trash

OPTIND=''
REC_FLG=0

function print_help() {
      printf "rm [-f | -i] [-dPRrvW] file ...\n"
      printf "this command is $0 alias\n"
      printf "And the tash directory is ~/.local/share/Trash\n"

}

while getopts "option rfdPRvWih" OPT
do
  case $OPT in
    r )
      REC_FLG=1
      ;;
    f )
      ;;
    d )
      ;;
    P )
      ;;
    R )
      REC_FLG=1
      ;;
    v )
      ;;
    W )
      ;;
    i )
      ;;
    h)
      print_help
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

