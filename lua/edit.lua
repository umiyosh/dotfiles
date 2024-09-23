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
vim.keymap.set('i', ',', ',<Space>')

-- 保存時に行末の空白を除去する
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//ge]]
})

-- quickfixウィンドウではESCで閉じる
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', '<ESC><ESC>', '<cmd>cclose<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_hl(0, 'QuickFixLine', { ctermbg = 'none' })
  end
})

-- cwでquickfixウィンドウの表示をtoggle
function Toggle_qf_window()
  local windows = vim.api.nvim_list_wins()
  for _, win in ipairs(windows) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_get_option(buf, 'buftype') == 'quickfix' then
      vim.cmd('cclose')
      return
    end
  end
  vim.cmd('botright copen')
end
vim.keymap.set('n', 'cw', '<cmd>lua Toggle_qf_window()<CR>', { silent = true })
