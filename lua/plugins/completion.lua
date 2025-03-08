-- Completion {{{
return {
    -- さまざまな言語のスニペットを使いやすく提供してくれるやつ
    {
        "Shougo/neosnippet"
    },
    {
        "Shougo/neosnippet-snippets"
    },
    -- LSP使った開発環境。補完、エラー検出など、いろいろやってくれるやつ
    {
        "neoclide/coc.nvim",
        branch = "release"
    },
    -- coc.nvimの組み込みファジーファインダーをfzfで置き換えるもの
    {
        "antoinemadec/coc-fzf",
    },
    -- LLMを使ってコードを提案してくれるやつ
    {
        "github/copilot.vim",
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