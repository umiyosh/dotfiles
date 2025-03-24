return {
  {
    -- 高度なシンタックスハイライトと構文解析を提供するプラグイン
    'nvim-treesitter/nvim-treesitter',
    cond = not vim.g.vscode,
    build = ':TSUpdate',
    event = { "BufReadPost", "BufNewFile" },
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = "all",
      highlight = {
        enable = true,
        disable = {},
      },
    },
  },
}
