# Claude Code Visible Thinking

[![License: PolyForm NC](https://img.shields.io/badge/License-PolyForm%20NC%201.0.0-blue.svg)](https://polyformproject.org/licenses/noncommercial/1.0.0/)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-2.1.85+-brightgreen.svg)](https://code.claude.com/)
[![macOS](https://img.shields.io/badge/macOS-13+-silver.svg)](https://www.apple.com/macos/)
[![Verified](https://img.shields.io/badge/Verified-M3%20%7C%20M4%20%7C%20PRIME-purple.svg)](docs/VALIDATION.md)

> **Unofficial, source-available setup for restoring visible thinking summaries in recent Claude Code builds.**

No folklore. No magic. Just working configs + verification scripts.

Quiet beta docs:

- current release target: `v0.1.0-beta.1`
- [`docs/releases/v0.1.0-beta.1.md`](docs/releases/v0.1.0-beta.1.md)
- [`SUPPORT.md`](SUPPORT.md)
- [`CONTRIBUTING.md`](CONTRIBUTING.md)
- [`docs/BETA_OPERATIONS.md`](docs/BETA_OPERATIONS.md)

This repository exists because a lot of Claude Code users want the same thing:

- visible thinking in the chat UI
- transcript-visible reasoning when chat view is compact
- a reproducible setup instead of forum folklore

## Beta Status

This repository is in a quiet beta.

- the setup is real
- the validation path is real
- the contribution and support flow is now being formalized

The promise is narrow on purpose: restore visible thinking summaries and
transcript-visible reasoning in supported recent Claude Code builds. Not full
raw chain-of-thought. Not every version forever.

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

## Supported Version Floor

Current documented supported floor: `Claude Code 2.1.85+`.

If you are below that floor, the verifier should fail explicitly and tell you to
upgrade instead of pretending the config alone is enough.

## Validated State

As of April 8, 2026:
As of April 9, 2026:

| Node | Claude Code | Result |
|---|---:|---|
| PRIME / Mac Studio | 2.1.85 | Interactive PASS, transcript PASS, print PASS |
| M4 / VexNet002 | 2.1.85 | Config + version PASS, live interactive validation pending |
| M3 / VexNet003 | 2.1.89 | Print PASS on latest stable, interactive check still recommended |

Stable moved over time during fleet rollout. The repo is written around
behavior, not one frozen cask number, but it does enforce a documented minimum
supported floor.

## Optional Memory Add-On

This repo stays focused on visible thinking.

If you also want persistent local memory, treat that as a separate optional layer:

- MemPalace for verbatim local memory
- Lazarus for semantic resurrection
- VexNet continuity for capture/sync

See `docs/OPTIONAL_MEMORY_STACK.md` for the boundary so visible-thinking setup
does not get muddled with memory-stack rollout.

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

### Collect Support Bundle

```bash
./scripts/collect_support_bundle.sh
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
- `SUPPORT.md`: support and bug-report flow
- `CONTRIBUTING.md`: contribution policy
- `docs/ARCHITECTURE.md`: why the setup works
- `docs/VALIDATION.md`: evidence and version matrix
- `docs/TROUBLESHOOTING.md`: common failure modes
- `examples/`: copyable JSON snippets
- `scripts/`: backup, apply, and verify helpers

## Community And Support

Use the support system intentionally:

- GitHub Issues for setup failures, script bugs, and regressions
- GitHub Discussions for beta feedback, Q&A, and roadmap discussion
- Discord for quick beta conversation, with anything important written back to GitHub

Run the support bundle before opening a bug:

```bash
./scripts/collect_support_bundle.sh
```

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
