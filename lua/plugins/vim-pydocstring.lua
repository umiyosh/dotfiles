return {
  {
    "heavenshell/vim-pydocstring",
    ft = "python",
    keys = {
      { "<Leader>l", "<Plug>(pydocstring)", mode = "n", silent = true },
    },
    init = function()
      vim.g.pydocstring_enable_mapping = 0
      vim.g.pydocstring_doq_path = vim.fn.expand("$VIRTUAL_ENV/bin/doq")
    end,
  },
}
