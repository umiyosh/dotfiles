#!/usr/bin/env zsh
set -e

# nvim-treesitter の build（:TSUpdate）は非同期で +qa に打ち切られるため、parser 更新の完了を待ってから終了する
nvim --headless "+Lazy! sync" "+lua require('nvim-treesitter').update():wait(300000)" +qa

