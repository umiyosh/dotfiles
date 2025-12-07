return {
  {
    "luukvbaal/statuscol.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local builtin = require("statuscol.builtin")

      require("statuscol").setup({
        bt_ignore = { "terminal", "nofile", "ddu-ff", "ddu-ff-filter" },
        relculright = true,

        segments = {
          -- ① fold 用: レベル数字なし・幅1
          {
            text  = { builtin.foldfunc },
            hl    = "StatusColFold",      -- 後で定義するカスタム HL
            click = "v:lua.ScFa",
          },

          -- ② 診断サイン専用
          {
            sign = {
              namespace = { "diagnostic/signs" }, -- LSP diagnostic
              maxwidth  = 1,
              colwidth  = 1,
              auto      = true,
            },
            click = "v:lua.ScSa",
          },

          -- ③ gitsigns 用サイン
          {
            sign = {
              namespace = { "gitsigns" },
              maxwidth  = 1,
              colwidth  = 1,
              auto      = true,
              wrap      = true,
            },
            click = "v:lua.ScSa",
          },

          -- ④ 行番号
          {
            text = { builtin.lnumfunc, " " },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
          },

          -- ⑤ 区切り線が欲しければ
          -- { text = { "│" } },
        },
      })

      -- fold 周りのオプション（幅1・全部開いた状態でスタート）
      vim.opt.foldcolumn     = "1"
      vim.opt.foldlevel      = 99
      vim.opt.foldlevelstart = 99
      vim.opt.foldenable     = true

      -- fold 用の記号だけを使う（レベル数字は出さない）
      vim.opt.fillchars:append({
        fold      = " ",   -- レベル数字の代わりに空白
        foldopen  = "",
        foldclose = "",
        foldsep   = " ",
      })

      -- グレー背景を消して、行番号っぽい見た目に寄せる
      vim.api.nvim_set_hl(0, "StatusColFold", { link = "LineNr" })
      vim.api.nvim_set_hl(0, "FoldColumn",   { bg = "NONE" })
      vim.api.nvim_set_hl(0, "SignColumn",   { bg = "NONE" })
      vim.api.nvim_set_hl(0, "StatusColumn", { bg = "NONE" })
    end,
  },
}

