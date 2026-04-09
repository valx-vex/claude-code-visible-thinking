# Support

## Where To Go

Use GitHub Issues for:

- install failures
- verification failures
- script bugs
- regressions tied to Claude Code version changes

Use GitHub Discussions for:

- beta feedback
- usage questions
- roadmap or design discussion

Use Discord for:

- quick back-and-forth during beta
- onboarding help
- lightweight discussion before something becomes a tracked issue

Discord is for conversation. GitHub is where the project remembers.

## Before Filing A Bug

Run:

```bash
./scripts/collect_support_bundle.sh
```

Attach the generated Markdown file or paste the relevant sections into your
issue.

## Supported In Beta

This repo actively supports:

- recent stable Claude Code builds
- local config changes in `~/.claude/settings.json` and `~/.claude.json`
- print-mode verification of `thinking` events
- interactive transcript-visible reasoning checks

This repo does not promise:

- raw full chain-of-thought
- support for every old Claude Code version
- support for every plugin or enterprise-managed environment
