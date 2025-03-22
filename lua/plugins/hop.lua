return {
    {
        "smoka7/hop.nvim",
        keys = {
            { "sb", "<cmd>HopWordBC<CR>", mode = { "n", "v" }, silent = true },
            { "sj", "<cmd>HopLineAC<CR>", mode = { "n", "v" }, silent = true },
            { "sk", "<cmd>HopLineBC<CR>", mode = { "n", "v" }, silent = true },
            { "se", "<cmd>HopWordAC<CR>", mode = { "n", "v" }, silent = true },
            { "sw", "<cmd>HopWord<CR>", mode = { "n", "v" }, silent = true },
            { "sl", "<cmd>HopLine<CR>", mode = { "n", "v" }, silent = true },
            { "sf", "<cmd>HopChar1<CR>", mode = { "n", "v" }, silent = true },
            { "s/", "<cmd>HopPattern<CR>", mode = { "n", "v" }, silent = true },
        },
        config = function()
            require'hop'.setup()
            vim.opt.list = true
            vim.opt.listchars:append("space:⋅")
            vim.opt.listchars:append("eol:↴")
        end,
    },
}
