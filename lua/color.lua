-- ----------------------------------------------------------------------------
-- カラー関連設定
-- ----------------------------------------------------------------------------
-- カレントウィンドウにのみ罫線を引く
-- カーソル行のハイライト
vim.api.nvim_create_augroup('clh', { clear = true })
vim.api.nvim_create_autocmd('WinLeave', {
  group = 'clh',
  callback = function()
    vim.opt.cursorline = false
  end
})
vim.api.nvim_create_autocmd({'WinEnter', 'BufRead'}, {
  group = 'clh',
  callback = function()
    vim.opt.cursorline = true
  end
})

-- カーソル列のハイライト
vim.api.nvim_create_augroup('cch', { clear = true })
vim.api.nvim_create_autocmd('WinLeave', {
  group = 'cch',
  callback = function()
    vim.opt.cursorcolumn = false
  end
})
vim.api.nvim_create_autocmd({'WinEnter', 'BufRead'}, {
  group = 'cch',
  callback = function()
    vim.opt.cursorcolumn = true
  end
})

-- カーソル行のハイライト色の設定
-- 背景色だけにする。下線を付けると CursorLine がほかのハイライトより上に重なり、
-- カーソル行の波線（診断・ai-polish）が普通の下線に上書きされる
vim.api.nvim_set_hl(0, "CursorLine", { bg = "black" })
-- 1段落が1行の文章で段落全体を塗らないよう、折り返した画面上の1行と行番号だけを強調する
vim.opt.cursorlineopt = "screenline,number"

-- ハイライト on
vim.cmd('syntax enable')
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuSel", { reverse = true, fg = "#ab9881", bg = "#000000" })

-- 選択範囲を明るい色で見やすく調整
vim.api.nvim_set_hl(0, "Visual", { bg = "#DFDFFF" })

-- true color
vim.opt.termguicolors = true

vim.opt.pumblend = 10
vim.opt.winblend = 10
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
