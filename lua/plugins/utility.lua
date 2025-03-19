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
    cmd = "Fern",
    keys = {
      { "<leader>e", "<cmd>Fern . -reveal=% -drawer -toggle -width=40<CR>", mode = "n", silent = true },
    },

    init = function()
      vim.g['fern#renderer'] = 'nerdfont'
      vim.g.fern_disable_startup_warnings = 1
    end,
    config = function()
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
      -- vim-fernの設定
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fern",
        callback = function()
          -- <C-S-u>を親ディレクトリに移動するアクションにマッピング
          vim.keymap.set("n", "<C-h>", "<Plug>(fern-action-leave)<CR>", {
            buffer = true,
            silent = true,
            noremap = false
          })
        end,
      })
    end,
  },
  -- vimからGit操作する
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gdiff", "Gwrite", "Gcommit", "Gblame" },
    keys = {
      { "<Leader>gd", "<cmd>Gdiff<CR>", mode = "n" },
      { "<Leader>gs", "<cmd>Git<CR>", mode = "n" },
      { "<Leader>gl", "<cmd>Git log %<CR>", mode = "n" },
      { "<Leader>ga", "<cmd>Gwrite<CR>", mode = "n" },
      { "<Leader>gc", "<cmd>Git commit<CR>", mode = "n" },
      { "<Leader>gC", "<cmd>Git commit --amend<CR>", mode = "n" },
      { "<Leader>gb", "<cmd>Git blame<CR>", mode = "n" },
    },
  },
  -- Github連携強化のプラグイン。GBrowseで開くとかのやつ
  {
    "tpope/vim-rhubarb",
    cmd = "GBrowse",
    dependencies = { "tpope/vim-fugitive" },
  },
  -- 編集した行のgit差分を左側に表示してくれるやつ
  {
    "lewis6991/gitsigns.nvim",
    cond = not vim.g.vscode,
    event = { "BufReadPre", "BufNewFile" },
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
    event = "VimEnter",
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
    event = "VimEnter",
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
    cmd = "Kwbd",
  },
  -- 現在開いている以外のバッファを全部削除するやつ
  {
    "duff/vim-bufonly",
    cmd = "BufOnly",
  },
  -- バイナリエディターの機能を提供してくれるやつ
  {
    "Shougo/vinarise",
    cmd = "Vinarise",
  },
  -- markdownのアウトライン表示
  {
    "vim-voom/VOoM",
    cmd = "VoomToggle",
    keys = {
      { "<Leader>vm", "<CMD>VoomToggle<CR>", mode = "n", silent = true, noremap = true },
    },
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
    event = { "BufReadPost", "BufNewFile" },
  },
  -- .(ドット)で繰り返し操作を拡張してくれるやつ
  {
    "tpope/vim-repeat",
  },
  -- ディレクトリ間の再帰的なDiff表示してくれるやつ
  {
    "vim-scripts/DirDiff.vim",
    cmd = "DirDiff",
  },
  -- カーソル下のワードをDashで検索する
  {
    "rizzatti/dash.vim",
    keys = {
      { "<leader><leader>d", "<Plug>DashSearch", mode = "n", silent = true },
    },
  },
  -- diffchar.vim
  {
    "rickhowe/diffchar.vim",
    event = "BufReadPost",
  },
  -- アスタリスク入力後にカーソルが移動しないのを防ぐ効果がある
  {
    "haya14busa/vim-asterisk",
    keys = {
      { "*", "<Plug>(asterisk-z*)", mode = "", silent = true },
    },
  },
  -- nerdfontのグリフを使ってファイルタイプを表示してくれるやつ
  {
    "ryanoasis/vim-devicons",
    cond = not vim.g.vscode,
    lazy = true,  -- 他のプラグインの依存として必要時にロード
  },
  -- QuickFixWindowにプレビューを追加したり、見栄えを良くしてくれるやつ
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",  -- QuickFixウィンドウが開かれた時にロード
  },
  -- 編集ファイル内のURLをいい感じにブラウザで開いてくれるやつ
  {
    "tyru/open-browser.vim",
    keys = {
      { "gx", "<Plug>(openbrowser-smart-search)", mode = "n", silent = true },
      { "gx", "<Plug>(openbrowser-smart-search)", mode = "v", silent = true },
    },
    init = function()
      vim.g.netrw_nogx = 1
    end,
  },
}
