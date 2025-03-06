return {
  {
    -- Tree-sitterを使ってシンタックスハイライトを行うやつ
    "nvim-treesitter/nvim-treesitter",
    cond = not vim.g.vscode,
    build = ":TSUpdate",
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = "all",
        highlight = {
          enable = true,
          disable = {},
        },
      }
    end,
  },
  {
    -- 対応する括弧を色違いで表示してくれるやつ
    "hiphish/rainbow-delimiters.nvim",
    cond = not vim.g.vscode,
    config = function()
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = 'rainbow_delimiters#strategy.global',
          vim = 'rainbow_delimiters#strategy.local'
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks'
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan'
        }
      }
    end,
  },
  {
    -- 引数をシンタックスハイライトしてくれるやつ。Tree-sitterを使っている。
    "m-demare/hlargs.nvim",
    cond = not vim.g.vscode,
    config = function()
      require('hlargs').setup()
    end,
  },
  {
    -- 画面に収まりきらない関数定義部分を表示してくれるやつ
    "nvim-treesitter/nvim-treesitter-context",
    cond = not vim.g.vscode,
  },
  -- helmのシンタックスハイライト
  {
    "towolf/vim-helm",
  },
  -- JSONファイルの視認性と編集体験を向上するやつ
  {
    "elzr/vim-json",
    ft = "json",
  },
  -- plantuml シンタックスハイライト
  {
    "aklt/plantuml-syntax",
  },
  -- varnish設定ファイルのシンタックスハイライト
  {
    "smerrill/vcl-vim-plugin",
  },
  -- カーソルの下の単語を自動ハイライトするやつ
  {
    "RRethy/vim-illuminate",
    config = function()
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
    config = function()
      require'colorizer'.setup()
    end,
  },
} 