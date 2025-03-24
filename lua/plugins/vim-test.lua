return {
  {
    -- vimからテストを実行するやつ
    "vim-test/vim-test",
    keys = {
      { "<Leader>t", "<cmd>TestFile<CR>", mode = "n", silent = true },
    },
    dependencies = { "tpope/vim-dispatch" },
    init = function()
      vim.g['test#strategy'] = 'dispatch'
    end,
  },
}
