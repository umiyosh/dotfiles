-- ----------------------------------------------------------------------------
-- 雑多な工夫の設定達
-- ----------------------------------------------------------------------------

-- 改行を含まず行末までヤンク
vim.keymap.set('n', 'Y', 'y$')

-- Open junk file
vim.api.nvim_create_user_command('JunkFile', function()
  local junk_dir = vim.fn.expand('$HOME/.vim_junk' .. os.date('/%Y/%m'))
  if vim.fn.isdirectory(junk_dir) == 0 then
    vim.fn.mkdir(junk_dir, 'p')
  end

  local filename = vim.fn.input('Junk Code: ', junk_dir .. os.date('/%Y-%m-%d-%H%M%S.'))
  if filename ~= '' then
    vim.cmd('edit ' .. filename)
  end
end, {})

-- 行番号つきのコピー
vim.keymap.set('v', 'ssc', '<ESC>:%!cat -n|perl -pe "s:^ +::g"<CR>gvyugv<ESC>')

-- Luaでの文字数カウント機能
vim.keymap.set('v', '<leader>ii', ':lua Count_Char()<CR>', { silent = true })

function Count_Char()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local start_line_num = start_pos[2]
    local end_line_num = end_pos[2]
    local linenum = end_line_num - start_line_num + 1

    local lines = vim.fn.getline(start_line_num, end_line_num)
    local str = table.concat(lines, "\n")

    local gross_words = vim.fn.strchars(str, true)

    vim.api.nvim_echo({{"選択範囲の行数は " .. linenum .. " です", "Normal"}}, false, {})
    vim.api.nvim_echo({{"選択範囲の総文字数は " .. gross_words .. " です", "Normal"}}, false, {})
end

-- 行選択や矩形選択でもビジュアルモード中IやAで文字を挿入できるようにする
local function force_blockwise_visual(next_key)
    local mode = vim.fn.mode()
    if mode == 'v' then
        return '<C-v>' .. next_key
    elseif mode == 'V' then
        return '<C-v>0o$' .. next_key
    else
        return next_key
    end
end
local function apply_blockwise_visual(key)
    return function()
        local keys = force_blockwise_visual(key)
        local termcodes = vim.api.nvim_replace_termcodes(keys, true, false, true)
        vim.api.nvim_feedkeys(termcodes, 'n', true)
    end
end
vim.keymap.set('x', 'I', apply_blockwise_visual('I'), { noremap = true, desc = "Insert at beginning of visual block" })
vim.keymap.set('x', 'A', apply_blockwise_visual('A'), { noremap = true, desc = "Insert at end of visual block" })

-- かな(alt)＋Qで:q!
vim.keymap.set('n', '<M-q>', ':q!<CR>')
-- かな(alt)＋Sで上書き保存
vim.keymap.set('n', '<M-s>', ':<C-u>w<CR>')

-- Mac の辞書.appで開く
if vim.fn.has('mac') == 1 then
    vim.api.nvim_create_user_command('MacDictCWord', function()
        vim.fn.system('open ' .. vim.fn.shellescape('dict://' .. vim.fn.shellescape(vim.fn.expand('<cword>'))))
    end, {})
    vim.keymap.set('n', '<Leader>j', ':<C-u>MacDictCWord<CR>', { silent = true })
end

-- spell check
-- vim.opt.spelllang = 'en,cjk'
-- vim.opt.spellfile = vim.fn.expand('~/dotfiles_private/.vim/spell/en.utf-8.add')

-- local function spell_conf()
    -- local syntax = vim.api.nvim_exec('syntax', true)

    -- vim.opt.spell = true

    -- if string.match(syntax, '/<comment>') then
        -- vim.cmd('syntax spell default')
        -- vim.cmd('syntax match SpellMaybeCode /\\<\\h\\l*[_A-Z]\\h\\{- }\\>/ contains=@NoSpell transparent containedin=Comment contained')
    -- else
        -- vim.cmd('syntax spell toplevel')
        -- vim.cmd('syntax match SpellMaybeCode /\\<\\h\\l*[_A-Z]\\h\\{- }\\>/ contains=@NoSpell transparent')
    -- end

    -- vim.cmd('syntax cluster Spell add=SpellNotAscii,SpellMaybeCode')
-- end

-- vim.api.nvim_create_augroup('spell_check', { clear = true })
-- vim.api.nvim_create_autocmd({'BufReadPost', 'BufNewFile', 'Syntax'}, {
    -- group = 'spell_check',
    -- callback = spell_conf
-- })

-- for vimdiff
vim.api.nvim_create_autocmd('VimEnter', {
    pattern = '*',
    callback = function()
        if vim.opt.diff:get() then
            vim.cmd('windo set wrap')
        end
    end
})

-- gx to open URL
vim.keymap.set('n', 'gx', 'yiW:!open <C-r>" & <CR><CR>')

-- github project rootでrgを実行する
vim.api.nvim_create_user_command('Rg2', function(opts)
    local dir = vim.fn.system('git -C '..vim.fn.expand('%:p:h')..' rev-parse --show-toplevel 2> /dev/null'):gsub('\n', '')
    require('fzf-lua').grep({
        search = opts.args,
        cwd = dir,
    })
end, { nargs = '*' })

-- 現在開いているファイルPATHをcursorやvscodeで開く
-- vim.keymap.set('n', '<leader>cu', ':!cursor %<CR>')
vim.keymap.set('n', '<leader>cu', function()
    local file_path = vim.fn.expand('%:p')
    local line_number = vim.fn.line('.')
    vim.cmd(string.format('!cur %s %s', file_path, line_number))
end, { noremap = true, silent = false })

vim.keymap.set('n', '<leader>co', ':!code %<CR>')
