-- ----------------------------------------------------------------------------
-- 'Shougo/neosnippet'
-- ----------------------------------------------------------------------------
--- TODO snippet管理方法全体を見直して、新しいプラグインに移行する方法を検討したい。
-- neosnippetの設定
vim.cmd([[
  " ランタイムスニペットを無効化
  let g:neosnippet#disable_runtime_snippets = {'_' : 1}

  " ユーザー定義スニペット保存ディレクトリ
  let g:neosnippet#snippets_directory = expand('~/.vim/snippets')

  " vim-snippets用: snipMate 互換関数を使えるようにする
  let g:neosnippet#enable_snipmate_compatibility = 1
]])

-- キーマッピング
-- スニペット展開
vim.keymap.set('i', '<C-k>', "<Plug>(neosnippet_expand_or_jump)", {silent = true})
vim.keymap.set('s', '<C-k>', "<Plug>(neosnippet_expand_or_jump)", {silent = true})
vim.keymap.set('x', '<C-k>', "<Plug>(neosnippet_expand_target)", {silent = true})

-- スニペット編集
vim.keymap.set('n', 'sS', ":NeoSnippetEdit<CR>", {silent = true})
