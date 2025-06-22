return {
  {
    -- K8sのexplainを使うために、カーソル下のkeyをフルパスで取得するやつ
    "cuducos/yaml.nvim",
    ft = "yaml",
    config = function()
      require("yaml_nvim").setup()

      -- YAMLファイルでShift+Kを押した時にkubectl explainを実行
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "yaml",
        callback = function()
          vim.keymap.set("n", "K", function()
            local yaml_path = require("yaml_nvim").get_yaml_key()
            if yaml_path and yaml_path ~= "" then
              -- YAMLファイルからKindを取得（カーソル位置から上方向に検索）
              local function get_kind_from_yaml()
                -- 現在のカーソル行番号を取得（1-indexed）
                local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
                local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
                
                -- カーソル行から上方向に検索
                for i = cursor_line, 1, -1 do
                  local line = lines[i]
                  
                  -- ドキュメント区切り（---）に遭遇したら検索終了
                  if line:match("^%-%-%-") then
                    break
                  end
                  
                  -- kind: パターンを検索
                  local kind = line:match("^kind:%s*(.+)$")
                  if kind then
                    return vim.trim(kind)
                  end
                end
                
                return nil
              end

              local kind = get_kind_from_yaml()
              if not kind then
                vim.notify("Kind not found in YAML file", vim.log.levels.WARN)
                return
              end

              -- 配列インデックス（[0]など）を除去
              local cleaned_path = yaml_path:gsub("%[%d+%]", "")

              -- Kindを先頭に付与してkubectl explainコマンドを実行
              local full_path = kind .. "." .. cleaned_path
              local cmd = "kubectl explain " .. full_path
              vim.notify("Running: " .. cmd, vim.log.levels.INFO)

              -- kubectl explainコマンドを実行して結果を取得
              local result = vim.fn.system(cmd)

              -- 新しい垂直分割ウィンドウを開く
              vim.cmd("vsplit")

              -- 新しい編集可能なバッファを作成（ファイルに紐付かない）
              local buf = vim.api.nvim_create_buf(false, true)
              vim.api.nvim_win_set_buf(0, buf)

              -- バッファにコマンドの実行結果を設定
              local lines = vim.split(result, "\n")
              vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

              -- 可読性向上のためfiletypeをmanに設定
              vim.api.nvim_buf_set_option(buf, "filetype", "man")

              -- バッファ名にコマンドを設定（参照用）
              vim.api.nvim_buf_set_name(buf, "kubectl explain " .. full_path)

              -- カーソルをバッファの先頭に移動
              vim.api.nvim_win_set_cursor(0, {1, 0})
            else
              vim.notify("YAML key path not found", vim.log.levels.WARN)
            end
          end, { buffer = true, desc = "kubectl explain for YAML key" })
        end,
      })
    end,
  },
}
