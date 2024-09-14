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
vim.api.nvim_set_keymap('n', 'U', ':UndotreeToggle<CR>', { noremap = true, silent = true })

------------------------------------
-- liuchengxu/vista.vim
------------------------------------
vim.api.nvim_set_keymap('n', '<leader>tl', ':Vista coc<CR>', { noremap = true, silent = true })
vim.g['vista#renderer#enable_icon'] = 1

------------------------------------
-- vim-scripts/camelcasemotion
------------------------------------
local camelcase_maps = {'w', 'b', 'e'}
for _, map in ipairs(camelcase_maps) do
  vim.api.nvim_set_keymap('', map, '<Plug>CamelCaseMotion_' .. map, { silent = true })
end

local camelcase_text_objects = {'iw', 'ib', 'ie'}
for _, obj in ipairs(camelcase_text_objects) do
  vim.api.nvim_set_keymap('o', obj, '<Plug>CamelCaseMotion_' .. obj, { silent = true })
  vim.api.nvim_set_keymap('x', obj, '<Plug>CamelCaseMotion_' .. obj, { silent = true })
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

vim.api.nvim_set_keymap('n', '<leader>e', ':Fern . -reveal=% -drawer -toggle -width=40<CR>', { noremap = true, silent = true })

vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = {"fern", "nerdtree", "startify"},
  callback = function()
    vim.fn['glyph_palette#apply']()
  end
})

vim.g['fern#renderer'] = 'nerdfont'
vim.g.fern_disable_startup_warnings = 1

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
  -- 'jackMort/ChatGPT.nvim'
  ---------------------------------------
  require("chatgpt").setup({
     openai_params = {
       model = "gpt-4o",
       frequency_penalty = 0,
       presence_penalty = 0,
       max_tokens = 4095,
       temperature = 0.2,
       top_p = 0.1,
       n = 1,
     },
    actions_paths = {
      vim.fn.expand("$HOME/dotfiles/cgpt_actions.json"),
    },
    })
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

