# Demo Script

**Purpose**: Record a 60-second demo GIF for the README

## Pre-Recording Setup

1. Open Terminal (fresh window, clean prompt)
2. Open Claude Code in another window
3. Ensure thinking settings are applied

## Recording Sequence (60 seconds total)

### Shot 1: Before (10 sec)
```bash
# Show settings BEFORE
cat ~/.claude/settings.json | grep -A2 thinking
```

**Expected**: `alwaysThinkingEnabled` and `showThinkingSummaries` not present or false

---

### Shot 2: Apply Settings (15 sec)
```bash
# Apply the settings
./scripts/apply-thinking-settings.sh

# Confirm applied
cat ~/.claude/settings.json | grep -A2 thinking
```

**Expected**: Settings now visible

---

### Shot 3: Test Query (20 sec)
```bash
claude "Think briefly about why 31 is prime and answer in one sentence."
```

**Expected**:
- Thinking scaffold visible in chat
- "Thinking..." section appears before answer

---

### Shot 4: Transcript Toggle (15 sec)
```bash
# Press Ctrl+O to open transcript
# Press Ctrl+E to expand content
```

**Expected**: Transcript panel opens, shows thinking events

---

## Recording Command

```bash
# Start asciinema recording
asciinema rec --title "Claude Code Visible Thinking Demo" demo.cast

# Run the sequence above

# Stop recording (Ctrl+D)

# Convert to GIF
asciinema player demo.cast --export-gif demo.gif
```

## Alternative: Manual Screen Recording

1. Open QuickTime Player
2. File → New Screen Recording
3. Select terminal region
4. Record the sequence
5. Export as GIF via Preview or online converter

## Target GIF Specs

- **Duration**: 60 seconds max
- **Resolution**: 1280x720 (or terminal native)
- **File size**: Under 5MB (for GitHub)
- **Content**: Settings → Apply → Test → Transcript

## Placement

Add to README.md after badges:

```markdown
![Demo](docs/demo.gif)
```
