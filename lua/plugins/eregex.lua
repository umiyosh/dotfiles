return {
    {
        "othree/eregex.vim",
        cmd = { "S", "M" },
        init = function()
            vim.g['eregex_forward_delim'] = 'M/'
            vim.g['eregex_backward_delim'] = 'M?'
        end,
    },
}
