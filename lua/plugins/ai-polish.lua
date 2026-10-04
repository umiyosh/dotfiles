return {
  {
    -- Geminiで文章を校正・推敲する。APIキーは $GEMINI_API_KEY から読む
    "umiyosh/ai-polish.nvim",
    tag = "v0.1.0",
    cmd = "AiPolish",
    -- <leader>a* は claudecode が使っているので p(olish) に寄せる
    keys = {
      { "<leader>pp", "<Plug>(ai-polish-selection)", mode = "x", desc = "Proofread selection" },
      { "<leader>pp", "<Plug>(ai-polish-buffer)", mode = "n", desc = "Proofread buffer" },
      { "<leader>pr", "<Plug>(ai-polish-review)", mode = "n", desc = "Review suggestions" },
      { "<leader>pe", "<Plug>(ai-polish-evaluate)", mode = { "n", "x" }, desc = "Evaluate text (Jev)" },
      { "<leader>pt", "<Plug>(ai-polish-evaluation-toggle)", mode = { "n", "x" }, desc = "Toggle evaluation" },
      { "<leader>pd", "<cmd>AiPolish details<CR>", mode = "n", desc = "Evaluation details" },
    },
    opts = {
      locale = "ja", -- "en" | "ja" | "zh"。消すと v:lang から自動で判定する
      -- Jevは任意。$TYPESAFE_API_KEY が未設定なら評価UIを表示しない
    },
  },
}
