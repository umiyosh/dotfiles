scriptencoding utf-8
"------------------------------------
" thinca/vim-quickrun
"------------------------------------
if !exists('g:quickrun_config')
    let g:quickrun_config = {}
endif
"runnerをvimprocにする
let g:quickrun_config._ = {'runner' : 'vimproc'}
let g:quickrun_config._ = {'runner/vimproc/updatetime' : 40}
"実行結果は右下に出す
let g:quickrun_config._ = {'split': 'rightbelow 15sp'}

"------------------------------------
" tpope/vim-fugitive
"------------------------------------
nnoremap <Leader>gd :<C-u>Gdiff<CR>
nnoremap <Leader>gs :<C-u>Git<CR>
nnoremap <Leader>gl :<C-u>Git log %<CR>
" nnoremap <Leader>gp :<C-u>Git push<CR>
nnoremap <Leader>ga :<C-u>Gwrite<CR>
nnoremap <Leader>gc :<C-u>Git commit<CR>
nnoremap <Leader>gC :<C-u>Git commit --amend<CR>
nnoremap <Leader>gb :<C-u>Git blame<CR>

" let g:indent_guides_guide_size = &tabstop     " ガイド幅をインデント幅に合わせる

"------------------------------------
" smoka7/hop.nvim
"------------------------------------
map  sb :HopWordBC<CR>
vmap sb <cmd>HopWordBC<CR>
map  sj :HopLineAC<CR>
vmap sj <cmd>HopLineAC<CR>
map  sk :HopLineBC<CR>
vmap sk <cmd>HopLineBC<CR>
map  se :HopWordAC<CR>
vmap se <cmd>HopWordAC<CR>
map  sw :HopWord<CR>
nmap sw :HopWord<CR>
vmap sw <cmd>HopWord<CR>
map  sl :HopLine<CR>
nmap sl :HopLine<CR>
vmap sl <cmd>HopLine<CR>
map  sf :HopChar1<CR>
nmap sf :HopChar1<CR>
vmap st <cmd>HopChar1<CR>
map  s/ :HopPattern<CR>
vmap s/ <cmd>HopPattern<CR>

"------------------------------------
" vim-airline
"------------------------------------
let g:airline_powerline_fonts = 1
let g:airline_theme="dark"
if has('nvim')
  let g:airline#extensions#tabline#enabled = 0
else
  let g:airline#extensions#tabline#enabled = 1
endif
let g:airline_highlighting_cache = 1
"------------------------------------
" VoOM (markdown outliner)
"------------------------------------
let g:voom_tree_width     = 60
let g:voom_tree_placement = 'right'
let g:voom_ft_modes       = {'markdown': 'markdown', 'pandoc': 'markdown'}
let g:voom_user_command = "python3 import voom_addons"
map <Leader>vm <ESC>:<C-u>VoomToggle<CR>

"------------------------------------
" eregex.vim
"------------------------------------
let g:eregex_forward_delim  = 'M/'
let g:eregex_backward_delim = 'M?'

"------------------------------------
" python
"------------------------------------
" pdb起動
command! Pdb :!python -m pdb %
" yapf
let g:yapf_style = 'pep8'
nnoremap <leader>Y :call Yapf()<cr>
" isort
autocmd FileType python nnoremap <leader>i :!isort %<CR><CR>

"------------------------------------
" pydocstring
"------------------------------------
let g:pydocstring_enable_mapping = 0
nmap <silent><Leader>l  <Plug>(pydocstring)

"------------------------------------
" vim-goimports
"------------------------------------
let g:goimports_simplify = 1
let g:goimports_show_loclist = 0
let g:goimports_simplify_cmd = 'gofumpt'

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

"------------------------------------
" 'vim-test/vim-test'
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
