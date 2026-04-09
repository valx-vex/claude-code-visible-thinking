# Validation

## Supported Version Floor

Current documented supported floor: `Claude Code 2.1.85+`.

If a machine is below that floor, the verifier should report an unsupported
version state. That is not the same thing as a supported-version regression.

## Validation Matrix

| Date | Node | Claude Code | Status | Notes |
|---|---|---:|---|---|
| 2026-04-07 | PRIME / Mac Studio | 2.1.85 | PASS | Interactive thinking visible, transcript PASS, print PASS |
| 2026-04-07 | M4 / VexNet002 | 2.1.85 | PARTIAL | Config and version validated, interactive runtime pending |
| 2026-04-08 | M3 / VexNet003 | 2.1.87 | PASS | Upgraded from 2.1.39, print PASS, user interactive PASS |
| 2026-04-09 | M3 / VexNet003 | 2.1.89 | PASS | Upgraded to latest stable, print-mode proof PASS |

## PRIME

Validated on April 7, 2026.

Confirmed:

- `alwaysThinkingEnabled: true`
- `showThinkingSummaries: true`
- `autoUpdatesChannel: "stable"`
- `verbose: true`
- `claude -p --output-format stream-json --verbose ...` returned visible thinking content
- interactive Claude showed visible reasoning and transcript controls worked

Reference source:

- `../valxos-helpers/valxos-legion-bridge/docs/PRIME_CLAUDE_THINKING_VALIDATION_2026-04-07.md` in the cathedral workspace

## M4

Validated on April 7 and rechecked live on April 8, 2026.

Confirmed:

- Claude Code version `2.1.85`
- `alwaysThinkingEnabled: true`
- `showThinkingSummaries: true`
- `autoUpdatesChannel: "stable"`
- `verbose: true`

Not yet fully confirmed in this repo:

- live interactive visible-thinking pass on April 8

Reference source:

- `../valxos-helpers/valxos-legion-bridge/docs/M4_CLAUDE_THINKING_SETUP_2026-04-07.md` in the cathedral workspace

## M3

Validated on April 8, 2026.

Starting state:

- Claude Code `2.1.39`
- only shell-level Homebrew lock was active
- missing `alwaysThinkingEnabled`, `showThinkingSummaries`, and `autoUpdatesChannel`

Actions:

- backed up config and binary
- removed shell lock from `~/.zshenv` and `~/.zshrc`
- upgraded via Homebrew to `2.1.87`
- merged canonical thinking settings

Confirmed after upgrade:

- `claude --version` -> `2.1.87`
- `claude -p --model claude-sonnet-4-6 --output-format stream-json --verbose ...` returned an assistant `thinking` block
- operator reported interactive thinking works flawlessly

Current note:

- M3 was observed back on `2.1.39` during packaging review
- it was upgraded the same day to `2.1.89`
- latest-stable print-mode proof now passes again on M3

## Validation Policy

The repository only calls a configuration "PASS" when at least one of these is true:

- machine-verifiable print-mode proof exists, and
- a human operator confirms the interactive path

If only config and version checks exist, the node remains `PARTIAL`.

If the installed Claude Code version is below the supported floor, the node is
`OUT OF POLICY` until upgraded.
