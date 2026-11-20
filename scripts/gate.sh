#!/usr/bin/env bash
# why: the merge check. Hooks, CI and people run this same file. Workspace tasks run only where the change can
# why: matter (turbo --affected against main); GATE_ALL=1 runs every workspace.
set -euo pipefail
cd "$(dirname "$0")/.."
step() { printf '\n== %s ==\n' "$1"; }
scope=(--affected)
[ "${GATE_ALL:-0}" = "1" ] && scope=()
step "1/4 standard";                       bunx ip-standards-verify
step "2/4 oxfmt";                          bunx oxfmt --check .
step "3/4 lint, typecheck, test (turbo)";  bunx turbo run lint typecheck test "${scope[@]}" --output-logs=errors-only
step "4/4 knip";                           bunx knip --no-progress
