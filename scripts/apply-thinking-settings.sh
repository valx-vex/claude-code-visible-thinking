#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.claude"

python3 <<'PY'
import json
import os
from pathlib import Path

settings_path = Path(os.path.expanduser("~/.claude/settings.json"))
claude_json_path = Path(os.path.expanduser("~/.claude.json"))

def load_json(path: Path):
    if path.exists():
        with path.open() as fh:
            return json.load(fh)
    return {}

settings = load_json(settings_path)
settings["alwaysThinkingEnabled"] = True
settings["showThinkingSummaries"] = True
settings["autoUpdatesChannel"] = "stable"

settings_path.parent.mkdir(parents=True, exist_ok=True)
with settings_path.open("w") as fh:
    json.dump(settings, fh, indent=2, sort_keys=True)
    fh.write("\n")

claude_json = load_json(claude_json_path)
claude_json["verbose"] = True
claude_json["autoUpdates"] = False

with claude_json_path.open("w") as fh:
    json.dump(claude_json, fh, indent=2, sort_keys=True)
    fh.write("\n")

print("Updated:")
print(settings_path)
print(claude_json_path)
PY

echo "Optional keybindings example: examples/keybindings.json"
