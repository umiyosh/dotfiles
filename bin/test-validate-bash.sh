#!/bin/bash
# Test suite for validate-bash.sh hook
# Usage: bash test-validate-bash.sh

SCRIPT="$(dirname "$0")/validate-bash.sh"
pass=0 fail=0

# expect: "deny" | "ask" | "allow"
check() {
  local desc="$1" cmd="$2" expect="$3" cwd="${4:-/Users/yoshikazu.umino/.claude}"
  result=$(echo "{\"tool_name\":\"Bash\",\"tool_input\":{\"command\":\"$cmd\"},\"cwd\":\"$cwd\"}" | bash "$SCRIPT" 2>&1)
  case "$expect" in
    deny|ask)
      if echo "$result" | grep -q "\"permissionDecision\": \"$expect\""; then
        echo "  ✅ ${expect^^}: $desc"
        ((pass++))
      else
        echo "  ❌ EXPECTED ${expect^^}: $desc"
        ((fail++))
      fi
      ;;
    allow)
      if [[ -z "$result" ]]; then
        echo "  ✅ ALLOW: $desc"
        ((pass++))
      else
        echo "  ❌ EXPECTED ALLOW: $desc"
        ((fail++))
      fi
      ;;
  esac
}

echo "=== deny: terraform apply ==="
check "terraform apply" "terraform apply" "deny"
check "terraform apply -auto-approve" "terraform apply -auto-approve" "deny"
check "terraform plan" "terraform plan" "allow"

echo ""
echo "=== deny: rm -rf ==="
check "rm -rf /" "rm -rf /" "deny"
check "rm -fr /" "rm -fr /" "deny"
check "rm -rf /usr/local/bin" "rm -rf /usr/local/bin" "allow"
check "rm -rf ~/" "rm -rf ~/" "deny"
check "rm -rf ~" "rm -rf ~" "deny"
check "rm -rf ./test" "rm -rf ./test" "allow"

echo ""
echo "=== deny: awk/sed ==="
check "awk" "awk '{print}' file" "deny"
check "sed" "sed 's/a/b/' file" "deny"

echo ""
echo "=== deny: git add -A ==="
check "git add -A" "git add -A" "deny"
check "git add ." "git add ." "deny"
check "git add file.txt" "git add file.txt" "allow"

echo ""
echo "=== deny/allow: git push (umiyosh=allow, other=deny) ==="
check "git push (umiyosh)" "git push origin main" "allow" "/Users/yoshikazu.umino/.claude"
check "git push (non-umiyosh)" "git push origin main" "deny" "/tmp"
check "docker push (not git)" "docker push myimage" "allow" "/tmp"

echo ""
echo "=== deny/allow: gh write (umiyosh=allow, other=deny) ==="
check "gh pr create (umiyosh)" "gh pr create --title t" "allow" "/Users/yoshikazu.umino/.claude"
check "gh issue create (umiyosh)" "gh issue create --title t" "allow" "/Users/yoshikazu.umino/.claude"
check "gh issue comment (umiyosh)" "gh issue comment 1 --body t" "allow" "/Users/yoshikazu.umino/.claude"
check "gh pr merge (umiyosh)" "gh pr merge 1" "allow" "/Users/yoshikazu.umino/.claude"
check "gh pr close (umiyosh)" "gh pr close 1" "allow" "/Users/yoshikazu.umino/.claude"
check "gh pr review (umiyosh)" "gh pr review 1 --approve" "allow" "/Users/yoshikazu.umino/.claude"
check "gh pr create (other)" "gh pr create --title t" "deny" "/tmp"
check "gh issue create (other)" "gh issue create --title t" "deny" "/tmp"
check "gh issue comment (other)" "gh issue comment 1 --body t" "deny" "/tmp"
check "gh pr merge (other)" "gh pr merge 1" "deny" "/tmp"
check "gh pr close (other)" "gh pr close 1" "deny" "/tmp"
check "gh release create (other)" "gh release create v1.0" "deny" "/tmp"
check "gh repo delete (other)" "gh repo delete foo" "deny" "/tmp"

echo ""
echo "=== allow: gh read (always) ==="
check "gh pr list" "gh pr list" "allow" "/tmp"
check "gh pr view" "gh pr view 1" "allow" "/tmp"
check "gh issue list" "gh issue list" "allow" "/tmp"
check "gh issue view" "gh issue view 1" "allow" "/tmp"
check "gh pr diff" "gh pr diff 1" "allow" "/tmp"
check "gh api (read)" "gh api repos/foo/bar" "allow" "/tmp"

echo ""
echo "=== ask: gcloud ==="
check "gcloud compute instances list" "gcloud compute instances list" "ask"
check "gcloud auth login" "gcloud auth login" "ask"
check "gcloud projects list" "gcloud projects list" "ask"
check "kubectl (not gcloud)" "kubectl get pods" "allow"

echo ""
echo "=== Results: $pass passed, $fail failed ==="
[[ "$fail" -eq 0 ]]
