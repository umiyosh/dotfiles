return {
  {
    -- カラースキーマ gruvbox-material
    "sainnhe/gruvbox-material",
    lazy = false,
    config = function()
      vim.cmd('colorscheme gruvbox-material')
      vim.opt.background = 'dark'
    end
  }
}
