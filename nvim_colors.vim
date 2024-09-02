scriptencoding utf-8
"-------------------------------------------------------------------------------
" カラー関連 Colors
"-------------------------------------------------------------------------------
" カラースキームの設定
colo gruvbox-material
set background=dark

" カレントウィンドウにのみ罫線を引く
" https://mactkg.hateblo.jp/entry/2013/01/04/102258
" カーソル行のハイライト
augroup clh
  autocmd! clh
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END
" カーソル列のハイライト
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorcolumn
  autocmd WinEnter,BufRead * set cursorcolumn
augroup END

" カーソル行のハイライト色の設定
hi clear CursorLine
hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

" ハイライト on
syntax enable
hi Normal   ctermbg=none
hi PmenuSel cterm=reverse ctermfg=33 ctermbg=222

" 選択範囲を明るい色で見やすく調整
highlight Visual cterm=NONE ctermbg=189 ctermfg=NONE guibg=#DFDFFF guifg=NONE

" true color
set termguicolors

set pumblend=10
set winblend=10
hi! Normal ctermbg=NONE guibg=NONE
