#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
OUTPUT_DIR="$PROJECT_ROOT/support-bundles"
TIMESTAMP="$(date -u +%Y%m%dT%H%M%SZ)"
OUTPUT_FILE=""

usage() {
  cat <<'EOF'
Usage: ./scripts/collect_support_bundle.sh [--output-dir PATH]

Collect a sanitized support bundle for Claude Code Visible Thinking.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --output-dir)
      OUTPUT_DIR="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

mkdir -p "$OUTPUT_DIR"
OUTPUT_FILE="$OUTPUT_DIR/support-bundle-$TIMESTAMP.md"

sanitize() {
  sed \
    -e "s|$HOME|~|g" \
    -e 's/gho_[A-Za-z0-9_]\+/gho_[REDACTED]/g'
}

capture() {
  local title="$1"
  shift
  {
    echo "## $title"
    echo
    echo '```text'
    if "$@" 2>&1 | sanitize; then
      :
    else
      echo "[command exited non-zero]"
    fi
    echo '```'
    echo
  } >>"$OUTPUT_FILE"
}

claude_config_snapshot() {
  python3 <<'PY'
import json
import os
for path in [os.path.expanduser("~/.claude/settings.json"), os.path.expanduser("~/.claude.json")]:
    print(f"--- {path}")
    if not os.path.exists(path):
        print("missing")
        continue
    with open(path) as fh:
        data = json.load(fh)
    for key in [
        "alwaysThinkingEnabled",
        "showThinkingSummaries",
        "autoUpdatesChannel",
        "model",
        "verbose",
        "autoUpdates",
    ]:
        if key in data:
            print(f"{key}={data.get(key)}")
PY
}

shell_lock_state() {
  rg -n 'HOMEBREW_FORBIDDEN_CASKS|claude-code' "$HOME/.zshenv" "$HOME/.zshrc" 2>/dev/null || true
}

{
  echo "# Claude Code Visible Thinking Support Bundle"
  echo
  echo "- Generated (UTC): $TIMESTAMP"
  echo "- Repo: $(printf '%s' "$PROJECT_ROOT" | sanitize)"
  echo
} >"$OUTPUT_FILE"

capture "Host" uname -a
capture "Claude Version" claude --version
capture "Claude Config Snapshot" claude_config_snapshot
capture "Shell Lock State" shell_lock_state
capture "Verifier Output" "$PROJECT_ROOT/scripts/verify-thinking.sh"

echo "Wrote support bundle: $OUTPUT_FILE"
