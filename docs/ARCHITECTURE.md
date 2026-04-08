# Architecture

## Core Idea

This setup is not magic. It is a small configuration lane that makes recent Claude Code builds behave more like an operator-facing tool and less like a black box.

The setup relies on three main settings:

```json
{
  "alwaysThinkingEnabled": true,
  "showThinkingSummaries": true,
  "autoUpdatesChannel": "stable"
}
```

## What Each Setting Does

### `alwaysThinkingEnabled`

Turns thinking on by default, so the user does not need to remember to opt into it every session.

### `showThinkingSummaries`

This is the key interactive setting. In validated recent builds, it restores visible summary rendering in the chat and transcript path instead of leaving thinking fully hidden or reduced to an unusable stub.

### `autoUpdatesChannel`

Pins the updater lane to stable so behavior does not drift toward a newer channel without the operator noticing.

## Recommended Companion Settings

`~/.claude.json`

```json
{
  "verbose": true,
  "autoUpdates": false
}
```

### Why `verbose: true` is included

`verbose` is part of the validated fleet state on the working nodes. It is useful for troubleshooting and aligns with the operator workflow, but it should not be overstated as the single root cause of visible thinking behavior.

## Interactive Controls

- `Ctrl+O`: open transcript
- `Ctrl+E`: expand transcript content

Optional helper bindings:

- `Ctrl+Shift+O`: transcript toggle
- `Ctrl+Shift+T`: thinking toggle

## Print-Mode Verification

The strongest machine-verifiable proof path is:

```bash
claude -p --model claude-sonnet-4-6 --output-format stream-json --verbose "ultrathink: compare whether 431 or 437 is composite, use brief reasoning, then answer in one sentence."
```

In validated working runs, this produces:

- a successful result event
- an assistant message containing a `thinking` content block
- the final assistant text

## Evidence Boundary

Officially documented:

- `alwaysThinkingEnabled`
- `showThinkingSummaries`
- transcript and keybinding controls

Reverse-engineered or community-evidence layer:

- claims about specific beta headers such as `redact-thinking-2026-02-12`
- reports that specific minor versions ignored settings or regressed rendering

This repository keeps those two evidence layers separate on purpose.
