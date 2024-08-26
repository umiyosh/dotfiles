-- ----------------------------------------------------------------------------
-- エンコーディング関連 Encoding
-- ----------------------------------------------------------------------------
vim.o.fileformats = "unix,dos,mac"  -- 改行文字
vim.o.fileencodings = "utf-8,iso-2022-jp,euc-jp,sjis"
vim.o.encoding = "utf-8"  -- デフォルトエンコーディング

-- ワイルドカードで表示するときに優先度を低くする拡張子
vim.o.suffixes = ".bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc"

-- 指定文字コードで強制的にファイルを開く
vim.api.nvim_create_user_command('Cp932', 'edit ++enc=cp932', {})
vim.api.nvim_create_user_command('Eucjp', 'edit ++enc=euc-jp', {})
vim.api.nvim_create_user_command('Iso2022jp', 'edit ++enc=iso-2022-jp', {})
vim.api.nvim_create_user_command('Utf8', 'edit ++enc=utf-8', {})
vim.api.nvim_create_user_command('Jis', 'Iso2022jp', {})
vim.api.nvim_create_user_command('Sjis', 'Cp932', {})
