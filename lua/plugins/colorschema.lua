return {
  -- color schema gruvbox
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    config = function()
      vim.cmd('colorscheme gruvbox-material')
      vim.opt.background = 'dark'
    end
  }
}
