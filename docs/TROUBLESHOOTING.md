# Troubleshooting

## I still do not see thinking in chat

Check `~/.claude/settings.json` first:

```json
{
  "alwaysThinkingEnabled": true,
  "showThinkingSummaries": true,
  "autoUpdatesChannel": "stable"
}
```

Then restart `claude` and test again.

## I only see reasoning in transcript

That still counts as the supported lane in some builds.

Use:

- `Ctrl+O` to open transcript
- `Ctrl+E` to expand transcript content

## Print mode does not show `thinking`

Use the full command:

```bash
claude -p --model claude-sonnet-4-6 --output-format stream-json --verbose "ultrathink: compare whether 431 or 437 is composite, use brief reasoning, then answer in one sentence."
```

If that still does not produce a `thinking` block:

- check whether `claude --version` is below the repository's supported floor
- check your model
- check authentication
- check whether a recent Claude Code release changed behavior

## Claude Code is old on this machine

If `claude --version` is below the supported floor in `docs/VALIDATION.md`,
upgrade before treating the verifier output as a repo bug:

```bash
brew upgrade --cask claude-code
```

## Homebrew says the cask is forbidden

Check for:

```bash
rg -n 'HOMEBREW_FORBIDDEN_CASKS' ~/.zshenv ~/.zshrc
```

Remove the lock from the files and unset it in the current shell:

```bash
unset HOMEBREW_FORBIDDEN_CASKS
```

Then retry.

## Stable moved between runs

That is normal.

Use:

```bash
brew info claude-code
```

This repository cares more about behavior validation than a frozen cask version number.

## Claude warns about a huge `CLAUDE.md`

That warning is usually unrelated to visible thinking. It may affect performance, but not the core settings recipe documented here.

## MCP auth warnings appear in the UI

Those can be noisy and unrelated. Validate the thinking path separately before assuming MCP auth issues are the cause.
