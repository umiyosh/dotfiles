scriptencoding utf-8
"-------------------------------------------------------------------------------
" 移動設定 Move
"-------------------------------------------------------------------------------

" insert mode での移動
inoremap  <C-e> <END>
inoremap  <C-a> <HOME>
noremap  <C-e> $
noremap  <C-a> ^

" カーソル位置の単語をyankする
nnoremap vy vawy

" 矩形選択で自由に移動する
set virtualedit+=block

"ビジュアルモード時vで行末まで選択
vnoremap v $h

" CTRL-hjklでウィンドウ移動
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>hk

" バッファ操作関連
nnoremap <Leader>kk      :bd<CR>
nnoremap <Leader>kK      :bd!<CR>
nnoremap <Leader>fk      :Kwbd<CR>
nnoremap <Leader>bo      :Bufonly<CR>
nnoremap <Leader>wk      :w<CR> :bd<CR>
nnoremap <Leader>wK      :w<CR> :bd!<CR>
nnoremap <Leader>cc      :new<CR>

" バッファ読み込み時にマークを初期化
autocmd BufReadPost * delmarks!

nnoremap <silent>bp :bprevious<CR>
nnoremap <silent>bn :bnext<CR>
nnoremap <Leader>bb :b#<CR>

" %で移動するペアの追加"<":">"
set matchpairs=(:),{:},[:],<:>

" marks
" http://saihoooooooo.hatenablog.com/entry/2013/04/30/001908
" 基本マップ
nnoremap [Mark] <Nop>
nmap m [Mark]

" 現在位置をマーク
if !exists('g:markrement_char')
    let g:markrement_char = [
    \     'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    \     'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    \ ]
endif
nnoremap <silent>[Mark]m :<C-u>call <SID>AutoMarkrement()<CR>
function! s:AutoMarkrement()
    if !exists('b:markrement_pos')
        let b:markrement_pos = 0
    else
        let b:markrement_pos = (b:markrement_pos + 1) % len(g:markrement_char)
    endif
    execute 'mark' g:markrement_char[b:markrement_pos]
    echo 'marked' g:markrement_char[b:markrement_pos]
endfunction

" 次/前のマーク
nnoremap [Mark]n ]`
nnoremap [Mark]p [`

" 一覧表示
nnoremap [Mark]l :<C-u>marks<CR

" 前回開いてた場所に移動
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
