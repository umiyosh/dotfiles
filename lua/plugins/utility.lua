return {
  -- vimproc : vimから非同期実行。vimshelleで必要
  {
    "Shougo/vimproc.vim",
    build = "make",
  },
  -- 左ペインにファイル一覧を表示するやつ
  {
    "lambdalisue/fern.vim",
    cond = not vim.g.vscode,
    dependencies = {
      "lambdalisue/fern-git-status.vim",
      "lambdalisue/nerdfont.vim",
      "lambdalisue/fern-renderer-nerdfont.vim",
      "lambdalisue/glyph-palette.vim",
    },
    init = function()
      vim.g['fern#renderer'] = 'nerdfont'
      vim.g.fern_disable_startup_warnings = 1
    end,
    config = function()
      vim.keymap.set('n', '<leader>e', '<cmd>Fern . -reveal=% -drawer -toggle -width=40<CR>', { silent = true })
      
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fern",
        callback = function()
          vim.api.nvim_buf_set_keymap(0, 'n', 's', 's', {})
        end
      })

      vim.api.nvim_create_autocmd({"FileType"}, {
        pattern = {"fern", "nerdtree", "startify"},
        callback = function()
          vim.fn['glyph_palette#apply']()
        end
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("fern-custom", { clear = true }),
        pattern = "fern",
        callback = function()
          -- Buffer-local keymaps
          vim.keymap.set("n", "<C-h>", "<C-w>h", { buffer = true })
          vim.keymap.set("n", "<C-l>", "<C-w>l", { buffer = true })
        end,
      })
    end,
  },
  -- vimからGit操作する
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set('n', '<Leader>gd', '<cmd>Gdiff<CR>')
      vim.keymap.set('n', '<Leader>gs', '<cmd>Git<CR>')
      vim.keymap.set('n', '<Leader>gl', '<cmd>Git log %<CR>')
      vim.keymap.set('n', '<Leader>ga', '<cmd>Gwrite<CR>')
      vim.keymap.set('n', '<Leader>gc', '<cmd>Git commit<CR>')
      vim.keymap.set('n', '<Leader>gC', '<cmd>Git commit --amend<CR>')
      vim.keymap.set('n', '<Leader>gb', '<cmd>Git blame<CR>')
    end,
  },
  -- Github連携強化のプラグイン。GBrowseで開くとかのやつ
  {
    "tpope/vim-rhubarb",
  },
  -- 編集した行のgit差分を左側に表示してくれるやつ
  {
    "lewis6991/gitsigns.nvim",
    cond = not vim.g.vscode,
    config = function()
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
    end,
  },
  -- ステータスラインをカッコよくするやつ
  {
    "vim-airline/vim-airline",
    cond = not vim.g.vscode,
    init = function()
      vim.g['airline_powerline_fonts'] = 1
      vim.g['airline_theme'] = 'dark'
      vim.g['airline#extensions#tabline#enabled'] = 1
      vim.g['airline_highlighting_cache'] = 1
    end,
  },
  -- バッファーを上部に表示してくれるやつ
  {
    "akinsho/bufferline.nvim",
    cond = not vim.g.vscode,
    version = "*",
    config = function()
      require("bufferline").setup{
        options = {
          diagnostics = "coc",
          diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or " "
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
    end,
  },
  -- Markdownの見出し単位の折りたたみを提供するやつ
  {
    "nelstrom/vim-markdown-folding",
    ft = "markdown",
  },
  -- 分割を維持してバッファ削除
  {
    "rgarver/Kwbd.vim",
  },
  -- 現在開いている以外のバッファを全部削除するやつ
  {
    "duff/vim-bufonly",
  },
  -- バイナリエディターの機能を提供してくれるやつ
  {
    "Shougo/vinarise",
  },
  -- markdownのアウトライン表示
  {
    "vim-voom/VOoM",
    config = function()
      vim.keymap.set('n', '<Leader>vm', '<CMD>VoomToggle<CR>', {silent = true, noremap = true})
    end,
    init = function()
      vim.g.voom_tree_width = 60
      vim.g['voom_tree_placement'] = 'right'
      vim.g['voom_ft_modes'] = {markdown = 'markdown', pandoc = 'markdown'}
      vim.g['voom_user_command'] = "python3 import voom_addons"
    end,
  },
  -- foldtextの情報量を増やして折り畳みの体験をよくするやつ
  {
    "LeafCage/foldCC",
  },
  -- .(ドット)で繰り返し操作を拡張してくれるやつ
  {
    "tpope/vim-repeat",
  },
  -- ディレクトリ間の再帰的なDiff表示してくれるやつ
  {
    "vim-scripts/DirDiff.vim",
  },
  -- カーソル下のワードをDashで検索する
  {
    "rizzatti/dash.vim",
    config = function()
      vim.keymap.set('n', '<leader><leader>d', '<Plug>DashSearch', { silent = true })
    end,
  },
  -- diffchar.vim
  {
    "rickhowe/diffchar.vim",
  },
  -- アスタリスク入力後にカーソルが移動しないのを防ぐ効果がある
  {
    "haya14busa/vim-asterisk",
    config = function()
      vim.keymap.set('', '*', '<Plug>(asterisk-z*)', { silent = true })
    end,
  },
  -- nerdfontのグリフを使ってファイルタイプを表示してくれるやつ
  {
    "ryanoasis/vim-devicons",
    cond = not vim.g.vscode,
  },
  -- QuickFixWindowにプレビューを追加したり、見栄えを良くしてくれるやつ
  {
    "kevinhwang91/nvim-bqf",
  },
  -- 編集ファイル内のURLをいい感じにブラウザで開いてくれるやつ
  {
    "tyru/open-browser.vim",
    config = function()
      vim.keymap.set('n', 'gx', '<Plug>(openbrowser-smart-search)', { silent = true })
      vim.keymap.set('v', 'gx', '<Plug>(openbrowser-smart-search)', { silent = true })
    end,
    init = function()
      vim.g.netrw_nogx = 1
    end,
  },
} 