# Maintainer Playbook

## Core Rule

Discord is for conversation. GitHub is where the project remembers.

If a Discord thread reveals a reproducible bug, a real feature request, or a
stable project decision, move it into GitHub.

## Triage Loop

1. Ask for the support bundle.
2. Check the Claude Code version first.
3. Classify the report:
   - install
   - bug
   - docs
   - enhancement
   - blocked external
4. If the report lacks machine truth, label it `needs-repro`.
5. If the problem is an unsupported version, say that directly and route the
   user to the documented version floor.

## Label Rules

- `beta` for quiet-beta feedback
- `install` for setup failures
- `bug` for confirmed defects
- `docs` for documentation fixes
- `enhancement` for scoped improvements
- `needs-repro` when a support bundle or concrete reproduction is missing
- `blocked-external` when Anthropic or environment policy is the real blocker

## Response Style

- be short
- be concrete
- do not overstate what the repo can do
- fix the operator path, not just the prose
