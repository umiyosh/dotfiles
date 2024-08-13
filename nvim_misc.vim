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

"perlの野良ライブラリの読み込み
autocmd FileType perl set isfname-=-
autocmd FileType perl :setlocal path+=lib;/

"perl整形
map ,pt  <ESC>:%!     $HOME/perl5/perlbrew/perls/perl-5.14.2/bin/perltidy<CR>
map ,ptv <ESC>:'<,'>! $HOME/perl5/perlbrew/perls/perl-5.14.2/bin/perltidy<CR>
"perlデバッガ
map <F5> <ESC>:! perl -d %:p<CR>

"Textile2markdown for OSX
"needs pandoc command
command! -nargs=0 Textile2markdown call <SID>Textile2markdown()
noremap <Leader>tm :Textile2markdown<CR>
function! s:Textile2markdown()
  let l:result = system('$HOME/dotfiles/bin/textile2markdown.rb ' . shellescape(expand('%')) . '|pbcopy'  )
endfunction

"Markdown2textile fo OSX
"needs pandoc command
command! -nargs=0 Markdown2textile call <SID>Markdown2textile()
noremap <Leader>mt :Markdown2textile<CR>
function! s:Markdown2textile()
  let l:result = system('pandoc -t textile ' . shellescape(expand('%')) . '|pbcopy'  )
endfunction

" 文字数カウント
vnoremap <leader>ii :call Count_Char()<cr>
function! Count_Char() range
  silent normal gvy
  let l:str = @@
  normal `<
  let l:start_line_num = line('.')
  normal `>
  let l:end_line_num = line('.')
  let l:linenum = l:end_line_num - l:start_line_num + 1

perl << EOF
use strict;
use warnings;
use utf8;
use Encode qw/decode/;

my $str = decode('utf-8', VIM::Eval('str'));
my $line_num = VIM::Eval('linenum');
my $gross_words = length $str;

VIM::Msg("選択範囲の行数は $line_num です");
VIM::Msg("選択範囲の総文字数は $gross_words です");
EOF
endfunction

" 矩形選択の挙動変更(行ビジュアルでもI, Aを使えるようにする)
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

" : / はデフォルトでcommand line windowを開くに変更
" http://d.hatena.ne.jp/vimtaku/20121117/1353138802
nnoremap q: q:a
nnoremap q/ q/a

" QQですぐおわる(保存せず終了。保存して終了はZZ。)
nnoremap QQ :<C-u>Bufonly<CR>:<C-u>q!<CR>
" かな(alt)＋Qで:q!
nnoremap <M-q> :q!<CR>
" nnoremap œ :q!<CR>

" かな(alt)＋Sで上書き保存
nnoremap <M-s> :<C-u>w<CR>
" nnoremap ß :<C-u>w<CR>

"libperl直接指定
let $PERL_DLL = '/System/Library/Perl/5.12/darwin-thread-multi-2level/CORE/libperl.dylib'

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
