
" keymap
nnoremap <silent> sh <cmd>belowright 10split<CR><cmd>terminal<CR>

" ターミナルを開いたらに常にinsertモードに入る
autocmd TermOpen * :startinsert

" ターミナルモードで行番号を非表示
autocmd TermOpen * setlocal norelativenumber
autocmd TermOpen * setlocal nonumber

