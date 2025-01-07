-- プラグインごとの設定 Plugins

------------------------------------
-- termguicolorsの設定
------------------------------------
if vim.fn.has('termguicolors') == 1 then
  vim.opt.termguicolors = true
end

------------------------------------
-- kana/vim-operator-replace
------------------------------------
vim.keymap.set('', '_', '<Plug>(operator-replace)')
vim.keymap.set('v', 'p', '<Plug>(operator-replace)')

------------------------------------
-- junegunn/vim-easy-align
------------------------------------
-- Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vim.keymap.set('v', '<Enter>', '<Plug>(EasyAlign)')
-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)')

------------------------------------
-- scrooloose/nerdcommenter
------------------------------------
-- コメントの間にスペースを空ける
vim.g.NERDSpaceDelims = 1
vim.g.NERDCreateDefaultMappings = 0
-- <Leader>xでコメントをトグル(NERD_commenter.vim)
vim.keymap.set('', '<Leader>x', '<Plug>NERDCommenterToggle')
-- 未対応ファイルタイプのエラーメッセージを表示しない
vim.g.NERDShutUp = 1

------------------------------------
-- カスタムdelimiters
------------------------------------
vim.g.NERDCustomDelimiters = {
  terraform = { left = '#', leftAlt = 'FOO', rightAlt = 'BAR' },
  plantuml  = { left = "'''", leftAlt = 'FOO', rightAlt = 'BAR' }
}

------------------------------------
-- rizzatti/dash.vim
------------------------------------
vim.keymap.set('n', '<leader><leader>d', '<Plug>DashSearch', { silent = true })

------------------------------------
-- mbbill/undotree
------------------------------------
vim.keymap.set('n', 'U', '<cmd>UndotreeToggle<CR>', { silent = true })

------------------------------------
-- liuchengxu/vista.vim
------------------------------------
vim.keymap.set('n', '<leader>tl', '<cmd>Vista coc<CR>', { silent = true })
vim.g['vista#renderer#enable_icon'] = 1

------------------------------------
-- vim-scripts/camelcasemotion
------------------------------------
local camelcase_maps = {'w', 'b', 'e'}
for _, map in ipairs(camelcase_maps) do
  vim.keymap.set('', map, '<Plug>CamelCaseMotion_' .. map, { silent = true })
end

local camelcase_text_objects = {'iw', 'ib', 'ie'}
for _, obj in ipairs(camelcase_text_objects) do
  vim.keymap.set({'o', 'x'}, obj, '<Plug>CamelCaseMotion_' .. obj, { silent = true })
end

------------------------------------
-- lambdalisue/fern.vim
------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = "fern",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', 's', 's', {})
  end
})

vim.keymap.set('n', '<leader>e', '<cmd>Fern . -reveal=% -drawer -toggle -width=40<CR>', { silent = true })

vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = {"fern", "nerdtree", "startify"},
  callback = function()
    vim.fn['glyph_palette#apply']()
  end
})

vim.g['fern#renderer'] = 'nerdfont'
vim.g.fern_disable_startup_warnings = 1

------------------------------------
-- junegunn/fzf.vim
------------------------------------
-- custom jumplist command
-- https://github.com/junegunn/fzf.vim/issues/865#issuecomment-955740371
-- FZFの設定
local function go_to(jumpline)
  local values = vim.split(jumpline, ":")
  vim.cmd("e " .. values[1])
  vim.api.nvim_win_set_cursor(0, {tonumber(values[2]), tonumber(values[3]) - 1})
  vim.cmd("normal zvzz")
end

local function get_line(bufnr, lnum)
  local lines = vim.api.nvim_buf_get_lines(bufnr, lnum - 1, lnum, false)
  if #lines > 0 then
    return vim.trim(lines[1])
  else
    return ''
  end
end

local function jumps()
  -- Get jumps with filename added
  local jump_list = vim.fn.getjumplist()[1]
  local jumps_data = {}
  for i = #jump_list, 1, -1 do
    local jump = jump_list[i]
    jump.name = vim.fn.bufname(jump.bufnr)
    table.insert(jumps_data, jump)
  end

  local jumptext = {}
  for _, val in ipairs(jumps_data) do
    table.insert(jumptext, string.format("%s:%d:%d: %s", val.name, val.lnum, val.col + 1, get_line(val.bufnr, val.lnum)))
  end

  vim.fn['fzf#run'](vim.fn['fzf#vim#with_preview'](vim.fn['fzf#wrap']({
    source = jumptext,
    column = 1,
    options = {'--delimiter', ':', '--bind', 'alt-a:select-all,alt-d:deselect-all', '--preview-window', '+{2}-/2'},
    sink = go_to
  })))
end

vim.api.nvim_create_user_command('Jumps', jumps, {})
vim.api.nvim_create_user_command('Jumps', jumps, {})

