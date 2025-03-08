return {
  -- Pythonの仮想環境内でインストールされたパッケージをVimから利用できるようにするやつ
  {
    "jmcantrell/vim-virtualenv",
    ft = "python",
  },
  -- pydocstring
  {
    "heavenshell/vim-pydocstring",
    ft = "python",
    config = function()
      vim.keymap.set('n', '<Leader>l', '<Plug>(pydocstring)', { silent = true })
    end,
    init = function()
      vim.g.pydocstring_enable_mapping = 0
      vim.g.pydocstring_doq_path = vim.fn.expand("$VIRTUAL_ENV/bin/doq")
    end,
  },
  -- バッファ上のコードを実行してvimに送信するプラグイン
  {
    "thinca/vim-quickrun",
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
  -- ソースコード上のメソッド宣言、変数宣言の一覧を表示
  {
    "liuchengxu/vista.vim",
    config = function()
      vim.keymap.set('n', '<leader>tl', '<cmd>Vista coc<CR>', { silent = true })
    end,
    init = function()
      vim.g['vista#renderer#enable_icon'] = 1
    end,
  },
  -- golang line debugger
  {
    "sebdah/vim-delve",
    ft = "go",
    config = function()
      vim.keymap.set('n', '<Leader>9', '<cmd>DlvToggleBreakpoint<CR>', { silent = true })
      vim.keymap.set('n', '<Leader>8', '<cmd>DlvClearAll<CR>', { silent = true })
      vim.keymap.set('n', '<Leader>5', '<cmd>DlvDebug<CR>', { silent = true })
      vim.keymap.set('n', '<Leader>4', '<cmd>DlvTest<CR>', { silent = true })
    end,
  },
  -- vimからテストを実行するやつ
  {
    "vim-test/vim-test",
    config = function()
      vim.keymap.set('n', '<Leader>t', '<cmd>TestFile<CR>', { silent = true })
    end,
    init = function()
      vim.g['test#strategy'] = 'dispatch'
    end,
  },
  -- テストを非同期実行するために入れたやつ
  {
    "tpope/vim-dispatch",
  },
  -- terraformのSyntax highlightとかのやつ
  -- TODO: ツリーシッターを使えばいらないんじゃないかって思った。
  {
    "hashivim/vim-terraform",
    ft = "terraform",
    init = function()
      vim.g.terraform_fmt_on_save = 1
    end,
  },
  -- K8sのxplainを使うために、カーソル下のkeyをフルパスで取得するやつ
  -- TODO : インストールはされているが、設定が有効化されていない。
  {
    "cuducos/yaml.nvim",
    ft = "yaml",
  },
}
