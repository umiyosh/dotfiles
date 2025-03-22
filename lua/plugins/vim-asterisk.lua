return {
  {
    -- アスタリスク入力後にカーソルが移動しないのを防ぐ効果がある
    "haya14busa/vim-asterisk",
    keys = {
      { "*", "<Plug>(asterisk-z*)", mode = "", silent = true },
    },
  },
}
