return {
  {
    -- vimからGit操作する
    "tpope/vim-fugitive",
    cmd = { "Git", "Gdiff", "Gwrite", "Gcommit", "Gblame" },
    keys = {
      { "<Leader>gd", "<cmd>Gdiff<CR>", mode = "n" },
      { "<Leader>gs", "<cmd>Git<CR>", mode = "n" },
      { "<Leader>gl", "<cmd>Git log %<CR>", mode = "n" },
      { "<Leader>ga", "<cmd>Gwrite<CR>", mode = "n" },
      { "<Leader>gc", "<cmd>Git commit<CR>", mode = "n" },
      { "<Leader>gC", "<cmd>Git commit --amend<CR>", mode = "n" },
      { "<Leader>gb", "<cmd>Git blame<CR>", mode = "n" },
    },
  },
}
