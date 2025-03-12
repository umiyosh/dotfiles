return {
  {
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
  {
    'HiPhish/rainbow-delimiters.nvim',
    cond = not vim.g.vscode,
    lazy = false,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    main = 'rainbow-delimiters.setup',
    opts = {},
  },
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
  {
    -- 画面に収まりきらない関数定義部分を表示してくれるやつ
    "nvim-treesitter/nvim-treesitter-context",
    cond = not vim.g.vscode,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  -- helmのシンタックスハイライト
  {
    "towolf/vim-helm",
    ft = { "helm", "yaml.helm" },
  },
  -- JSONファイルの視認性と編集体験を向上するやつ
  {
    "elzr/vim-json",
    ft = "json",
  },
  -- plantuml シンタックスハイライト
  {
    "aklt/plantuml-syntax",
    ft = "plantuml",
  },
  -- varnish設定ファイルのシンタックスハイライト
  {
    "smerrill/vcl-vim-plugin",
    ft = "vcl",
  },
  -- カーソルの下の単語を自動ハイライトするやつ
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      vim.g.Illuminate_useDeprecated = 1
      local illuminate_augroup = vim.api.nvim_create_augroup("illuminate_augroup", { clear = true })
      if vim.fn.has('nvim') == 1 then
        vim.api.nvim_create_autocmd("VimEnter", {
          group = illuminate_augroup,
          pattern = "*",
          command = "hi illuminatedWord cterm=underline,bold guibg=DarkMagenta",
        })
      else
        vim.api.nvim_create_autocmd("VimEnter", {
          group = illuminate_augroup,
          pattern = "*",
          command = "hi illuminatedWord cterm=underline,bold gui=undercurl,bold ctermbg=19",
        })
      end
    end,
  },
  -- カラーコードを実際の色で表示してくれるやつ
  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require'colorizer'.setup()
    end,
  },
}
