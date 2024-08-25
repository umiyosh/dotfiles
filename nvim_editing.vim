scriptencoding utf-8
"-------------------------------------------------------------------------------
" 編集関連 Edit
"-------------------------------------------------------------------------------

" insertモードを抜けるとIMEオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" Tabキーを空白に変換
set expandtab

" コンマの後に自動的にスペースを挿入
inoremap , ,<Space>

" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge

" quickfixウィンドウではESCで閉じる
autocmd FileType qf nnoremap <buffer><silent> <esc> :lclose<CR>
autocmd FileType qf highlight QuickFixLine ctermbg=none
" cwでquickfixウィンドウの表示をtoggleするようにした
function! s:toggle_qf_window()
  for l:bufnr in range(1,  winnr('$'))
    if getwinvar(bufnr,  '&buftype') ==# 'quickfix'
      execute 'ccl'
      return
    endif
  endfor
  execute 'botright cw'
endfunction
nnoremap <silent> cw :call <SID>toggle_qf_window()<CR>

