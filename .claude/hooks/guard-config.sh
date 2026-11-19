#!/usr/bin/env bash
# why: Claude Code PreToolUse hook. Agents fix the code, never the rules: edits to lint, format, compiler,
# why: workspace, hook or CI settings are refused. A person changes these, or the standards package does.
set -uo pipefail
file=$(node -e 'let s="";process.stdin.on("data",d=>s+=d).on("end",()=>{const i=JSON.parse(s).tool_input??{};process.stdout.write(i.file_path??i.notebook_path??"")})')
rel=${file#"${CLAUDE_PROJECT_DIR:-$PWD}/"}
case "$rel" in
  .oxlintrc.json|*/.oxlintrc.json|.oxfmtrc.json|tsconfig.json|*/tsconfig.json|package.json|*/package.json|turbo.json|knip.json|lefthook.yml|scripts/gate.sh|.claude/*|.github/*)
    printf 'Blocked: %s is part of the enforced standard. Change the code to satisfy the rule instead. If the rule is wrong, or you need a new dependency or workspace, stop and ask Jose.\n' "$rel" >&2
    exit 2 ;;
esac
