scriptencoding utf-8
"-------------------------------------------------------------------------------
" その他 Misc
"-------------------------------------------------------------------------------
"改行を含まず行末までヤンク
nnoremap Y y$

" Open junk file.
command! -nargs=0 JunkFile call s:open_junk_file()
function! s:open_junk_file()
  let l:junk_dir = $HOME . '/.vim_junk'. strftime('/%Y/%m')
  if !isdirectory(l:junk_dir)
    call mkdir(l:junk_dir, 'p')
  endif

  let l:filename = input('Junk Code: ', l:junk_dir.strftime('/%Y-%m-%d-%H%M%S.'))
  if l:filename !=? ''
    execute 'edit ' . l:filename
  endif
endfunction"}}}

"行番号つきののコピー
vnoremap ssc <ESC>:%!cat -n\|perl -pe 's:^ +::g'<CR>gvyugv<ESC>

lua <<EOF
-- Luaでの文字数カウント機能
vim.api.nvim_set_keymap('v', '<leader>ii', ':lua Count_Char()<CR>', { noremap = true, silent = true })

function Count_Char()
    -- 選択範囲を取得
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local start_line_num = start_pos[2]
    local end_line_num = end_pos[2]
    local linenum = end_line_num - start_line_num + 1

    -- 選択範囲のテキストを取得
    local lines = vim.fn.getline(start_line_num, end_line_num)
    local str = table.concat(lines, "\n")

    -- 文字数をカウント
    local gross_words = #str

    -- メッセージを表示
    vim.api.nvim_echo({{"選択範囲の行数は " .. linenum .. " です", "Normal"}}, false, {})
    vim.api.nvim_echo({{"選択範囲の総文字数は " .. gross_words .. " です", "Normal"}}, false, {})
end
EOF

" 行選択や矩形選択でもビジュアルモード中IやAで文字を挿入できるようにする
" http://labs.timedia.co.jp/2012/10/vim-more-useful-blockwise-insertion.html
vnoremap <expr> I  <SID>force_blockwise_visual('I')
vnoremap <expr> A  <SID>force_blockwise_visual('A')

function! s:force_blockwise_visual(next_key)
  if mode() ==# 'v'
    return "\<C-v>" . a:next_key
  elseif mode() ==# 'V'
    return "\<C-v>0o$" . a:next_key
  else  " mode() ==# "\<C-v>"
    return a:next_key
  endif
endfunction

" かな(alt)＋Qで:q!
nnoremap <M-q> :q!<CR>
" nnoremap œ :q!<CR>

" かな(alt)＋Sで上書き保存
nnoremap <M-s> :<C-u>w<CR>
" nnoremap ß :<C-u>w<CR>

" Mac の辞書.appで開く {{{
if has('mac')
    " カーソル下のワードを検索
    command! -nargs=0 MacDictCWord call system('open '.shellescape('dict://'.shellescape(expand('<cword>'))))
    " キーマッピング
    nnoremap <silent><Leader>j :<C-u>MacDictCWord<CR>
endif
"}}}
"

" spell check {{{
set spelllang=en,cjk
set spellfile=~/dotfiles_private/.vim/spell/en.utf-8.add

fun! s:SpellConf()
  redir! => syntax
  silent syntax
  redir END

  set spell

  if syntax =~? '/<comment\>'
    syntax spell default
    syntax match SpellMaybeCode /\<\h\l*[_A-Z]\h\{-}\>/ contains=@NoSpell transparent containedin=Comment contained
  else
    syntax spell toplevel
    syntax match SpellMaybeCode /\<\h\l*[_A-Z]\h\{-}\>/ contains=@NoSpell transparent
  endif

  syntax cluster Spell add=SpellNotAscii,SpellMaybeCode
endfunc

augroup spell_check
  autocmd!
  autocmd BufReadPost,BufNewFile,Syntax * call s:SpellConf()
augroup END
" }}}
"
"
" for vimdiff
"" https://stackoverflow.com/questions/16840433/forcing-vimdiff-to-wrap-lines
"" Forcing vimdiff to wrap lines
au VimEnter * if &diff | execute 'windo set wrap' | endif

" nmap <leader><space> yiW:!xdg-open <c-r>" &<cr>
nmap gx yiW:!open <C-r>" & <CR><CR>

" github project rootでrgを実行する
command! -bang -nargs=* Rg2
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".<q-args>, 1, {'dir': system('git -C '.expand('%:p:h').' rev-parse --show-toplevel 2> /dev/null')[:-2]}, <bang>0)

" 現在開いているファイルPATHをcursorやvscodeで開く。
nnoremap <leader>cu :!cursor %<CR>
nnoremap <leader>co :!code %<CR>
