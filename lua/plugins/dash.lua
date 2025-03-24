return {
  {
    -- カーソル下のワードをDashで検索する
    "rizzatti/dash.vim",
    keys = {
      { "<leader><leader>d", "<Plug>DashSearch", mode = "n", silent = true },
    },
  },
}
