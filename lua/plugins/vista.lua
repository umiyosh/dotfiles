return {
  {
    "liuchengxu/vista.vim",
    keys = {
      { "<leader>tl", "<cmd>Vista coc<CR>", mode = "n", silent = true },
    },
    init = function()
      vim.g['vista#renderer#enable_icon'] = 1
    end,
  },
}
