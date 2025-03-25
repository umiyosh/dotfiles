return {
  {
    -- ソースコード上のメソッド宣言、変数宣言の一覧を表示
    "liuchengxu/vista.vim",
    event = "VeryLazy",
    init = function()
      vim.g['vista#renderer#enable_icon'] = 1
    end,
    config = function()
      vim.keymap.set('n', '<leader>tl', '<cmd>Vista coc<CR>', { silent = true })
    end,
  },
}
