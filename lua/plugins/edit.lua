return {
  {
    -- コメントアウトを簡単にするやつ
    "scrooloose/nerdcommenter",
    keys = {
      { '<Leader>x', '<Plug>NERDCommenterToggle', mode = '', silent = true },
    },
    init = function()
      vim.g.NERDSpaceDelims = 1
      vim.g.NERDCreateDefaultMappings = 0
      vim.g.NERDShutUp = 1
      vim.g.NERDCustomDelimiters = {
        terraform = { left = '#', leftAlt = 'FOO', rightAlt = 'BAR' },
        plantuml  = { left = "'''", leftAlt = 'FOO', rightAlt = 'BAR' }
      }
    end
  },
  {
    -- インデントガイド
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
    cond = not vim.g.vscode,
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<leader>ti", "<cmd>IBLToggle<cr>", desc = "Toggle indent line" },
    },
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
        smart_indent_cap = true,
        priority = 2,
      },
      scope = {
        show_start = true,
        show_end = true,
      }
    },
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }
      local hooks = require "ibl.hooks"
      -- ハイライトグループを作成（カラースキーム変更時にリセットされるように）
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      vim.g.indent_blankline_context_patterns = {
        "declaration", "expression", "pattern", "primary_expression",
        "statement", "switch_body"
      }

      vim.g.rainbow_delimiters = { highlight = highlight }

      require("ibl").setup {
        indent = {
          char = "│",
          tab_char = "│",
          smart_indent_cap = true,
          priority = 2,
        },
        scope = {
          highlight = highlight,
          show_start = true,
          show_end = true,
        }
      }

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

      vim.opt.list = true
      vim.opt.listchars:append("space:⋅")
      vim.opt.listchars:append("eol:↴")
    end
  },
  -- undo履歴を追える (need python support)
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { '<Leader>u', '<cmd>UndotreeToggle<CR>', mode = '' }
    },
  },
  -- 高機能整形・桁揃えプラグイン
  {
    "junegunn/vim-easy-align",
    keys = {
      { '<Enter>', '<Plug>(EasyAlign)', mode = 'v', desc = 'Start interactive EasyAlign in visual mode' },
      { 'ga', '<Plug>(EasyAlign)', mode = 'n', desc = 'Start interactive EasyAlign for a motion/text object' },
    },
  },
  -- 選択範囲を指定文字で囲む
  {
    "tpope/vim-surround",
  },
  -- 簡単にoperatorを定義できるようにする
  {
    "kana/vim-operator-user",
  },
  -- operator-replace : yankしたものでreplaceする
  {
    "kana/vim-operator-replace",
    keys = {
      { '_', '<Plug>(operator-replace)', mode = '', desc = 'Replace with operator' },
      { 'p', '<Plug>(operator-replace)', mode = 'v', desc = 'Replace with yanked text' },
    },
  },
  -- textobj-user : 簡単にVimエディタのテキストオブジェクトをつくれる
  {
    "kana/vim-textobj-user",
  },
  -- vim-textobj-fold : 折りたたまれたアレをtext-objectに
  {
    "kana/vim-textobj-fold",
    dependencies = { "kana/vim-textobj-user" },
    event = { "BufReadPost", "BufNewFile" },
  },
  -- vim-textobj-indent : インデントされたものをtext-objectに
  {
    "kana/vim-textobj-indent",
    dependencies = { "kana/vim-textobj-user" },
    event = { "BufReadPost", "BufNewFile" },
  },
  -- editorconfig
  {
    "editorconfig/editorconfig-vim",
    event = { "BufReadPre", "BufNewFile" },
  },
}

