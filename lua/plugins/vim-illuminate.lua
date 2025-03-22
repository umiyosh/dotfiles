return {
  {
    -- カーソルの下の単語を自動ハイライトするやつ
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      vim.g.Illuminate_useDeprecated = 1
      local illuminate_augroup = vim.api.nvim_create_augroup("illuminate_augroup", { clear = true })
      if vim.fn.has('nvim') == 1 then
        vim.api.nvim_create_autocmd("VimEnter", {
          group = illuminate_augroup,
          pattern = "*",
          command = "hi illuminatedWord cterm=underline,bold guibg=DarkMagenta",
        })
      else
        vim.api.nvim_create_autocmd("VimEnter", {
          group = illuminate_augroup,
          pattern = "*",
          command = "hi illuminatedWord cterm=underline,bold gui=undercurl,bold ctermbg=19",
        })
      end
    end,
  },
}
