return {
  {
    "vim-airline/vim-airline",
    cond = not vim.g.vscode,
    event = {
        "InsertEnter",
        "CmdlineEnter",  -- コマンドライン補完のため
        "BufReadPre",    -- エラー検出のため
    },
    init = function()
      vim.g['airline_powerline_fonts'] = 1
      vim.g['airline_theme'] = 'dark'
      vim.g['airline#extensions#tabline#enabled'] = 1
      vim.g['airline_highlighting_cache'] = 1
    end,
  },
}
