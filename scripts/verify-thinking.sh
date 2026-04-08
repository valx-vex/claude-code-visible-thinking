#!/usr/bin/env bash
set -euo pipefail

model="${1:-claude-sonnet-4-6}"
tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

echo "== Version =="
claude --version
echo

echo "== Effective config =="
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
    for key in ["alwaysThinkingEnabled", "showThinkingSummaries", "autoUpdatesChannel", "model", "verbose", "autoUpdates"]:
        if key in data:
            print(f"{key}={data.get(key)}")
PY
echo

echo "== Stream-json proof =="
claude -p --model "$model" --output-format stream-json --verbose \
  'ultrathink: compare whether 431 or 437 is composite, use brief reasoning, then answer in one sentence.' > "$tmp"

if rg -q '"type":"thinking"' "$tmp"; then
  echo "PASS: found thinking block"
else
  echo "FAIL: no thinking block found"
  sed -n '1,120p' "$tmp"
  exit 1
fi

if rg -q '"type":"result".*"subtype":"success"' "$tmp"; then
  echo "PASS: found success result"
else
  echo "FAIL: no success result found"
  sed -n '1,120p' "$tmp"
  exit 1
fi

echo
echo "Manual interactive check still recommended:"
echo "  1. run: claude"
echo "  2. ask: Compare whether 431 or 437 is composite, reason briefly, then answer in one sentence."
echo "  3. check chat, Ctrl+O transcript, and Ctrl+E expansion"
