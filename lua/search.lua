-- Search settings
vim.opt.wrapscan = true   -- Wrap search to beginning when reaching end
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true  -- Override ignorecase if search pattern contains uppercase
vim.opt.incsearch = true  -- Show where the pattern matches as it is typed
vim.opt.hlsearch = true   -- Highlight all matches of the search pattern

-- Clear search highlighting with double Escape
vim.api.nvim_set_keymap('n', '<ESC><ESC>', ':nohlsearch<CR><ESC>', { noremap = true, silent = true })

-- Replace word under cursor
-- Look up help for word under cursor
vim.cmd([[
  vnoremap /s y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
  vnoremap /r "xy:%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>
]])

