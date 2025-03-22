return {
  {
    "sebdah/vim-delve",
    ft = "go",
    keys = {
      { "<Leader>9", "<cmd>DlvToggleBreakpoint<CR>", mode = "n", silent = true },
      { "<Leader>8", "<cmd>DlvClearAll<CR>", mode = "n", silent = true },
      { "<Leader>5", "<cmd>DlvDebug<CR>", mode = "n", silent = true },
      { "<Leader>4", "<cmd>DlvTest<CR>", mode = "n", silent = true },
    },
  },
}
