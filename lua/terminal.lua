-- ----------------------------------------------------------------------------
-- keymap
-- ----------------------------------------------------------------------------
vim.keymap.set('n', 'sh', '<cmd>belowright 10split<CR><cmd>terminal<CR>', {silent = true})

-- ターミナルを開いたらに常にinsertモードに入る
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.cmd("startinsert")
  end
})

-- ターミナルモードで行番号を非表示
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.wo.relativenumber = false
    vim.wo.number = false
  end
})
