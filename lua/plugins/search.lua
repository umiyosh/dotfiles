-- Searching/Moving{{{
return {
    -- camelcasemotion : CamelCaseやsnake_case単位でのワード移動
    {
        "vim-scripts/camelcasemotion",
        keys = {
            { "w", "<Plug>CamelCaseMotion_w", mode = "", silent = true },
            { "b", "<Plug>CamelCaseMotion_b", mode = "", silent = true },
            { "e", "<Plug>CamelCaseMotion_e", mode = "", silent = true },
            { "iw", "<Plug>CamelCaseMotion_iw", mode = { "o", "x" }, silent = true },
            { "ib", "<Plug>CamelCaseMotion_ib", mode = { "o", "x" }, silent = true },
            { "ie", "<Plug>CamelCaseMotion_ie", mode = { "o", "x" }, silent = true },
        },
    },
    -- 「%」による対応括弧へのカーソル移動機能を拡張
    {
        "andymass/vim-matchup",
        event = { "BufReadPost", "BufNewFile" },
    },
    -- eregex.vim : vimの正規表現をrubyやperlの正規表現な入力でできる :%S/perlregex/
    {
        "othree/eregex.vim",
        cmd = { "S", "M" },
        init = function()
            vim.g['eregex_forward_delim'] = 'M/'
            vim.g['eregex_backward_delim'] = 'M?'
        end,
    },
    -- hop.nvim : easymotion的な動作を提供してキーボードでの移動を効率化
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
    {
        "junegunn/fzf.vim",
        cond = not vim.g.vscode,
        dependencies = { "junegunn/fzf" },
        cmd = {
            "Files", "GitFiles", "Buffers", "History", "Marks",
            "Maps", "BLines", "Filetypes", "Jumps"
        },
        keys = {
            { "ssf", "<cmd>Files<CR>", desc = "FZF Files" },
            { "ssF", "<cmd>GitFiles<CR>", desc = "FZF Git Files" },
            { "ssb", "<cmd>Buffers<CR>", desc = "FZF Buffers" },
            { "ssu", "<cmd>History<CR>", desc = "FZF File History" },
            { "ssm", "<cmd>Marks<CR>", desc = "FZF Marks" },
            { "ssh", "<cmd>History:<CR>", desc = "FZF Command History" },
            { "sss", "<cmd>History/<CR>", desc = "FZF Search History" },
            { "ssa", "<cmd>CocFzfList symbols<CR>", desc = "FZF Coc Symbols" },
            { "ssk", "<cmd>Maps<CR>", desc = "FZF Key Mappings" },
            { "ssl", "<cmd>BLines<CR>", desc = "FZF Buffer Lines" },
            { "sst", "<cmd>Filetypes<CR>", desc = "FZF Filetypes" },
            { "sso", "<cmd>Vista finder coc<CR>", desc = "FZF Vista Finder" },
            { "ssj", "<cmd>Jumps<CR>", desc = "FZF Jumps" },
            { "ssd", "<cmd>CocDiagnostics<CR>", desc = "FZF Coc Diagnostics" },
        },
        config = function()
            -- custom jumplist command
            -- https://github.com/junegunn/fzf.vim/issues/865#issuecomment-955740371
            -- FZFの設定
            local function go_to(jumpline)
                local values = vim.split(jumpline, ":")
                vim.cmd("e " .. values[1])
                vim.api.nvim_win_set_cursor(0, {tonumber(values[2]), tonumber(values[3]) - 1})
                vim.cmd("normal zvzz")
            end

            local function get_line(bufnr, lnum)
                local lines = vim.api.nvim_buf_get_lines(bufnr, lnum - 1, lnum, false)
                if #lines > 0 then
                    return vim.trim(lines[1])
                else
                    return ''
                end
            end

            local function jumps()
                -- Get jumps with filename added
                local jump_list = vim.fn.getjumplist()[1]
                local jumps_data = {}
                for i = #jump_list, 1, -1 do
                    local jump = jump_list[i]
                    jump.name = vim.fn.bufname(jump.bufnr)
                    table.insert(jumps_data, jump)
                end

                local jumptext = {}
                for _, val in ipairs(jumps_data) do
                    table.insert(jumptext, string.format("%s:%d:%d: %s", val.name, val.lnum, val.col + 1, get_line(val.bufnr, val.lnum)))
                end

                vim.fn['fzf#run'](vim.fn['fzf#vim#with_preview'](vim.fn['fzf#wrap']({
                    source = jumptext,
                    column = 1,
                    options = {'--delimiter', ':', '--bind', 'alt-a:select-all,alt-d:deselect-all', '--preview-window', '+{2}-/2'},
                    sink = go_to
                })))
            end

            vim.api.nvim_create_user_command('Jumps', jumps, {})
        end,
    },
}

-- }}}
