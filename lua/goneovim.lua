-- goneovim.lua (Luaに設定をすべて集約するバージョン)

local M = {}

function M.setup()
  if not vim.g.goneovim then
    return
  end

  vim.o.guifont = 'HackGen35 Console NF:h17'

  -- [[ キーマップ設定 ]]
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }
  -- コピー＆ペースト
  map({ 'n', 'v' }, '<D-c>', '"+y', opts)
  map({ 'n', 'v' }, '<D-v>', '"+P', opts)
  map('i', '<D-v>', '<C-R>+', opts)

end

return M


