# -*- sh -*-
zmodload zsh/parameter

function zaw-src-j() {
    # see http://stackoverflow.com/questions/452290/ for IFS trick
    IFS=$(echo -n -e "\0")
    : ${(A)candidates::=$(jumpstat | perl -e 'while(<>){push @line, $_}
    for $jumplist (reverse @line){@jumplist = split /\t/, $jumplist;$jumplist[1] =~ s/ /\\ /g;print "$jumplist[1]"}' | tr '\n' '\0')}
    unset IFS
    actions=("zaw-callback-execute" "zaw-callback-replace-buffer" "zaw-callback-append-to-buffer")
    act_descriptions=("execute" "replace edit buffer" "append to edit buffer")
}

zaw-register-src -n j zaw-src-j

