-- ----------------------------------------------------------------------------
-- 補完・履歴 Complete
-- ----------------------------------------------------------------------------
vim.opt.wildmenu = true              -- コマンド補完を強化
vim.opt.wildchar = string.byte('\t') -- コマンド補完を開始するキー
vim.opt.wildmode = "list:full"       -- リスト表示，最長マッチ
vim.opt.complete:append('k')         -- 補完に辞書ファイル追加

-- Ex-modeでの<C-p><C-n>をzshのヒストリ補完っぽくする
vim.keymap.set('c', '<C-p>', '<Up>', { noremap = true })
vim.keymap.set('c', '<Up>', '<C-p>', { noremap = true })
vim.keymap.set('c', '<C-n>', '<Down>', { noremap = true })
vim.keymap.set('c', '<Down>', '<C-n>', { noremap = true })
