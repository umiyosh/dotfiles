return {
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
}
