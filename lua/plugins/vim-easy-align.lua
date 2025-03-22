return {
  {
    -- 高機能整形・桁揃えプラグイン
    "junegunn/vim-easy-align",
    keys = {
      { '<Enter>', '<Plug>(EasyAlign)', mode = 'v', desc = 'Start interactive EasyAlign in visual mode' },
      { 'ga', '<Plug>(EasyAlign)', mode = 'n', desc = 'Start interactive EasyAlign for a motion/text object' },
    },
  },
}
