return {
  {
    -- operator-replace : yankしたものでreplaceする
    "kana/vim-operator-replace",
    keys = {
      { '_', '<Plug>(operator-replace)', mode = '', desc = 'Replace with operator' },
      { 'p', '<Plug>(operator-replace)', mode = 'v', desc = 'Replace with yanked text' },
    },
  },
}
