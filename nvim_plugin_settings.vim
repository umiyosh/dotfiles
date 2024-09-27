scriptencoding utf-8
"------------------------------------
" vim-delve.vim
"------------------------------------
nmap <silent> <Leader>9 :DlvToggleBreakpoint<CR>
nmap <silent> <Leader>8 :DlvClearAll<CR>
nmap <silent> <Leader>5 :DlvDebug<CR>
nmap <silent> <Leader>4 :DlvTest<CR>

"------------------------------------
" hashivim/vim-terraform
"------------------------------------
let g:terraform_fmt_on_save = 1

"------------------------------------ " 'vim-test/vim-test'
"------------------------------------
let g:test#strategy = 'dispatch'
nmap <silent> <Leader>t :TestFile<CR>

"------------------------------------
" buoto/gotests-vim
"------------------------------------
nmap <silent> <Leader>ct :GoTests<CR>
nmap <silent> <Leader>cT :GoTestsAll<CR>

highlight goImportedPkg ctermfg=1 guifg=#ff0000
" ------------------------------------
" RRethy/vim-illuminate
" ------------------------------------
let g:Illuminate_useDeprecated = 1
if has('nvim')
augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedWord cterm=underline,bold guibg=DarkMagenta
augroup END
else
augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedWord cterm=underline,bold gui=undercurl,bold ctermbg=19
augroup END
endif

"------------------------------------
" haya14busa/vim-asterisk
"------------------------------------
map *  <Plug>(asterisk-z*)

"------------------------------------
" tyru/open-browser.vim
"------------------------------------
" My setting.
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

"------------------------------------
" madox2/vim-ai
"------------------------------------
" let g:vim_ai_chat['options']['model'] = 'gpt-4'
let g:vim_ai_chat = {
\  "options": {
\    "model": "gpt-4-0125-preview",
\    "temperature": 0.2,
\    "initial_prompt": "日本語で回答すること",
\  },
\}

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
