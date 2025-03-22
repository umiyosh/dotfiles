return {
  {
    "vim-voom/VOoM",
    cmd = "VoomToggle",
    keys = {
      { "<Leader>vm", "<CMD>VoomToggle<CR>", mode = "n", silent = true, noremap = true },
    },
    init = function()
      vim.g.voom_tree_width = 60
      vim.g['voom_tree_placement'] = 'right'
      vim.g['voom_ft_modes'] = {markdown = 'markdown', pandoc = 'markdown'}
      vim.g['voom_user_command'] = "python3 import voom_addons"
    end,
  },
}