-- The prefix key
vim.api.nvim_set_keymap('n', '[fzf]', '<Nop>', {})
vim.api.nvim_set_keymap('v', '[fzf]', '<Nop>', {})
vim.api.nvim_set_keymap('n', 'ss', '[fzf]', {})
vim.api.nvim_set_keymap('v', 'ss', '[fzf]', {})

-- Key mappings
vim.keymap.set('n', '[fzf]f', '<cmd>Files<CR>', { silent = true })
vim.keymap.set('n', '[fzf]F', '<cmd>GitFiles<CR>', { silent = true })
vim.keymap.set('n', '[fzf]b', '<cmd>Buffers<CR>', { silent = true })
vim.keymap.set('n', '[fzf]u', '<cmd>History<CR>', { silent = true })
vim.keymap.set('n', '[fzf]m', '<cmd>Marks<CR>', { silent = true })
vim.keymap.set('n', '[fzf]h', '<cmd>History:<CR>', { silent = true })
vim.keymap.set('n', '[fzf]s', '<cmd>History/<CR>', { silent = true })
vim.keymap.set('n', '[fzf]a', '<cmd>CocFzfList symbols<CR>', { silent = true })
vim.keymap.set('n', '[fzf]k', '<cmd>Maps<CR>', { silent = true })
vim.keymap.set('n', '[fzf]l', '<cmd>BLines<CR>', { silent = true })
vim.keymap.set('n', '[fzf]t', '<cmd>Filetypes<CR>', { silent = true })
vim.keymap.set('n', '[fzf]o', '<cmd>Vista finder coc<CR>', { silent = true })
vim.keymap.set('n', '[fzf]j', '<cmd>Jumps<CR>', { silent = true })
vim.keymap.set('n', '[fzf]d', '<cmd>CocDiagnostics<CR>', { silent = true })

------------------------------------
-- thinca/vim-quickrun
------------------------------------
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

------------------------------------
-- tpope/vim-fugitive
------------------------------------
vim.keymap.set('n', '<Leader>gd', '<cmd>Gdiff<CR>')
vim.keymap.set('n', '<Leader>gs', '<cmd>Git<CR>')
vim.keymap.set('n', '<Leader>gl', '<cmd>Git log %<CR>')
vim.keymap.set('n', '<Leader>ga', '<cmd>Gwrite<CR>')
vim.keymap.set('n', '<Leader>gc', '<cmd>Git commit<CR>')
vim.keymap.set('n', '<Leader>gC', '<cmd>Git commit --amend<CR>')
vim.keymap.set('n', '<Leader>gb', '<cmd>Git blame<CR>')

------------------------------------
-- smoka7/hop.nvim
------------------------------------
vim.keymap.set({'n', 'v'}, 'sb', '<cmd>HopWordBC<CR>')
vim.keymap.set({'n', 'v'}, 'sj', '<cmd>HopLineAC<CR>')
vim.keymap.set({'n', 'v'}, 'sk', '<cmd>HopLineBC<CR>')
vim.keymap.set({'n', 'v'}, 'se', '<cmd>HopWordAC<CR>')
vim.keymap.set({'n', 'v'}, 'sw', '<cmd>HopWord<CR>')
vim.keymap.set({'n', 'v'}, 'sl', '<cmd>HopLine<CR>')
vim.keymap.set({'n', 'v'}, 'sf', '<cmd>HopChar1<CR>')
vim.keymap.set({'n', 'v'}, 's/', '<cmd>HopPattern<CR>')

------------------------------------
-- vim-airline settings
------------------------------------
vim.g['airline_powerline_fonts'] = 1
vim.g['airline_theme'] = 'dark'
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline_highlighting_cache'] = 1

------------------------------------
-- VoOM (markdown outliner)
------------------------------------
vim.g.voom_tree_width = 60
vim.g['voom_tree_placement'] = 'right'
vim.g['voom_ft_modes'] = {markdown = 'markdown', pandoc = 'markdown'}
vim.g['voom_user_command'] = "python3 import voom_addons"

vim.keymap.set('n', '<Leader>vm', '<CMD>VoomToggle<CR>', {silent = true, noremap = true})

------------------------------------
-- eregex.vim の設定
------------------------------------
vim.g['eregex_forward_delim'] = 'M/'
vim.g['eregex_backward_delim'] = 'M?'

------------------------------------
-- heavenshell/vim-pydocstring
------------------------------------
vim.g['pydocstring_enable_mapping'] = 0
-- you need to install doq before using this plugin. (pip install doq)
vim.g['pydocstring_doq_path'] = vim.fn.expand("$VIRTUAL_ENV/bin/doq")
vim.keymap.set('n', '<Leader>l', '<Plug>(pydocstring)', { noremap = false, silent = true })

