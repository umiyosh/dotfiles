return {
  {
    -- 編集した行のgit差分を左側に表示してくれるやつ
    "lewis6991/gitsigns.nvim",
    cond = not vim.g.vscode,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('gitsigns').setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        }
      })
    end,
  },
}
