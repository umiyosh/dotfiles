-- ----------------------------------------------------------------------------
-- 表示 Appearance
-- ----------------------------------------------------------------------------
vim.opt.showmatch = true        -- 括弧の対応をハイライト
-- highlight MatchParen cterm=bold ctermbg=none ctermfg=red guibg=none guifg=red を設定して
vim.cmd('highlight MatchParen ctermbg=LightBlue guibg=LightBlue')
vim.opt.number = true           -- 行番号表示
vim.opt.list = true             -- 不可視文字表示
vim.opt.listchars = {           -- 不可視文字の表示形式
  tab = '>.',
  trail = '_',
  extends = '>',
  precedes = '<',
  eol = '$'
}
vim.opt.display = 'uhex'        -- 印字不可能文字を16進数で表示

-- 全角スペースの表示
local function zenkaku_space()
  vim.api.nvim_set_hl(0, 'ZenkakuSpace', {
    underline = true,
    ctermfg = 'Yellow',
    fg = 'Yellow'
  })
end

if vim.fn.has('syntax') == 1 then
  vim.api.nvim_create_augroup('ZenkakuSpace', { clear = true })
  vim.api.nvim_create_autocmd({'ColorScheme'}, {
    group = 'ZenkakuSpace',
    callback = zenkaku_space
  })
  vim.api.nvim_create_autocmd({'VimEnter', 'WinEnter'}, {
    group = 'ZenkakuSpace',
    callback = function()
      vim.fn.matchadd('ZenkakuSpace', '　')
    end
  })
  zenkaku_space()
end

vim.opt.lazyredraw = true       -- コマンド実行中は再描画しない
vim.opt.ttyfast = true          -- 高速ターミナル接続を行う

-- 折りたたみ関連
vim.opt.foldtext = 'v:lua.vim.fn.FoldCCtext()'
vim.opt.foldmethod = 'marker'
vim.opt.foldcolumn = '3'
vim.opt.foldlevel = 5

-- ハイライト設定
vim.api.nvim_set_hl(0, 'Folded', {
  bold = true,
  ctermbg = 'LightGrey',
  ctermfg = 'DarkBlue',
  bg = 'Grey30',
  fg = 'Grey80'
})

vim.api.nvim_set_hl(0, 'FoldColumn', {
  bold = true,
  ctermbg = 'LightGrey',
  ctermfg = 'DarkBlue',
  bg = 'Grey',
  fg = 'DarkBlue'
})

vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.statuscolumn = "%=%l%s%C"
