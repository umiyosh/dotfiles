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
source('~/dotfiles/nvim_indent.vim')
source('~/dotfiles/nvim_tags.vim')
source('~/dotfiles/nvim_search.vim')
source('~/dotfiles/nvim_moving.vim')
source('~/dotfiles/nvim_editing.vim')
source('~/dotfiles/nvim_encoding.vim')
source('~/dotfiles/nvim_misc.vim')
source('~/dotfiles/nvim_completion.vim')
source('~/dotfiles/nvim_terminal.vim')
source('~/dotfiles/nvim_apperance.vim')

source_if_exists('~/nvim_local.vim')
source_if_exists('~/dotfiles_private/nvim_local.vim')

-- プラグイン設定
source('~/dotfiles/nvim_plugsetup.vim')

-- カラースキーム
source('~/dotfiles/nvim_colors.vim')
