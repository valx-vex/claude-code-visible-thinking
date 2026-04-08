# Claude Code Visible Thinking

Unofficial, source-available setup for restoring visible thinking summaries in recent Claude Code builds without pretending you can force raw full chain-of-thought back into existence.

This repository exists because a lot of Claude Code users want the same thing:

- visible thinking in the chat UI
- transcript-visible reasoning when chat view is compact
- a reproducible setup instead of forum folklore

## What This Repository Gives You

- a known-good settings recipe
- merge-safe helper scripts
- a verification path for both `claude -p` and interactive use
- evidence from real fleet validation on multiple Macs
- caveats spelled out clearly instead of hidden in marketing fog

## The Short Version

Add these values to `~/.claude/settings.json`:

```json
{
  "alwaysThinkingEnabled": true,
  "showThinkingSummaries": true,
  "autoUpdatesChannel": "stable"
}
```

Recommended companion values in `~/.claude.json`:

```json
{
  "verbose": true,
  "autoUpdates": false
}
```

Optional keybindings:

```json
{
  "bindings": [
    {
      "context": "Global",
      "bindings": {
        "ctrl+shift+o": "app:toggleTranscript"
      }
    },
    {
      "context": "Chat",
      "bindings": {
        "ctrl+shift+t": "chat:thinkingToggle"
      }
    }
  ]
}
```

## What You Should Expect

- Visible thinking summaries in recent Claude Code builds.
- Transcript-visible reasoning via `Ctrl+O`.
- Expanded transcript content via `Ctrl+E`.
- Structured `thinking` events in `claude -p --output-format stream-json --verbose ...`.

## What You Should Not Promise

- Not guaranteed raw full internal thought.
- Not guaranteed identical rendering across every Claude Code release.
- Not an official Anthropic repository.

Claude 4 era behavior is summarized thinking, not old Sonnet 3.7-style full reasoning dumps.

## Validated State

As of April 8, 2026:

| Node | Claude Code | Result |
|---|---:|---|
| PRIME / Mac Studio | 2.1.85 | Interactive PASS, transcript PASS, print PASS |
| M4 / VexNet002 | 2.1.85 | Config + version PASS, live interactive validation pending |
| M3 / VexNet003 | 2.1.87 | Print PASS, user interactive PASS |

Stable moved from `2.1.85` to `2.1.87` during M3 rollout. The repo is written around behavior, not one frozen cask number.

## Quick Start

1. Back up your current Claude config.
2. Apply the thinking settings.
3. Run the verification script.
4. Perform one manual interactive check.

### Backup

```bash
./scripts/backup.sh
```

### Apply

```bash
./scripts/apply-thinking-settings.sh
```

### Verify

```bash
./scripts/verify-thinking.sh
```

### Manual Interactive Check

```bash
claude
```

Then ask:

```text
Think briefly about why 31 is prime and answer in one sentence.
```

Then check:

- thinking scaffold visible in chat
- `Ctrl+O` opens transcript
- `Ctrl+E` expands transcript content

## Repository Layout

- `README.md`: human-first quickstart
- `AGENTS.md`: LLM/operator guidance and claim boundaries
- `DISCLAIMER.md`: scope and safety boundaries
- `docs/ARCHITECTURE.md`: why the setup works
- `docs/VALIDATION.md`: evidence and version matrix
- `docs/TROUBLESHOOTING.md`: common failure modes
- `examples/`: copyable JSON snippets
- `scripts/`: backup, apply, and verify helpers

## License

This repository is source-available under PolyForm Noncommercial 1.0.0, not OSI open source.

- Noncommercial personal and community use: allowed
- Forking and modification: allowed
- Commercial use: not allowed without separate permission

See [LICENSE](LICENSE) and [DISCLAIMER.md](DISCLAIMER.md).

## Sources

- [Claude Code keybindings](https://code.claude.com/docs/en/keybindings)
- [Claude 4 adaptive thinking](https://platform.claude.com/docs/en/build-with-claude/adaptive-thinking)
- [Homebrew claude-code cask](https://github.com/Homebrew/homebrew-cask/blob/HEAD/Casks/c/claude-code.rb)
- [PolyForm Noncommercial 1.0.0](https://polyformproject.org/licenses/noncommercial/1.0.0/)
