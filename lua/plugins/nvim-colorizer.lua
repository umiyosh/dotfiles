return {
  {
    -- カラーコードを実際の色で表示してくれるやつ
    "norcalli/nvim-colorizer.lua",
    config = function()
      require'colorizer'.setup()
    end,
  },
}
