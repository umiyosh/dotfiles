return {
  {
    -- Geminiで文章を校正・推敲する。APIキーは $GEMINI_API_KEY から読む
    "umiyosh/ai-polish.nvim",
    cmd = "AiPolish",
    -- <leader>a* は claudecode が使っているので p(olish) に寄せる
    keys = {
      { "<leader>pp", "<Plug>(ai-polish-selection)", mode = "x", desc = "Proofread selection" },
      { "<leader>pp", "<Plug>(ai-polish-buffer)", mode = "n", desc = "Proofread buffer" },
      { "<leader>pr", "<Plug>(ai-polish-review)", mode = "n", desc = "Review suggestions" },
    },
    opts = {},
  },
}
