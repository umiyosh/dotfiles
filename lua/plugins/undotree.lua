return {
  {
    -- undo履歴を追える (need python support)
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { '<Leader>u', '<cmd>UndotreeToggle<CR>', mode = '' }
    },
  },
}
