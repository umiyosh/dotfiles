return {
    {
        -- coc.nvimの組み込みファジーファインダーをfzfで置き換えるもの
        "antoinemadec/coc-fzf",
        dependencies = { "neoclide/coc.nvim" },
        event = "VeryLazy",  -- coc.nvimの後にロード
    },
}
