return {
  {
    -- 括弧を色分けして見やすくするやつ
    'HiPhish/rainbow-delimiters.nvim',
    cond = not vim.g.vscode,
    lazy = false,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    main = 'rainbow-delimiters.setup',
    opts = {},
  },
}
