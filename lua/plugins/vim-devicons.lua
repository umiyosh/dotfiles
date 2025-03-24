return {
  {
    -- nerdfontのグリフを使ってファイルタイプを表示してくれるやつ
    "ryanoasis/vim-devicons",
    cond = not vim.g.vscode,
    lazy = true,  -- 他のプラグインの依存として必要時にロード
  },
}