------------------------------------
-- vim-delve.vim
------------------------------------
vim.keymap.set('n', '<Leader>9', '<cmd>DlvToggleBreakpoint<CR>', { silent = true })
vim.keymap.set('n', '<Leader>8', '<cmd>DlvClearAll<CR>', { silent = true })
vim.keymap.set('n', '<Leader>5', '<cmd>DlvDebug<CR>', { silent = true })
vim.keymap.set('n', '<Leader>4', '<cmd>DlvTest<CR>', { silent = true })

------------------------------------
-- hashivim/vim-terraform の設定
------------------------------------
vim.g.terraform_fmt_on_save = 1

------------------------------------
-- vim-test/vim-test
-- ./../nvim_plugin_settings.vim:10
------------------------------------
vim.g['test#strategy'] = 'dispatch'
vim.keymap.set('n', '<Leader>t', '<cmd>TestFile<CR>', { silent = true })

-- ------------------------------------
-- RRethy/vim-illuminate
-- ------------------------------------
vim.g.Illuminate_useDeprecated = 1

local illuminate_augroup = vim.api.nvim_create_augroup("illuminate_augroup", { clear = true })

if vim.fn.has('nvim') == 1 then
  vim.api.nvim_create_autocmd("VimEnter", {
    group = illuminate_augroup,
    pattern = "*",
    command = "hi illuminatedWord cterm=underline,bold guibg=DarkMagenta",
  })
else
  vim.api.nvim_create_autocmd("VimEnter", {
    group = illuminate_augroup,
    pattern = "*",
    command = "hi illuminatedWord cterm=underline,bold gui=undercurl,bold ctermbg=19",
  })
end

------------------------------------
-- tyru/open-browser.vim
------------------------------------
-- Disable netrw's gx mapping
vim.g.netrw_nogx = 1

-- Set key mappings for open-browser plugin
vim.keymap.set('n', 'gx', '<Plug>(openbrowser-smart-search)', { silent = true })
vim.keymap.set('v', 'gx', '<Plug>(openbrowser-smart-search)', { silent = true })

------------------------------------
-- haya14busa/vim-asterisk
------------------------------------
vim.keymap.set('', '*', '<Plug>(asterisk-z*)', { silent = true })

if not vim.g.vscode then
  ------------------------------------
  -- 'hiphish/rainbow-delimiters.nvim'
  ------------------------------------
  vim.g.rainbow_delimiters = {
    strategy = {
      [''] = 'rainbow_delimiters#strategy.global',
      vim = 'rainbow_delimiters#strategy.local'
    },
    query = {
      [''] = 'rainbow-delimiters',
      lua = 'rainbow-blocks'
    },
    highlight = {
      'RainbowDelimiterRed',
      'RainbowDelimiterYellow',
      'RainbowDelimiterBlue',
      'RainbowDelimiterOrange',
      'RainbowDelimiterGreen',
      'RainbowDelimiterViolet',
      'RainbowDelimiterCyan'
    }
  }
end

-- ------------------------------------
-- copilot.vim
-- mdとgitcommitの書き込み時にもcopilotを有効化する。
-- ------------------------------------
vim.g.copilot_filetypes = {
  markdown = true,
  yaml = true,
  gitcommit = true,
}

------ 以上はvimrcから移動 --------
------------------------------------
-- 'phaazon/hop.nvim'
------------------------------------
require'hop'.setup()
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

if not vim.g.vscode then
  ---------------------------------------
  -- 'lukas-reineke/indent-blankline.nvim
  ---------------------------------------
  local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
  }
  local hooks = require "ibl.hooks"
  -- create the highlight groups in the highlight setup hook, so they are reset
  -- every time the colorscheme changes
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
  end)
  vim.g.indent_blankline_context_patterns = {
      "declaration", "expression", "pattern", "primary_expression",
      "statement", "switch_body"
  }
  vim.g.rainbow_delimiters = { highlight = highlight }
  require("ibl").setup {
    indent = {
       char = "│",
       tab_char = "│",
       smart_indent_cap = true,
       priority = 2,
     },
    scope = {
      highlight = highlight,
      show_start = true,
      show_end = true,
    }
  }
  hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

  ---------------------------------------
  -- 'nvim-treesitter/nvim-treesitter'
  ---------------------------------------
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = {
      enable = true,
      disable = {},
    },
  }
  ---------------------------------------
  -- akinsho/bufferline.nvim
  ---------------------------------------
  require("bufferline").setup{
    options = {
      diagnostics = "coc",
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      themable = true,
      color_icons = true,
      offsets = {
        {
          filetype = "fern",
          text = function()
            return vim.fn.getcwd()
          end,
          highlight = "Directory",
          text_align = "left"
        }
      }

    }
  }
  ---------------------------------------
  -- m-demare/hlargs.nvim
  ---------------------------------------
  require('hlargs').setup()
  ---------------------------------------
  -- lewis6991/gitsigns.nvim
  ---------------------------------------
  require('gitsigns').setup({
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    }
  })
end


---------------------------------------
-- norcalli/nvim-colorizer.lua
---------------------------------------
require'colorizer'.setup()

