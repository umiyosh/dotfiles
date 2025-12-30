return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      -- デバッグ用（問題解決後はinfoに戻す）
      log_level = "debug",
      -- Claude CLI起動に時間がかかるため、キュータイムアウトを延長
      -- デフォルト5秒では"Skipped expired @ mention"になる
      queue_timeout = 30000, -- 30秒
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
