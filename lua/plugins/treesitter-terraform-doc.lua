return {
  {
    "Afourcat/treesitter-terraform-doc.nvim",
    ft = { "terraform", "hcl" }, -- 必要なときだけロード
    config = function()
      require("treesitter-terraform-doc").setup({
        command_name = "OpenDoc",
        -- URLを開くコマンド (Macなら open, Linuxなら xdg-open)
        -- 通常は自動判定されますが、動かない場合は以下のように指定できます
        -- url_opener_command = "open",
      })
    end,
    -- キーマッピング設定
    keys = {
      {
        "K",
        "<cmd>OpenDoc<CR>",
        ft = { "terraform", "hcl" }, -- Terraformファイルでのみ有効
        desc = "Open Terraform Doc in Browser",
      },
    },
  },
}
