-- インデント設定
vim.opt.autoindent = true  -- 自動でインデント
vim.opt.smartindent = true -- 新しい行のインデントを現在行と同じ量にする
vim.opt.cindent = true     -- Cプログラムファイルの自動インデントを始める

-- タブとインデントの設定
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 0


vim.cmd('filetype indent on')

-- ファイルタイプごとのインデント設定
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "apache", "aspvbs", "c", "cpp", "cs", "css", "diff", "eruby", "html",
    "java", "javascript", "perl", "php", "ruby", "haml", "sh", "sql", "vb",
    "vim", "wsh", "xhtml", "xml", "yaml", "zsh", "scala"
  },
  command = "setlocal sw=2 sts=2 ts=2 et"
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  command = "setlocal sw=4 sts=4 ts=4 et"
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"go", "neosnippet"},
  command = "setlocal noexpandtab list tabstop=2 shiftwidth=2"
})
