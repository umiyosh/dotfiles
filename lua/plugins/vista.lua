return {
  {
    -- ソースコード上のメソッド宣言、変数宣言の一覧を表示
    "liuchengxu/vista.vim",
    keys = {
      { "<leader>tl", "<cmd>Vista coc<CR>", mode = "n", silent = true },
    },
    init = function()
      vim.g['vista#renderer#enable_icon'] = 1
    end,
  },
}
