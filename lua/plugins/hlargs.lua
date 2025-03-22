return {
  {
    -- 引数をシンタックスハイライトしてくれるやつ。Tree-sitterを使っている。
    "m-demare/hlargs.nvim",
    cond = not vim.g.vscode,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require('hlargs').setup()
    end,
  },
}
