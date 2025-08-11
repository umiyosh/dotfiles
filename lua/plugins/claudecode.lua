local function claude_toggle(args)
  local term = require('claudecode.terminal')
  term.simple_toggle({}, args)
end

local function claude_focus(args)
  local term = require('claudecode.terminal')
  term.focus_toggle({}, args)
end

local function add_current_buffer()
  local path = vim.fn.expand('%:p')
  require('claudecode').send_at_mention(path, nil, nil, 'Keymap:ClaudeCodeAdd')
end

local function send_visual_selection()
  local selection = require('claudecode.selection')
  selection.send_at_mention_for_visual_selection()
  pcall(function()
    local esc = vim.api.nvim_replace_termcodes('<Esc>', true, false, true)
    vim.api.nvim_feedkeys(esc, 'n', false)
  end)
end

local function tree_add_selected()
  local integrations = require('claudecode.integrations')
  local files = integrations.get_selected_files_from_tree()
  if not files or #files == 0 then
    return
  end
  for _, path in ipairs(files) do
    require('claudecode').send_at_mention(path, nil, nil, 'Keymap:ClaudeCodeTreeAdd')
  end
end

local function diff_accept()
  require('claudecode.diff').accept_current_diff()
end

local function diff_deny()
  require('claudecode.diff').deny_current_diff()
end

return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      -- === メイングループ ===
      { "<leader>a", nil, desc = "AI/Claude Code" },

      -- === 基本操作 ===
      { "<leader>ac", function() claude_toggle() end, desc = "Toggle Claude" },         -- Claudeウィンドウの開閉
      { "<leader>af", function() claude_focus() end, desc = "Focus Claude" },           -- Claudeウィンドウにフォーカス

      -- === セッション管理 ===
      { "<leader>ar", function() claude_toggle("--resume") end, desc = "Resume Claude" },     -- 前回のセッションを再開
      { "<leader>aC", function() claude_toggle("--continue") end, desc = "Continue Claude" }, -- 応答の続きを生成

      -- === コンテキスト追加 ===
      { "<leader>ab", add_current_buffer, desc = "Add current buffer" },
      { "<leader>as", send_visual_selection, mode = "v", desc = "Send to Claude" }, -- 選択テキストを送信（ビジュアルモード）
      {
        "<leader>as",
        tree_add_selected,
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil" },  -- ファイルツリー内でのみ有効
      },

      -- === 差分管理 ===
      { "<leader>aa", diff_accept, desc = "Accept diff" },  -- 提案された変更を承認
      { "<leader>ad", diff_deny, desc = "Deny diff" },      -- 提案された変更を拒否
    },
  },
}
