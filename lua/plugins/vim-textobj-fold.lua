return {
  {
    -- vim-textobj-fold : 折りたたまれたアレをtext-objectに
    "kana/vim-textobj-fold",
    dependencies = { "kana/vim-textobj-user" },
    event = { "BufReadPost", "BufNewFile" },
  },
}
