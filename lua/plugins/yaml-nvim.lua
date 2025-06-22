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
              -- YAMLファイルからKindを取得
              local function get_kind_from_yaml()
                local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
                for _, line in ipairs(lines) do
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

              -- まずクラスターの接続状態を確認
              vim.notify("Checking Kubernetes cluster connection...", vim.log.levels.INFO)

              local check_cmd = "kubectl cluster-info --request-timeout=5s"
              local check_result = vim.fn.system(check_cmd)
              local check_exit_code = vim.v.shell_error

              if check_exit_code ~= 0 then
                vim.notify("Kubernetes cluster not accessible. Please check your cluster connection and context.", vim.log.levels.ERROR)
                vim.notify("Try: kubectl config current-context", vim.log.levels.INFO)
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
