return {
  {
    "thinca/vim-quickrun",
    event = { "BufReadPost", "BufNewFile" },  -- ファイルを開いた時に読み込み
    config = function()
      -- g:quickrun_config が存在しない場合は初期化
      if vim.g.quickrun_config == nil then
        vim.g.quickrun_config = {}
      end

      -- runnerをvimprocに設定
      vim.g.quickrun_config['_'] = {
        runner = 'vimproc',
        ['runner/vimproc/updatetime'] = 40,
        split = 'rightbelow 15sp'
      }
    end,
  },
}
