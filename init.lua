-- Vimscriptコマンドを実行するためのヘルパー関数
local function cmd(command)
    vim.cmd(command)
end

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
source('~/dotfiles/nvim_vimplug.vim')
source('~/dotfiles/nvim_plugin_settings.vim')

if not vim.g.vscode then
  require('neosnippet')
  source('~/dotfiles/completion_coc.vim')
end

-- カラースキーム
require('color')

require('apperance')

