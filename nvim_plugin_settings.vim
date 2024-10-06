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

if !exists('g:vscode')
"------------------------------------
" 'hiphish/rainbow-delimiters.nvim'
"------------------------------------
let g:rainbow_delimiters = {
    \ 'strategy': {
        \ '': rainbow_delimiters#strategy.global,
        \ 'vim': rainbow_delimiters#strategy.local,
    \ },
    \ 'query': {
        \ '': 'rainbow-delimiters',
        \ 'lua': 'rainbow-blocks',
    \ },
    \ 'highlight': [
        \ 'RainbowDelimiterRed',
        \ 'RainbowDelimiterYellow',
        \ 'RainbowDelimiterBlue',
        \ 'RainbowDelimiterOrange',
        \ 'RainbowDelimiterGreen',
        \ 'RainbowDelimiterViolet',
        \ 'RainbowDelimiterCyan',
    \ ],
\ }
end
"------------------------------------
" neovim plugin settings
" 'p00f/nvim-ts-rainbow'
"------------------------------------
if has('nvim')
" fzf selction like a easymotion
nnoremap <silent> sB :BufferLinePick<CR>
endif

" nnoremap <silent> gR :call
