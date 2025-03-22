return {
  {
    "akinsho/bufferline.nvim",
    cond = not vim.g.vscode,
    version = "*",
    event = "VimEnter",
    config = function()
      require("bufferline").setup{
        options = {
          diagnostics = "coc",
          diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
          themable = true,
          color_icons = true,
          offsets = {
            {
              filetype = "fern",
              text = function()
                return vim.fn.getcwd()
              end,
              highlight = "Directory",
              text_align = "left"
            }
          }
        }
      }
    end,
  },
}
