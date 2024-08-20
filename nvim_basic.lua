-- 基本設定 Basics

vim.g.mapleader = ','                       -- キーマップリーダー
vim.opt.scrolloff = 5                       -- スクロール時の余白確保
vim.opt.textwidth = 0                       -- 一行に長い文章を書いていても自動折り返しをしない
vim.opt.backup = false                      -- バックアップ取らない
vim.opt.autoread = true                     -- 他で書き換えられたら自動で読み直す
vim.opt.swapfile = false                    -- スワップファイル作らない
vim.opt.writebackup = false                 -- Do not create write backup
vim.opt.hidden = true                       -- 編集中でも他のファイルを開けるようにする
vim.opt.backspace = 'indent,eol,start'      -- バックスペースでなんでも消せるように
vim.opt.formatoptions = 'lmoq'              -- テキスト整形オプション，マルチバイト系を追加
vim.opt.visualbell = true                   -- ビープ音を視覚表示に
vim.opt.errorbells = false                  -- エラーベルを無効化
vim.opt.whichwrap = 'b,s,h,l,<,>,[,]'       -- カーソルを行頭、行末で止まらないようにする
vim.opt.showcmd = true                      -- コマンドをステータス行に表示
vim.opt.showmode = true                     -- 現在のモードを表示
vim.opt.viminfo = "'10000,<1000,s100,\"10000"  -- viminfoファイルの設定
vim.opt.viminfo:append(':10000')            -- command line history size
vim.opt.viminfo:append('/10000')            -- search pattern history size
vim.opt.modelines = 0                       -- モードラインは無効
vim.opt.title = false                       -- 「VIMを使ってくれてありがとう」無し
vim.opt.autoread = true                     -- 外部から変更あった場合は自動読み込みする
vim.opt.wrapscan = false                    -- 検索マッチ終端までいったらそこで止める
vim.opt.undofile = false                    -- undofileは作らない
vim.opt.history = 10000                     -- コマンド・検索パターンの履歴数
vim.opt.updatetime = 500
vim.opt.ttimeoutlen = 50
vim.opt.shortmess = 'a'
vim.opt.cmdheight = 2
vim.opt.mmp = 5000
vim.opt.signcolumn = 'yes:2'

-- autoreadの頻度を上げる
vim.api.nvim_create_augroup('vimrc-checktime', { clear = true })
vim.api.nvim_create_autocmd('WinEnter', {
  group = 'vimrc-checktime',
  callback = function() vim.cmd('checktime') end
})

-- ターミナルでマウスを使用できるようにする
vim.opt.mouse = 'nv'

-- ヤンクした文字は、システムのクリップボードに入れる
vim.opt.clipboard = 'unnamed'

-- 挿入モードでCtrl+kを押すとクリップボードの内容を貼り付けられるようにする
vim.keymap.set('i', '<C-p>', '<ESC>"*pa', { noremap = true })

-- Ev/Rvでvimrcの編集と反映
vim.api.nvim_create_user_command('Ev', 'edit $MYVIMRC', {})
vim.api.nvim_create_user_command('Rv', 'source $MYVIMRC', {})

vim.opt.helpfile = vim.fn.expand('$VIMRUNTIME/doc/help.txt')

-- ファイルタイプ判定をon
vim.cmd('filetype plugin on')

-- crontab編集時はバックアップファイルを作成しない
vim.opt.backupskip:append('/tmp/*,/private/tmp/*')

-- 最後にヤンクしたテキストのペースト
vim.keymap.set('n', '<C-p>', '"0p', { noremap = true })
vim.keymap.set('n', '<C-P>', '"0P', { noremap = true })
