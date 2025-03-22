return {
  {
    "lambdalisue/fern.vim",
    cond = not vim.g.vscode,
    dependencies = {
      "lambdalisue/fern-git-status.vim",
      "lambdalisue/nerdfont.vim",
      "lambdalisue/fern-renderer-nerdfont.vim",
      "lambdalisue/glyph-palette.vim",
    },
    cmd = "Fern",
    keys = {
      { "<leader>e", "<cmd>Fern . -reveal=% -drawer -toggle -width=40<CR>", mode = "n", silent = true },
    },

    init = function()
      vim.g['fern#renderer'] = 'nerdfont'
      vim.g.fern_disable_startup_warnings = 1
    end,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fern",
        callback = function()
          vim.api.nvim_buf_set_keymap(0, 'n', 's', 's', {})
        end
      })

      vim.api.nvim_create_autocmd({"FileType"}, {
        pattern = {"fern", "nerdtree", "startify"},
        callback = function()
          vim.fn['glyph_palette#apply']()
        end
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("fern-custom", { clear = true }),
        pattern = "fern",
        callback = function()
          -- Buffer-local keymaps
          vim.keymap.set("n", "<C-h>", "<C-w>h", { buffer = true })
          vim.keymap.set("n", "<C-l>", "<C-w>l", { buffer = true })
        end,
      })
      -- vim-fernの設定
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fern",
        callback = function()
          -- <C-S-u>を親ディレクトリに移動するアクションにマッピング
          vim.keymap.set("n", "<C-h>", "<Plug>(fern-action-leave)<CR>", {
            buffer = true,
            silent = true,
            noremap = false
          })
        end,
      })
    end,
  },
}
