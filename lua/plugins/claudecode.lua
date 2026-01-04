return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      -- info, debug など
      log_level = "info",
      -- Claude CLI起動に時間がかかるため、キュータイムアウトを延長
      -- デフォルト5秒では"Skipped expired @ mention"になる
      queue_timeout = 30000, -- 30秒
      -- ターミナル設定
      terminal = {
        snacks_win_opts = {
          -- Claude Codeターミナル専用のキーマップ
          -- 通常のターミナルには影響しない
          -- 注意: snacks.nvimは文字列rhsを"action"として解釈するため、関数で渡す
          keys = {
            nav_left = {
              "<C-h>",
              function()
                vim.cmd("stopinsert")
                vim.cmd("wincmd h")
              end,
              mode = "t",
              desc = "Move to left window",
            },
            nav_down = {
              "<C-j>",
              function()
                vim.cmd("stopinsert")
                vim.cmd("wincmd j")
              end,
              mode = "t",
              desc = "Move to window below",
            },
            nav_up = {
              "<C-k>",
              function()
                vim.cmd("stopinsert")
                vim.cmd("wincmd k")
              end,
              mode = "t",
              desc = "Move to window above",
            },
            nav_right = {
              "<C-l>",
              function()
                vim.cmd("stopinsert")
                vim.cmd("wincmd l")
              end,
              mode = "t",
              desc = "Move to right window",
            },
          },
        },
      },
    },
    keys = {
      -- === メイングループ ===
      { "<leader>a", nil, desc = "AI/Claude Code" },

      -- === 基本操作 ===
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },

      -- === セッション管理 ===
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },

      -- === コンテキスト追加 ===
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      -- ビジュアルモードでClaudeに選択範囲を送信
      {
        "<leader>as",
        ":'<,'>ClaudeCodeSend<CR>",
        mode = "v",
        desc = "Send to Claude",
      },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },

      -- === 差分管理 ===
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },

      -- === モデル選択 ===
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    },
  },
}
