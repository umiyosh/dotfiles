-- Searching/Moving{{{
return {
    -- camelcasemotion : CamelCaseやsnake_case単位でのワード移動
    {
        "vim-scripts/camelcasemotion",
        config = function()
            -- camelcasemotionの設定
            local camelcase_maps = {'w', 'b', 'e'}
            for _, map in ipairs(camelcase_maps) do
                vim.keymap.set('', map, '<Plug>CamelCaseMotion_' .. map, { silent = true })
            end

            local camelcase_text_objects = {'iw', 'ib', 'ie'}
            for _, obj in ipairs(camelcase_text_objects) do
                vim.keymap.set({'o', 'x'}, obj, '<Plug>CamelCaseMotion_' .. obj, { silent = true })
            end
        end,
    },
    -- 「%」による対応括弧へのカーソル移動機能を拡張
    {
        "andymass/vim-matchup",
    },
    -- eregex.vim : vimの正規表現をrubyやperlの正規表現な入力でできる :%S/perlregex/
    {
        "othree/eregex.vim",
        config = function()
            -- eregex.vim の設定
            vim.g['eregex_forward_delim'] = 'M/'
            vim.g['eregex_backward_delim'] = 'M?'
        end,
    },
    -- hop.nvim : easymotion的な動作を提供してキーボードでの移動を効率化
    {
        "smoka7/hop.nvim",
        config = function()
            require'hop'.setup()
            vim.opt.list = true
            vim.opt.listchars:append("space:⋅")
            vim.opt.listchars:append("eol:↴")
        end,
    },
}

-- }}}