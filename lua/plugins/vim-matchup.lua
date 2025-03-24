return {
    {
        -- 「%」による対応括弧へのカーソル移動機能を拡張
        "andymass/vim-matchup",
        event = { "BufReadPost", "BufNewFile" },
    },
}
