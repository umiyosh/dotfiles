return {
{
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  keys = {
    -- === メイングループ ===
    { "<leader>a", nil, desc = "AI/Claude Code" },

    -- === 基本操作 ===
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },         -- Claudeウィンドウの開閉
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },     -- Claudeウィンドウにフォーカス

    -- === セッション管理 ===
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },   -- 前回のセッションを再開
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" }, -- 応答の続きを生成

    -- === コンテキスト追加 ===
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },      -- 現在のバッファを追加
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" }, -- 選択テキストを送信（ビジュアルモード）
    { "<leader>aB", "<cmd>ClaudeCodeAdd %<cr><cmd>ClaudeCodeFocus<cr>", desc = "Add buffer & focus" }, -- バッファ追加後にフォーカス
    { "<leader>aS", "<cmd>ClaudeCodeAdd %<cr><cmd>ClaudeCodeFocus<cr>", desc = "Add buffer & focus" }, -- バッファ追加後にフォーカス
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil" },  -- ファイルツリー内でのみ有効
    },

    -- === 差分管理 ===
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },  -- 提案された変更を承認
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },      -- 提案された変更を拒否
  },
}
}
