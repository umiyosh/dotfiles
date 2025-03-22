return {
  {
    "kana/vim-textobj-fold",
    dependencies = { "kana/vim-textobj-user" },
    event = { "BufReadPost", "BufNewFile" },
  },
}
