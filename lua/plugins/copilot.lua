return {
    {
        -- LLMを使ってコードを提案してくれるやつ
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
