return {
    {
        "junegunn/fzf",
        cond = not vim.g.vscode,
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
