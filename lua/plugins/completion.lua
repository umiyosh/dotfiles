-- Completion {{{
return {
    -- さまざまな言語のスニペットを使いやすく提供してくれるやつ
    {
        "Shougo/neosnippet",
        event = "InsertEnter",
        dependencies = { "Shougo/neosnippet-snippets" },
    },
    {
        "Shougo/neosnippet-snippets",
        lazy = true,
    },
    -- LSP使った開発環境。補完、エラー検出など、いろいろやってくれるやつ
    {
        "neoclide/coc.nvim",
        branch = "release",
        event = {
            "InsertEnter",
            "CmdlineEnter",  -- コマンドライン補完のため
            "BufReadPre",    -- エラー検出のため
        },
    },
    -- coc.nvimの組み込みファジーファインダーをfzfで置き換えるもの
    {
        "antoinemadec/coc-fzf",
        dependencies = { "neoclide/coc.nvim" },
        event = "VeryLazy",  -- coc.nvimの後にロード
    },
    -- LLMを使ってコードを提案してくれるやつ
    {
        "github/copilot.vim",
        event = {
            "InsertEnter",
            "BufReadPre",    -- バッファ読み込み時に初期化
        },
        config = function()
            -- コメントアウトとかmdとかgitcommitの書き込み時にもcopilotを有効化する。  
            vim.g.copilot_filetypes = {
                markdown = true,
                yaml = true,
                gitcommit = true,
            }
        end
    },
}

-- }}}