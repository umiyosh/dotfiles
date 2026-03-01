#!/bin/bash
# Validate specific Bash commands usage

# Read JSON input from stdin
input=$(cat)

tool_name=$(echo "$input" | jq -r '.tool_name // ""')
command=$(echo "$input" | jq -r '.tool_input.command // ""')

# Only validate Bash tool
if [[ "$tool_name" != "Bash" ]]; then
  exit 0
fi

# deny: complete block
deny() {
  jq -n --arg reason "$1" '{
    "hookSpecificOutput": {
      "hookEventName": "PreToolUse",
      "permissionDecision": "deny",
      "permissionDecisionReason": $reason
    }
  }'
  exit 0
}

# ask: require human approval prompt
ask() {
  jq -n --arg reason "$1" '{
    "hookSpecificOutput": {
      "hookEventName": "PreToolUse",
      "permissionDecision": "ask",
      "permissionDecisionReason": $reason
    }
  }'
  exit 0
}

# Check for forbidden commands
# Use word boundary matching to avoid false positives (e.g., "category" matching "cat")
if echo "$command" | grep -qE '\bawk\b'; then
  deny "Use of 'awk' is prohibited. Use 'perl' instead. Example: perl -lane 'print \$F[0]' file.txt"
fi

if echo "$command" | grep -qE '\bsed\b'; then
  deny "Use of 'sed' is prohibited. Use 'perl' instead. Example: perl -pi -e 's/old/new/g' file.txt"
fi

# --- umiyosh repos only ---

# Helper: check if cwd is an umiyosh repo
is_umiyosh_repo() {
  local cwd
  cwd=$(echo "$input" | jq -r '.cwd // ""')
  local remote
  remote=$(git -C "$cwd" remote get-url origin 2>/dev/null || true)
  echo "$remote" | grep -qE 'github\.com[:/]umiyosh/'
}

# Bash(git push:*)
if echo "$command" | grep -qE '\bgit\s+push\b'; then
  if ! is_umiyosh_repo; then
    deny "'git push' is allowed only for umiyosh repositories."
  fi
fi

# gh write commands (create/close/comment/edit/delete/merge/review)
if echo "$command" | grep -qE '\bgh\s+(pr|issue|release|repo)\s+(create|close|comment|edit|delete|merge|review)\b'; then
  if ! is_umiyosh_repo; then
    deny "'gh' write commands are allowed only for umiyosh repositories."
  fi
fi

if echo "$command" | grep -qE '\bgit add (-A|--all|\.($|[ ;|&]))'; then
  deny "Do not git-add all files. Specify the file name(s) to add."
fi

# --- settings.json deny list entries ---

# Bash(terraform apply:*)
if echo "$command" | grep -qE '\bterraform\s+apply\b'; then
  deny "'terraform apply' is prohibited. Ask the user to execute it."
fi

# Bash(rm:-rf /)
if echo "$command" | grep -qE '\brm\s+(-\w*r\w*f|-\w*f\w*r)\s+/([ ;|&]|$)'; then
  deny "'rm -rf /' is prohibited."
fi
# Bash(rm:-rf ~/)
if echo "$command" | grep -qE '\brm\s+(-\w*r\w*f|-\w*f\w*r)\s+~'; then
  deny "'rm -rf ~/' is prohibited."
fi

# --- commands requiring human approval (ask) ---

if echo "$command" | grep -qE '\bgcloud\b'; then
  ask "'gcloud' requires human approval."
fi

exit 0
