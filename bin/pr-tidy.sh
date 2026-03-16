#!/usr/bin/env bash
# DELETE /notifications/threads/{id} には notifications スコープが必要。
# repo スコープだけでは 204 が返るが実際には Done にならない。
# 事前に: gh auth refresh -s notifications
#
# GitHub API の制限: all=true は Done 済みも返すが、Done を除外するパラメータは存在しない。
# (https://github.com/orgs/community/discussions/15669)
# そのため処理済みIDをローカルに記録し、重複処理を回避する。
#
# cron: 0 4 * * * /Users/yoshikazu.umino/dotfiles/bin/pr-tidy.sh >> /tmp/pr-tidy.log 2>&1
set -euo pipefail
export PATH="/opt/homebrew/bin:$PATH"

# crontab では go-keyring 経由の認証が効かないため GH_TOKEN を明示設定
# fallback: Keychain → トークンファイル
# セットアップ: gh auth token > ~/.config/gh/pr-tidy-token && chmod 600 ~/.config/gh/pr-tidy-token
if [[ -z "${GH_TOKEN:-}" ]]; then
  raw=$(security find-generic-password -s "gh:github.com" -w 2>/dev/null) && \
    GH_TOKEN=$(echo "$raw" | sed 's/^go-keyring-base64://' | base64 -d) || true
fi
if [[ -z "${GH_TOKEN:-}" ]]; then
  token_file="${XDG_CONFIG_HOME:-$HOME/.config}/gh/pr-tidy-token"
  if [[ -f "$token_file" ]]; then
    GH_TOKEN=$(<"$token_file")
  else
    echo "ERROR: gh auth unavailable. Run: gh auth token > $token_file && chmod 600 $token_file" >&2
    exit 1
  fi
fi
export GH_TOKEN

# pre-flight: 認証確認
# gh auth status は keyring の default アカウント失敗で exit 1 になるため API で確認
gh api user --jq '.login' >/dev/null 2>&1 || { echo "ERROR: gh auth failed" >&2; exit 1; }

DONE_IDS="${XDG_CACHE_HOME:-$HOME/.cache}/pr-tidy-done.txt"
mkdir -p "$(dirname "$DONE_IDS")"
touch "$DONE_IDS"

# since(2週間)より古いエントリを削除（肥大化防止）
# 形式: tid updated_at (ISO 8601) — 文字列比較で日付フィルタ可能
tmpfile=$(mktemp)
cutoff="$(date -u -v-14d +%Y-%m-%dT00:00:00Z)"
awk -v cutoff="$cutoff" '$2 >= cutoff' "$DONE_IDS" > "$tmpfile"
mv "$tmpfile" "$DONE_IDS"

mark_done() {
  local tid=$1 reason=$2 updated_at=$3
  echo "DONE ($reason): thread=$tid"
  gh api --method DELETE "/notifications/threads/$tid" >/dev/null
  # 既存エントリを除去してから追記（updated_at 更新）
  grep -v "^$tid " "$DONE_IDS" > "$DONE_IDS.tmp" || true
  mv "$DONE_IDS.tmp" "$DONE_IDS"
  echo "$tid $updated_at" >> "$DONE_IDS"
}

since=$(date -u -v-14d +%Y-%m-%dT%H:%M:%SZ)
gh api "notifications?all=true&since=$since" --paginate \
  | jq -r '.[] | select(.subject.type=="PullRequest") | @base64' \
  | while read -r row; do
      obj="$(echo "$row" | base64 --decode)"
      tid="$(echo "$obj" | jq -r '.id')"
      pr_url="$(echo "$obj" | jq -r '.subject.url')"
      updated_at="$(echo "$obj" | jq -r '.updated_at')"

      # 処理済み かつ updated_at 変化なし → スキップ
      # updated_at が変わっていれば再アクティベーションされたので再処理
      cached_ts=$(grep "^$tid " "$DONE_IDS" | awk '{print $2}' || true)
      if [[ -n "$cached_ts" && "$cached_ts" == "$updated_at" ]]; then
        continue
      fi

      # PR情報取得失敗（削除済み等） → Done
      pr_info="$(gh api "$pr_url" --jq '{state: .state, merged_at: (.merged_at // "")}'  2>/dev/null)" || {
        mark_done "$tid" "deleted" "$updated_at"
        continue
      }
      state="$(echo "$pr_info" | jq -r '.state')"
      merged_at="$(echo "$pr_info" | jq -r '.merged_at')"

      # マージ済み or クローズ済み → Done
      if [[ "$state" == "closed" ]]; then
        [[ -n "$merged_at" ]] && mark_done "$tid" "merged" "$updated_at" || mark_done "$tid" "closed" "$updated_at"
        continue
      fi

      # オープンPRで誰かがapprove済み → Done
      approved="$(gh api "${pr_url}/reviews" --jq '[.[] | select(.state=="APPROVED")] | length' 2>/dev/null)" || approved=0
      if [[ "$approved" -gt 0 ]]; then
        mark_done "$tid" "approved" "$updated_at"
        continue
      fi

      echo "SKIP: thread=$tid state=$state"
    done
