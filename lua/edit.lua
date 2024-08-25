-------------------------------------------------------------------------------
-- 編集関連設定
-------------------------------------------------------------------------------

-- IME関連の設定
-- insertモードを抜けるとIMEオフ
vim.opt.iminsert = 0
vim.opt.imsearch = -1  -- iminsertの値を使用
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set iminsert=0"
})

-- Tabキーを空白に変換
vim.opt.expandtab = true

-- コンマの後に自動的にスペースを挿入
vim.api.nvim_set_keymap('i', ',', ',<Space>', {noremap = true})

-- 保存時に行末の空白を除去する
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//ge]]
})

-- quickfixウィンドウではESCで閉じる
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', '<esc>', ':cclose<CR>', {noremap = true, silent = true})
    vim.cmd [[highlight QuickFixLine ctermbg=none]]
  end
})

-- cwでquickfixウィンドウの表示をtoggle
_G.toggle_qf_window = function()
  for i = 1, vim.fn.winnr('$') do
    local win_type = vim.fn.getwinvar(i, '&buftype')
    if win_type == 'quickfix' then
      vim.cmd('ccl')
      return
    end
  end
  vim.cmd('botright cw')
end

vim.api.nvim_set_keymap('n', 'cw', '<cmd>lua toggle_qf_window()<CR>', {noremap = true, silent = true})
