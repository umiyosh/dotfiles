scriptencoding utf-8
"------------------------------------
" buoto/gotests-vim
"------------------------------------
nmap <silent> <Leader>ct :GoTests<CR>
nmap <silent> <Leader>cT :GoTestsAll<CR>

highlight goImportedPkg ctermfg=1 guifg=#ff0000

"------------------------------------
" copilot.vim enable to write markdown and gitcommit
"------------------------------------
let g:copilot_filetypes = {
\ 'markdown': v:true,
\ 'yaml': v:true,
\ 'gitcommit': v:true,
\ }
