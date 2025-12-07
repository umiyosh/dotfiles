return {
  "mvllow/modes.nvim",
  config = function()
    require("modes").setup({
      -- ここは好きな設定で
      line_opacity = 0.15,
      set_cursor = true,
      set_cursorline = true,
      colors = {
        visual = "#ead3f0",
      },
    })

    -- modes.nvim が作った gutter 用ハイライトを自前で戻す
    local function fix_modes_gutter()
      for _, mode in ipairs({ "Copy", "Delete", "Insert", "Visual" }) do
        -- 行番号は通常の CursorLineNr に合わせる
        vim.api.nvim_set_hl(0, "Modes"..mode.."CursorLineNr", {
          link = "CursorLineNr",
        })
        -- sign / fold カラムは SignColumn / FoldColumn に合わせる
        vim.api.nvim_set_hl(0, "Modes"..mode.."CursorLineSign", {
          link = "SignColumn",
        })
        vim.api.nvim_set_hl(0, "Modes"..mode.."CursorLineFold", {
          link = "FoldColumn",
        })
      end
    end

    fix_modes_gutter()

    -- colorscheme 変更時に modes.lua が再定義するので、その後でもう一回潰す
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = fix_modes_gutter,
    })
  end,
}
