return {
  {
    'HiPhish/rainbow-delimiters.nvim',
    cond = not vim.g.vscode,
    lazy = false,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    main = 'rainbow-delimiters.setup',
    opts = {},
  },
}
