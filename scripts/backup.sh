#!/usr/bin/env bash
set -euo pipefail

backup_root="${1:-$HOME/.claude-thinking-backups}"
stamp="$(date +%Y%m%d-%H%M%S)"
dest="$backup_root/$stamp"

mkdir -p "$dest"

[ -f "$HOME/.claude/settings.json" ] && cp "$HOME/.claude/settings.json" "$dest/settings.json.bak"
[ -f "$HOME/.claude.json" ] && cp "$HOME/.claude.json" "$dest/claude.json.bak"
[ -f "$HOME/.claude/keybindings.json" ] && cp "$HOME/.claude/keybindings.json" "$dest/keybindings.json.bak"

if command -v claude >/dev/null 2>&1; then
  version="$(claude --version 2>/dev/null | awk 'NR==1 {print $1}')"
  if [ -n "${version:-}" ] && [ -f "/opt/homebrew/Caskroom/claude-code/$version/claude" ]; then
    cp "/opt/homebrew/Caskroom/claude-code/$version/claude" "$dest/claude-$version.bak"
  fi
fi

printf '%s\n' "$dest"
