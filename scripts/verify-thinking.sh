#!/usr/bin/env bash
set -euo pipefail

model="${1:-claude-sonnet-4-6}"
tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT
supported_floor="2.1.85"
verify_timeout="${CLAUDE_VERIFY_TIMEOUT:-45}"

version_ge() {
  python3 - "$1" "$2" <<'PY'
import sys

def normalize(version: str):
    return [int(part) for part in version.strip().split(".") if part.strip()]

left = normalize(sys.argv[1])
right = normalize(sys.argv[2])
width = max(len(left), len(right))
left += [0] * (width - len(left))
right += [0] * (width - len(right))
print("1" if left >= right else "0")
PY
}

claude_version_raw="$(claude --version | awk 'NR==1 {print $1}')"

echo "== Version =="
claude --version
echo

if [[ "$(version_ge "$claude_version_raw" "$supported_floor")" != "1" ]]; then
  echo "FAIL: unsupported Claude Code version"
  echo "Installed: $claude_version_raw"
  echo "Supported floor: $supported_floor"
  echo "Upgrade path: brew upgrade --cask claude-code"
  exit 1
fi

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
python3 - "$tmp" "$model" "$verify_timeout" <<'PY'
import subprocess
import sys

out_path, model_name, timeout_seconds = sys.argv[1], sys.argv[2], int(sys.argv[3])
cmd = [
    "claude",
    "-p",
    "--model",
    model_name,
    "--output-format",
    "stream-json",
    "--verbose",
    "ultrathink: compare whether 431 or 437 is composite, use brief reasoning, then answer in one sentence.",
]

with open(out_path, "w", encoding="utf-8") as out_fh:
    try:
        completed = subprocess.run(
            cmd,
            stdout=out_fh,
            stderr=subprocess.PIPE,
            text=True,
            timeout=timeout_seconds,
            check=False,
        )
    except subprocess.TimeoutExpired as exc:
        if exc.stdout:
            out_fh.write(exc.stdout)
        print(f"FAIL: Claude verification timed out after {timeout_seconds}s", file=sys.stderr)
        if exc.stderr:
            print(exc.stderr[:2000], file=sys.stderr)
        raise SystemExit(124)

if completed.returncode != 0:
    print(f"FAIL: Claude exited with status {completed.returncode}", file=sys.stderr)
    if completed.stderr:
        print(completed.stderr[:2000], file=sys.stderr)
    raise SystemExit(completed.returncode)
PY

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
echo "PASS: version $claude_version_raw meets supported floor $supported_floor"
echo
echo "Manual interactive check still recommended:"
echo "  1. run: claude"
echo "  2. ask: Compare whether 431 or 437 is composite, reason briefly, then answer in one sentence."
echo "  3. check chat, Ctrl+O transcript, and Ctrl+E expansion"
