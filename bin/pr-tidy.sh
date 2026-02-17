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

DONE_IDS="${XDG_CACHE_HOME:-$HOME/.cache}/pr-tidy-done.txt"
mkdir -p "$(dirname "$DONE_IDS")"
touch "$DONE_IDS"

# since(2週間)より古いエントリを削除（肥大化防止）
tmpfile=$(mktemp)
awk -v cutoff="$(date -u -v-14d +%Y-%m-%d)" '$2 >= cutoff' "$DONE_IDS" > "$tmpfile"
mv "$tmpfile" "$DONE_IDS"

mark_done() {
  local tid=$1 reason=$2
  echo "DONE ($reason): thread=$tid"
  gh api --method DELETE "/notifications/threads/$tid" >/dev/null
  echo "$tid $(date -u +%Y-%m-%d)" >> "$DONE_IDS"
}

since=$(date -u -v-14d +%Y-%m-%dT%H:%M:%SZ)
gh api "notifications?all=true&since=$since" --paginate \
  | jq -r '.[] | select(.subject.type=="PullRequest") | @base64' \
  | while read -r row; do
      obj="$(echo "$row" | base64 --decode)"
      tid="$(echo "$obj" | jq -r '.id')"
      pr_url="$(echo "$obj" | jq -r '.subject.url')"

      # 処理済みスキップ
      if grep -q "^$tid " "$DONE_IDS"; then
        continue
      fi

      # PR情報取得失敗（削除済み等） → Done
      pr_info="$(gh api "$pr_url" --jq '{state: .state, merged_at: (.merged_at // "")}'  2>/dev/null)" || {
        mark_done "$tid" "deleted"
        continue
      }
      state="$(echo "$pr_info" | jq -r '.state')"
      merged_at="$(echo "$pr_info" | jq -r '.merged_at')"

      # マージ済み or クローズ済み → Done
      if [[ "$state" == "closed" ]]; then
        [[ -n "$merged_at" ]] && mark_done "$tid" "merged" || mark_done "$tid" "closed"
        continue
      fi

      # オープンPRで誰かがapprove済み → Done
      approved="$(gh api "${pr_url}/reviews" --jq '[.[] | select(.state=="APPROVED")] | length' 2>/dev/null)" || approved=0
      if [[ "$approved" -gt 0 ]]; then
        mark_done "$tid" "approved"
        continue
      fi

      echo "SKIP: thread=$tid state=$state"
    done
