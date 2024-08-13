scriptencoding utf-8
"-------------------------------------------------------------------------------
" カラー関連 Colors
"-------------------------------------------------------------------------------
colo gruvbox-material
set background=dark

set cursorline
" set cursorcolumn
autocmd VimEnter,ColorScheme * : highlight CursorLine cterm=underline ctermbg=235
" カレントウィンドウにのみ罫線を引く
" https://mactkg.hateblo.jp/entry/2013/01/04/102258
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END
hi clear CursorLine
hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

" ターミナルタイプによるカラー設定
if &term =~? 'xterm-256color' || 'screen-256color'
  " 256色
  set t_Co=256
  set t_Sf=[3%dm
  set t_Sb=[4%dm
elseif &term =~? 'xterm-debian' || &term =~? 'xterm-xfree86'
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
elseif &term =~? 'xterm-color'
  set t_Co=8
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

" ハイライト on
syntax enable
hi Normal   ctermbg=none
hi PmenuSel cterm=reverse ctermfg=33 ctermbg=222
highlight Visual cterm=NONE ctermbg=189 ctermfg=NONE guibg=#DFDFFF guifg=NONE

if has('nvim')
  set termguicolors
  set pumblend=10
  set winblend=10
  hi! Normal ctermbg=NONE guibg=NONE
endif

