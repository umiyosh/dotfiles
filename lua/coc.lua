-- coc.nvim settings

-- coc.nvim config directory
vim.g.coc_config_home = '~/dotfiles/'

-- coc status lineの設定
vim.opt.statusline = vim.opt.statusline + '%{coc#status()}'

-- coc 色の設定
vim.cmd([[
  autocmd ColorScheme * hi CocErrorHighlight ctermfg=White guifg=White ctermbg=Red guibg=Red
  autocmd ColorScheme * hi CocWarningHighlight ctermfg=Black guifg=Black ctermbg=Yellow guibg=Yellow
  autocmd ColorScheme * hi CocInfoSign ctermfg=White guifg=White ctermbg=Green guibg=Green
]])

-- 純粋なテキストファイルの場合には、CoCの間、交互表示を無効化する。
vim.cmd([[
  autocmd FileType text let b:coc_suggest_disable = 1
]])

-- 保管候補選択時の挙動のキーマップ設定
vim.cmd([[
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
]])
vim.keymap.set('i', '<C-n>', 'coc#pum#visible() ? coc#pum#next(1) : "\\<C-n>"',   { expr = true, silent = true})
vim.keymap.set('i', '<C-p>', 'coc#pum#visible() ? coc#pum#prev(1) : "\\<C-p>"',   { expr = true, silent = true})
vim.keymap.set('i', '<down>', 'coc#pum#visible() ? coc#pum#next(0) : "\\<down>"', { expr = true, silent = true})
vim.keymap.set('i', '<up>', 'coc#pum#visible() ? coc#pum#prev(0) : "\\<up>"',     { expr = true, silent = true})

-- coc キーマップ設定
vim.keymap.set('n', 'gp', '<Plug>(coc-diagnostic-prev)',            { silent = true}) -- 前の診断に移動
vim.keymap.set('n', 'gb', '<Plug>(coc-diagnostic-next)',            { silent = true}) -- 次の診断に移動
vim.keymap.set('n', 'gd', '<Plug>(coc-definition)',                 { silent = true}) -- 定義に移動
vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)',            { silent = true}) -- 型定義に移動
vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)',             { silent = true}) -- 実装に移動
vim.keymap.set('n', 'gR', '<Plug>(coc-rename)',                     { silent = true}) -- リネーム
vim.keymap.set('n', 'gr', '<Plug>(coc-references)',                 { silent = true}) -- 参照に移動
vim.keymap.set('n', '<Leader>r', ':QuickRun<CR>',                   { silent = true}) -- クイックラン
vim.keymap.set({'v', 'n'}, '<leader>d', '<Plug>(coc-codeaction-selected)', { }) -- 選択範囲のコードアクション

-- Use K to show documentation in preview window.
vim.keymap.set('n', 'K', ':lua show_documentation()<CR>', {silent = true})

function show_documentation()
  if vim.fn.index({'vim','help'}, vim.bo.filetype) >= 0 then
    vim.cmd('h '..vim.fn.expand('<cword>'))
  elseif vim.fn['coc#rpc#ready']() then
    vim.fn.CocActionAsync('doHover')
  else
    vim.cmd('!'..vim.o.keywordprg.." "..vim.fn.expand('<cword>'))
  end
end

-- 保存時にisortする
vim.cmd([[
  autocmd BufWritePre *.py :CocCommand python.sortImports
]])

-- coc extentions
vim.g.coc_global_extensions = {
    'coc-spell-checker',
    'coc-actions',
    'coc-dictionary',
    'coc-word',
    'coc-vimlsp',
    'coc-neosnippet',
    'coc-yaml',
    'coc-sh',
    'coc-pyright',
    'coc-perl',
    'coc-json',
    'coc-prettier',
    'coc-tsserver',
    'coc-go'
}
