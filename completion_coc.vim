" coc.vim settings

" coc.nvim config directory
let g:coc_config_home = '~/dotfiles_private/'

" coc status lineの設定
set statusline^=%{coc#status()}
" coc 色の設定
autocmd ColorScheme * hi CocErrorHighlight ctermfg=Red  guifg=Red
autocmd ColorScheme * hi CocWarningHighlight ctermfg=Yellow  guifg=Yellow
autocmd ColorScheme * hi CocInfoSign ctermfg=Green  guifg=Green

" 純粋なテキストファイルの場合には、CoCの間交互表示を無効化する。
autocmd FileType text let b:coc_suggest_disable = 1

" 保管候補選択時の挙動のキーマップ設定
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm()
				\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-n> coc#pum#visible() ? coc#pum#next(1) : "\<C-n>"
inoremap <silent><expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<C-p>"
inoremap <silent><expr> <down> coc#pum#visible() ? coc#pum#next(0) : "\<down>"
inoremap <silent><expr> <up> coc#pum#visible() ? coc#pum#prev(0) : "\<up>"

" coc キーマップ設定
nmap <silent> gp <Plug>(coc-diagnostic-prev)    " 前の診断に移動
nmap <silent> gb <Plug>(coc-diagnostic-next)    " 次の診断に移動
nmap <silent> gd <Plug>(coc-definition)         " 定義に移動
nmap <silent> gy <Plug>(coc-type-definition)    " 型定義に移動
nmap <silent> gi <Plug>(coc-implementation)     " 実装に移動
nmap <silent> gR <plug>(coc-rename)             " リネーム
nmap <silent> gr <Plug>(coc-references)         " 参照に移動
nmap <silent> <Leader>r :QuickRun<CR>           " QuickRunを実行
vmap <leader>d <Plug>(coc-codeaction-selected)  " コードアクションを実行( visual mode )
nmap <leader>d <Plug>(coc-codeaction-selected)  " コードアクションを実行( normal mode )

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" 保存時にisortする
autocmd BufWritePre *.py :CocCommand python.sortImports

" coc extentions
let g:coc_global_extensions = [
    \'coc-spell-checker',
    \'coc-actions',
    \'coc-dictionary',
    \'coc-word',
    \'coc-vimlsp',
    \'coc-neosnippet',
    \'coc-yaml',
    \'coc-sh',
    \'coc-pyright',
    \'coc-perl',
    \'coc-json',
    \'coc-prettier',
    \'coc-tsserver',
    \'coc-go'
\]
