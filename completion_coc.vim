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
nmap <silent> gp <Plug>(coc-diagnostic-prev)
nmap <silent> gb <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gR <plug>(coc-rename)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <Leader>r :QuickRun<CR>
vmap <leader>d <Plug>(coc-codeaction-selected)
nmap <leader>d <Plug>(coc-codeaction-selected)

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
