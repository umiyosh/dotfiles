-- ----------------------------------------------------------------------------
-- 検索設定
-- ----------------------------------------------------------------------------
vim.opt.wrapscan = true   -- 最後まで検索したら先頭へ戻る
vim.opt.ignorecase = true --  大文字小文字無視
vim.opt.smartcase = true  -- 検索文字列に大文字が含まれている場合は区別して検索する
vim.opt.incsearch = true  -- インクリメンタルサーチ
vim.opt.hlsearch = true   -- 検索文字をハイライト

-- Escの2回押しでハイライト消去
vim.api.nvim_set_keymap('n', '<ESC><ESC>', ':nohlsearch<CR><ESC>', { noremap = true, silent = true })

-- v/s:y選択した文字列を検索
-- v/r:選択した文字列を置換
vim.cmd([[
  vnoremap /s y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
  vnoremap /r "xy:%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>
]])

