-- Vimscriptコマンドを実行するためのヘルパー関数
local function cmd(command)
    vim.cmd(command)
end

vim.opt.termguicolors = true

-- 各設定ファイルの読み込み
local function source(file)
    cmd('source ' .. file)
end

-- 条件付きファイル読み込み
local function source_if_exists(file)
    local expanded_file = vim.fn.expand(file)
    if vim.fn.filereadable(expanded_file) == 1 then
        source(expanded_file)
    end
end

require('basic')
require('indent')
require('search')
require('moving')
require('edit')
require('encoding')
require('hack')

if not vim.g.vscode then
  require('completion')
  require('terminal')
end

source_if_exists('~/nvim_local.vim')
source_if_exists('~/dotfiles_private/nvim_local.vim')
-- プラグイン設定
require("config.lazy")

-- カラースキーム
require('color')

require('apperance')

-- gh openpr: カレント行のblameからPRを開く
local ok, gh_openpr = pcall(require, "gh_openpr")
if ok then
  vim.keymap.set(
    "n",
    "<leader>gp",
    gh_openpr.open_pr_from_current_line,
    { desc = "Open PR for current line via gh openpr", silent = true }
  )
end
