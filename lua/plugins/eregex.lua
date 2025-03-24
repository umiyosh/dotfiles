return {
    {
        -- eregex.vim : vimの正規表現をrubyやperlの正規表現な入力でできる :%S/perlregex/
        "othree/eregex.vim",
        cmd = { "S", "M" },
        init = function()
            vim.g['eregex_forward_delim'] = 'M/'
            vim.g['eregex_backward_delim'] = 'M?'
        end,
    },
}
