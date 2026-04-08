# Claude Code Visible Thinking

## Purpose

This repository documents and automates a practical setup that restores visible thinking summaries in recent Claude Code builds.

It is for humans and LLM agents.

## Claim Boundaries

Always keep these distinctions sharp:

- Safe claim: visible thinking summaries can be restored in supported recent Claude Code builds with the right settings.
- Safe claim: transcript-visible reasoning is available via transcript controls.
- Safe claim: `claude -p --output-format stream-json --verbose ...` can expose `thinking` events when the runtime and model return them.
- Unsafe claim: this repository restores raw full chain-of-thought everywhere.
- Unsafe claim: `verbose: true` alone is the fix.

## Canonical Settings

`~/.claude/settings.json`

```json
{
  "alwaysThinkingEnabled": true,
  "showThinkingSummaries": true,
  "autoUpdatesChannel": "stable"
}
```

Recommended companion values in `~/.claude.json`

```json
{
  "verbose": true,
  "autoUpdates": false
}
```

## Validation Standard

Do not describe a node as fully validated unless all of these are true:

1. `claude --version` is recorded.
2. The three canonical settings are present in `~/.claude/settings.json`.
3. `verbose: true` is present in `~/.claude.json`.
4. `claude -p --output-format stream-json --verbose ...` yields a successful result.
5. An interactive operator confirms visible thinking in chat or transcript.

## Writing Guidance

- Prefer blunt language over hype.
- Call the repository unofficial.
- Prefer "source-available" over "open source" because the license is noncommercial.
- Keep commands copy-pasteable.
- If a behavior is based on reverse engineering or community reports, label it as inference, not official fact.

## Key Controls

- `Ctrl+O`: transcript
- `Ctrl+E`: expanded transcript content
- Optional helper binding `Ctrl+Shift+O`: transcript toggle
- Optional helper binding `Ctrl+Shift+T`: thinking toggle

## Files To Keep In Sync

- `README.md`
- `docs/ARCHITECTURE.md`
- `docs/VALIDATION.md`
- `docs/TROUBLESHOOTING.md`
- `examples/settings.json`
- `examples/claude.json`

If validation results change, update `docs/VALIDATION.md` first, then adjust the README summary.
