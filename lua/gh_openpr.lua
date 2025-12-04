-- gh_openpr.lua
-- 現在行のgit blameからコミットハッシュを取得し、gh openprでPRを開く

local M = {}

local function notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO, { title = "gh-openpr" })
end

local function get_repo_root(file_dir)
  local result = vim.fn.systemlist({ "git", "-C", file_dir, "rev-parse", "--show-toplevel" })
  if vim.v.shell_error ~= 0 or #result == 0 then
    return nil
  end
  return result[1]
end

local function get_blame_sha(repo_root, relative_path, line_num)
  local result = vim.fn.systemlist({
    "git", "-C", repo_root,
    "blame", "-L", line_num .. ",+1", "--porcelain", "--", relative_path
  })
  if vim.v.shell_error ~= 0 or #result == 0 then
    return nil
  end
  -- porcelain形式の1行目: <sha> <orig_line> <final_line> [<num_lines>]
  local sha = result[1]:match("^(%x+)")
  return sha
end

function M.open_pr_from_current_line()
  -- ghコマンドの存在確認
  if vim.fn.executable("gh") ~= 1 then
    notify("gh command not found", vim.log.levels.ERROR)
    return
  end

  -- gitコマンドの存在確認
  if vim.fn.executable("git") ~= 1 then
    notify("git command not found", vim.log.levels.ERROR)
    return
  end

  local file_path = vim.fn.expand("%:p")
  if file_path == "" then
    notify("No file in current buffer", vim.log.levels.WARN)
    return
  end

  local file_dir = vim.fn.fnamemodify(file_path, ":h")
  local repo_root = get_repo_root(file_dir)
  if not repo_root then
    notify("Not a git repository", vim.log.levels.WARN)
    return
  end

  -- リポジトリルートからの相対パス
  local relative_path = file_path:sub(#repo_root + 2)
  local line_num = vim.fn.line(".")

  local sha = get_blame_sha(repo_root, relative_path, line_num)
  if not sha then
    notify("Failed to get blame info", vim.log.levels.ERROR)
    return
  end

  -- 未コミット行のチェック (0000000...)
  if sha:match("^0+$") then
    notify("Uncommitted line", vim.log.levels.INFO)
    return
  end

  local job_id = vim.fn.jobstart({ "gh", "openpr", sha }, {
    detach = true,
    cwd = repo_root,
  })

  if job_id <= 0 then
    notify("Failed to start gh openpr", vim.log.levels.ERROR)
  end
end

return M
