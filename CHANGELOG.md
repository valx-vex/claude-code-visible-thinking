# Changelog

All notable changes to this project will be documented in this file.

Format based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

---

## [v0.1.0-beta.1] - 2026-04-09

### Added

- Quiet beta release packaging
- Visible thinking settings recipe for Claude Code 2.1.85+
- Backup script (`scripts/backup.sh`)
- Apply settings script (`scripts/apply-thinking-settings.sh`)
- Verification script (`scripts/verify-thinking.sh`)
- Support bundle (`scripts/collect_support_bundle.sh`)
- Architecture documentation (`docs/ARCHITECTURE.md`)
- Validation matrix (`docs/VALIDATION.md`)
- Troubleshooting guide (`docs/TROUBLESHOOTING.md`)
- Optional memory stack boundary doc (`docs/OPTIONAL_MEMORY_STACK.md`)
- Demo recording script (`docs/DEMO.md`)
- Beta operations documentation (`docs/BETA_OPERATIONS.md`)
- Maintainer playbook (`docs/MAINTAINER_PLAYBOOK.md`)
- Contribution, support, security, and roadmap docs
- GitHub issue templates, discussion templates, and PR template
- CI workflow for repo-surface checks
- AGENTS.md for LLM/operator guidance
- DISCLAIMER.md for scope and safety boundaries

### Validated On

| Node | Claude Code | Status |
|------|-------------|--------|
| Node 1 (Desktop) | 2.1.85 | ✅ PASS (interactive, transcript, print) |
| Node 2 (Laptop) | 2.1.85 | ✅ PASS (config + version) |
| Node 3 (Laptop) | 2.1.89 | ✅ PASS (print on latest stable) |

### Known Limitations

- Summarized thinking only (Claude 4+ behavior), not full raw chain-of-thought
- Transcript rendering may vary across Claude Code releases
- Unofficial repository, not affiliated with Anthropic
- Interactive validation is still recommended even when print-mode proof passes

### License

PolyForm Noncommercial 1.0.0 - personal/community use allowed, commercial use requires permission

---

## [Unreleased]

### Planned

- Automated CI verification (macOS runners)
- Homebrew tap for one-line installation
- Windows + Linux validation
- Auto-update detection when Claude Code changes thinking behavior
