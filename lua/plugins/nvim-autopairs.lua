return {
  {
    -- 括弧・クォートの自動補完
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      -- <CR> は coc.nvim の補完確定に使っているため奪わない
      map_cr = false,
    },
  },
}
