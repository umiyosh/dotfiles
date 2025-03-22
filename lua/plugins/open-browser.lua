return {
  {
    -- 編集ファイル内のURLをいい感じにブラウザで開いてくれるやつ
    "tyru/open-browser.vim",
    keys = {
      { "gx", "<Plug>(openbrowser-smart-search)", mode = "n", silent = true },
      { "gx", "<Plug>(openbrowser-smart-search)", mode = "v", silent = true },
    },
    init = function()
      vim.g.netrw_nogx = 1
    end,
  },
}
