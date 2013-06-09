# -*- sh -*-
zmodload zsh/parameter

function zaw-src-j() {
  : ${(A)candidates::=${(@f)"$(
    autojump --stat | \
      perl -e '
        while(<>){push @line, $_}
        for $jumplist (reverse @line){
          @jumplist = split /\t/, $jumplist;
          $jumplist[1] =~ s/ /\\ /g;
          print "$jumplist[1]"
        }'
    )"}\
  }
  actions=("zaw-callback-execute" "zaw-callback-replace-buffer" "zaw-callback-append-to-buffer")
  act_descriptions=("execute" "replace edit buffer" "append to edit buffer")
}

zaw-register-src -n j zaw-src-j
