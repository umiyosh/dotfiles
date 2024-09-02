-- ----------------------------------------------------------------------------
-- カラー関連設定
-- ----------------------------------------------------------------------------
-- カラースキームの設定
vim.cmd('colorscheme gruvbox-material')
vim.opt.background = 'dark'

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
vim.api.nvim_set_hl(0, "CursorLine", { underline = true, bg = "black" })

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
