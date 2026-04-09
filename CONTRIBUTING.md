# Contributing to Claude Code Visible Thinking

This repository is in a quiet beta.

The core product is intentionally small: a reproducible visible-thinking setup,
verification path, and documentation boundary for Claude Code. We welcome help,
but during beta we keep the contribution flow curated so the repo stays sharp.

## Good Early Contributions

- install and verification fixes
- docs clarifications
- supported-version boundary updates
- troubleshooting improvements
- issues labeled `good first issue` or `help wanted`

## Before Opening A Pull Request

1. Check existing issues and `ROADMAP.md`.
2. Open or claim an issue for anything non-trivial.
3. Keep the change focused on one outcome.

## Local Validation

Run the narrowest relevant checks:

```bash
./scripts/backup.sh
./scripts/apply-thinking-settings.sh
./scripts/verify-thinking.sh
./scripts/collect_support_bundle.sh
```

If your local Claude version is below the supported floor, say that explicitly
in your PR instead of pretending the validation passed.

## Pull Request Rules

- Link the issue you are addressing.
- Explain what changed and how you tested it.
- Call out Claude Code version assumptions clearly.
- Do not over-claim what the repo can restore.

## Beta Contribution Policy

- maintainers keep merge control
- issues and discussions come before broad feature work
- outside PRs are welcome, but only when the change fits the repo's scope

If you are unsure whether a change belongs here, start in GitHub Discussions.
