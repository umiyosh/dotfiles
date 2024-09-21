-- ----------------------------------------------------------------------------
-- 移動設定 Move
-- ----------------------------------------------------------------------------

-- insert mode での移動
vim.keymap.set('i', '<C-e>', '<END>')
vim.keymap.set('i', '<C-a>', '<HOME>')
vim.keymap.set('', '<C-e>', '$')
vim.keymap.set('', '<C-a>', '^')

-- カーソル位置の単語をyankする
vim.api.nvim_set_keymap('n', 'vy', 'vawy', { noremap = true })

-- 矩形選択で自由に移動する
vim.opt.virtualedit:append('block')

-- ビジュアルモード時vで行末まで選択
vim.api.nvim_set_keymap('v', 'v', '$h', { noremap = true })

-- CTRL-hjklでウィンドウ移動
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true })

-- バッファ操作関連
vim.api.nvim_set_keymap('n', '<Leader>kk', ':bd<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>kK', ':bd!<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fk', ':Kwbd<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>bo', ':Bufonly<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>wk', ':w<CR> :bd<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>wK', ':w<CR> :bd!<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>cc', ':new<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', 'bp', ':bprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'bn', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>bb', ':b#<CR>', { noremap = true })

-- %で移動するペアの追加"<":">"
vim.opt.matchpairs:append('<:>')

-- marks
vim.api.nvim_set_keymap('n', '[Mark]', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('n', 'm', '[Mark]', {})

-- 現在位置をマーク
if not vim.g.markrement_char then
    vim.g.markrement_char = {
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
        'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    }
end

vim.api.nvim_set_keymap('n', '[Mark]m', ':lua AutoMarkrement()<CR>', { noremap = true, silent = true })

function _G.AutoMarkrement()
    if not vim.b.markrement_pos then
        vim.b.markrement_pos = 0
    else
        vim.b.markrement_pos = (vim.b.markrement_pos + 1) % #vim.g.markrement_char
    end
    vim.cmd('mark ' .. vim.g.markrement_char[vim.b.markrement_pos + 1])
    print('marked ' .. vim.g.markrement_char[vim.b.markrement_pos + 1])
end

-- 次/前のマーク
vim.api.nvim_set_keymap('n', '[Mark]n', ']`', { noremap = true })
vim.api.nvim_set_keymap('n', '[Mark]p', '[`', { noremap = true })

-- 一覧表示
vim.api.nvim_set_keymap('n', '[Mark]l', ':marks<CR>', { noremap = true })

-- 前回開いてたカーソル位置に移動
vim.api.nvim_create_autocmd(
	'BufReadPost',
	{
		pattern = '*',
		callback = function(ev)
      local last_cursor_pos, last_line = vim.fn.line [['"]], vim.fn.line '$'
      if last_cursor_pos > 1 and last_cursor_pos <= last_line then
        vim.fn.cursor(last_cursor_pos, 1)
      end
		end
	}
)
-- バッファ読み込み時にマークを初期化
vim.cmd([[
  autocmd BufReadPost * delmarks!
]])

