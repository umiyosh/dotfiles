scriptencoding utf-8
"/-------------------------------------------------------------------------------
" プラグインごとの設定 Plugins
"-------------------------------------------------------------------------------
 if has('termguicolors')
   set termguicolors
 endif

"------------------------------------
" kana/vim-operator-replace
"------------------------------------
map _ <Plug>(operator-replace)
vnoremap p <Plug>(operator-replace)


"------------------------------------
" junegunn/vim-easy-align
"------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"------------------------------------
" scrooloose/nerdcommenter
"------------------------------------
" コメントの間にスペースを空ける
let g:NERDSpaceDelims = 1
let g:NERDCreateDefaultMappings = 0
"<Leader>xでコメントをトグル(NERD_commenter.vim)
map <Leader>x <Plug>NERDCommenterToggle
""未対応ファイルタイプのエラーメッセージを表示しない
let g:NERDShutUp      = 1
""カスタムdelimiters
let g:NERDCustomDelimiters = {
    \ 'terraform': { 'left': '#', 'leftAlt': 'FOO', 'rightAlt': 'BAR' },
    \ 'plantuml': { 'left': '''', 'leftAlt': 'FOO', 'rightAlt': 'BAR' }
\ }
"------------------------------------
" rizzatti/dash.vim
"------------------------------------
nmap <silent> <leader><leader>d <Plug>DashSearch

"------------------------------------
" tpope/vim-surround
"------------------------------------
nmap s <Plug>Ysurround
nmap ss <Plug>Yssurround
let g:surround_{char2nr('e')} = "begin \r end"
let g:surround_{char2nr('m')} = "~~~ \r ~~~"
let g:surround_{char2nr("-")} = ":\r"
let g:surround_{char2nr('(')} = "(\r)"
let g:surround_{char2nr('{')} = "{\r}"
let g:surround_{char2nr('[')} = "[\r]"

"------------------------------------
" mbbill/undotree
"------------------------------------
nmap U :UndotreeToggle<cr>

"------------------------------------
" liuchengxu/vista.vim
"------------------------------------
map <silent> <leader>tl :Vista coc<CR>
let g:vista#renderer#enable_icon = 1

"------------------------------------
" vim-scripts/camelcasemotion
"------------------------------------
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
" text-objectで使用できるように
omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie

"------------------------------------
" lambdalisue/fern.vim
"------------------------------------
"" https://github.com/lambdalisue/fern.vim/wiki/Tips#how-to-customize-fern-buffer
" disable s <Plug>(fern-action-open:select) keymap because I use s key for hop.vim and easymotion
function! s:init_fern() abort
  nmap <buffer> s s
endfunction
augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

nnoremap <leader>e :Fern . -reveal=% -drawer -toggle -width=40<CR>
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END
let g:fern#renderer = 'nerdfont'
let g:fern_disable_startup_warnings = 1

"------------------------------------
" junegunn/fzf.vim
"------------------------------------
" custom jumplist command
" https://github.com/junegunn/fzf.vim/issues/865#issuecomment-955740371
function GoTo(jumpline)
  let values = split(a:jumpline, ":")
  execute "e ".values[0]
  call cursor(str2nr(values[1]), str2nr(values[2]))
  execute "normal zvzz"
endfunction

function GetLine(bufnr, lnum)
  let lines = getbufline(a:bufnr, a:lnum)
  if len(lines)>0
    return trim(lines[0])
  else
    return ''
  endif
endfunction

function! Jumps()
  " Get jumps with filename added
  let jumps = map(reverse(copy(getjumplist()[0])),
    \ { key, val -> extend(val, {'name': getbufinfo(val.bufnr)[0].name }) })

  let jumptext = map(copy(jumps), { index, val ->
      \ (val.name).':'.(val.lnum).':'.(val.col+1).': '.GetLine(val.bufnr, val.lnum) })

  call fzf#run(fzf#vim#with_preview(fzf#wrap({
        \ 'source': jumptext,
        \ 'column': 1,
        \ 'options': ['--delimiter', ':', '--bind', 'alt-a:select-all,alt-d:deselect-all', '--preview-window', '+{2}-/2'],
        \ 'sink': function('GoTo')})))
endfunction
command! Jumps call Jumps()

" The prefix key.
nnoremap    [fzf]   <Nop>
nmap    ss [fzf]
vmap    ss [fzf]

" ファイル一覧
nnoremap <silent> [fzf]f  :<C-u>Files<CR>
nnoremap <silent> [fzf]F  :<C-u>GitFiles<CR>
" バッファ一覧
nnoremap <silent> [fzf]b  :<C-u>Buffers<CR>
" 常用セット
nnoremap <silent> [fzf]u  :<C-u>History<CR>
" mark一覧
nnoremap <silent> [fzf]m :<C-u>Marks<CR>
" command history一覧
nnoremap <silent> [fzf]h :<C-u>History:<CR>
" search history一覧
nnoremap <silent> [fzf]s :<C-u>History/<CR>
" alll symbols
nnoremap <silent> [fzf]a :<C-u>CocFzfList symbols<CR>
" keymap
nnoremap <silent> [fzf]k :<C-u>Maps<CR>
" neosnippet
nnoremap <silent> [fzf]n :<C-u>Snippets<CR>
" line
nnoremap <silent> [fzf]l :<C-u>BLines<CR>
" line
nnoremap <silent> [fzf]t :<C-u>Filetypes<CR>
" Outline
nnoremap <silent> [fzf]o :<C-u>Vista finder coc<CR>
if has('nvim')
" Diagnostic with coc.nvim
nnoremap <silent> [fzf]d :<C-u>CocDiagnostics<CR>
else
nnoremap <silent> [fzf]d :<C-u>CocList diagnostics<CR>
endif
" jumplist
nnoremap <silent> [fzf]j :Jumps<cr>

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
nnoremap <Leader>gp :<C-u>Git push<CR>
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
lua <<EOF
------------------------------------
-- 'phaazon/hop.nvim'
------------------------------------
require'hop'.setup()
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

if not vim.g.vscode then
  ---------------------------------------
  -- 'lukas-reineke/indent-blankline.nvim
  ---------------------------------------
  local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
  }
  local hooks = require "ibl.hooks"
  -- create the highlight groups in the highlight setup hook, so they are reset
  -- every time the colorscheme changes
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
  end)
  vim.g.indent_blankline_context_patterns = {
      "declaration", "expression", "pattern", "primary_expression",
      "statement", "switch_body"
  }
  vim.g.rainbow_delimiters = { highlight = highlight }
  require("ibl").setup {
    indent = {
       char = "│",
       tab_char = "│",
       smart_indent_cap = true,
       priority = 2,
     },
    scope = {
      highlight = highlight,
      show_start = true,
      show_end = true,
    }
  }
  hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

  ---------------------------------------
  -- 'nvim-treesitter/nvim-treesitter'
  ---------------------------------------
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = {
      enable = true,
      disable = {},
    },
  }
  ---------------------------------------
  -- akinsho/bufferline.nvim
  ---------------------------------------
  require("bufferline").setup{
    options = {
      diagnostics = "coc",
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      themable = true,
      color_icons = true,
      offsets = {
        {
          filetype = "fern",
          text = function()
            return vim.fn.getcwd()
          end,
          highlight = "Directory",
          text_align = "left"
        }
      }

    }
  }

  ---------------------------------------
  -- m-demare/hlargs.nvim
  ---------------------------------------
  require('hlargs').setup()
  ---------------------------------------
  -- 'jackMort/ChatGPT.nvim'
  ---------------------------------------
  require("chatgpt").setup({
     openai_params = {
       model = "gpt-4o",
       frequency_penalty = 0,
       presence_penalty = 0,
       max_tokens = 4095,
       temperature = 0.2,
       top_p = 0.1,
       n = 1,
     },
    actions_paths = {
      vim.fn.expand("$HOME/dotfiles/cgpt_actions.json"),
    },
    })
  ---------------------------------------
  -- lewis6991/gitsigns.nvim
  ---------------------------------------
  require('gitsigns').setup({
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    }
  })
end


---------------------------------------
-- norcalli/nvim-colorizer.lua
---------------------------------------
require'colorizer'.setup()

EOF
" fzf selction like a easymotion
nnoremap <silent> sB :BufferLinePick<CR>
endif

" nnoremap <silent> gR :call
