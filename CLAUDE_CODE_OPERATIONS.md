# CLAUDE_CODE_OPERATIONS.md — Claude Code Operator's Guide
# Commander — Project Operating System
# Version 1.3 — July 2026
# Applies to: Director's Claude Code sessions on ALL projects

---

> This document is for the DIRECTOR, not the ACA.
> It covers the real Claude Code features, shortcuts, and session
> management practices that make vibe-coding efficient.
>
> Everything here has been verified against the Claude Code CLI.
> Nothing here is a "viral prompt code" — these are documented,
> built-in features that exist in the command registry.

---

## 1. SESSION START — Every Time

Before your first prompt in any session, the ACA needs context.
Use the Commander URL pattern from README.md:

```
Read these documents completely before any code:

Commander Constitution:
https://raw.githubusercontent.com/IDSS123a/commander/main/CONSTITUTION.md

Commander ACA Communication Protocol:
https://raw.githubusercontent.com/IDSS123a/commander/main/ACA_COMMUNICATION_PROTOCOL.md

Project Constitution:
https://raw.githubusercontent.com/IDSS123a/[project-repo]/main/CONSTITUTION.md

Current Sprint:
https://raw.githubusercontent.com/IDSS123a/[project-repo]/main/sprints/SPRINT_XX.md
```

For Claude Code sessions specifically, you can also place a `CLAUDE.md`
file in the project root that references these URLs. Claude Code reads
`CLAUDE.md` automatically at session start.

---

## 2. THE 10 SHORTCUTS THAT MATTER

Ranked by time saved in a typical vibe-coding session.

### Tier 1 — Use Every Session

| Shortcut | What It Does | When You Need It |
|----------|-------------|-----------------|
| `Esc Esc` | Opens rewind menu — restore code, conversation, or both to any previous checkpoint | Claude went down the wrong path and you want to undo, not just stop |
| `/btw` | Ask a side question without polluting the conversation history. Works while Claude is mid-response. | You need a quick answer about the codebase without derailing the current task |
| `Ctrl+C` | Single tap: clean stop. Double tap: immediate halt. | Claude is generating something you don't want |
| `Shift+Tab` | Toggle permission modes (Plan / Auto-accept / Manual) | Switch to auto-accept for a trusted sequence of changes, then back to manual |

### Tier 2 — Use When Needed

| Shortcut | What It Does | When You Need It |
|----------|-------------|-----------------|
| `Ctrl+B` | Background the current task. Claude keeps working, you get the prompt back. | Long-running task — you want to check something else while it runs |
| `Ctrl+G` | Open your system text editor for the prompt. Write a multi-paragraph prompt, save, close — it sends. | Complex prompts that are awkward to type in a single terminal line |
| `Alt+T` | Toggle extended thinking on/off | Complex architecture or debugging that needs deeper reasoning |
| `Ctrl+R` | Reverse search through prompt history (per-directory) | Finding a previous prompt you want to re-run or modify |

### Tier 3 — Good to Know

| Shortcut | What It Does | When You Need It |
|----------|-------------|-----------------|
| `Ctrl+F` (×2) | Kill all background agents (press twice to confirm) | A sub-agent is burning tokens on a runaway loop |
| `Alt+P` | Switch model mid-session (Sonnet ↔ Opus ↔ Haiku) | Need deeper reasoning (Opus) or faster output (Sonnet) for a specific task |

---

## 3. ESSENTIAL SLASH COMMANDS

These are real, built-in CLI commands. Type `/` to see the full list.

### Session Management

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `/compact` | Compress context into a summary to free token space | Proactively before hitting limits — don't wait for auto-compaction |
| `/clear` | Reset conversation history entirely | Starting a completely new task in the same terminal |
| `/resume` | Jump back into a previous session | Terminal crashed, machine rebooted, or you closed by accident |
| `/fork` | Branch conversation into a new session | You want to try an alternative approach without losing the current one |

**Commander practice — context is measured, not felt:** check
`/context` at every phase boundary (feature done, before the next
sprint step); between phases run `/compact` **deliberately, with focus
instructions** (e.g. `/compact keep: current sprint scope, open bugs,
decisions made`). Never let auto-compaction fire at an arbitrary
moment mid-phase — it summarises without your priorities.

### Information

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `/cost` | Show token usage and cost for this session | Budget tracking — check after heavy operations |
| `/diff` | Show recent file changes | Verify what Claude actually changed before committing |
| `/doctor` | Diagnose common configuration issues | Something isn't working and you don't know why |
| `/context` | Visualise context usage as a coloured grid | Understanding how much context window is left |

### Configuration

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `/model` | Switch the active model | `/model opus` for hard problems, `/model sonnet` for speed |
| `/plan` | Enter planning mode (think without executing) | When you want Claude to design before building |
| `/init` | Initialise Claude Code in a project | First time using Claude Code in a project — creates CLAUDE.md |
| `/memory` | Edit CLAUDE.md memory file | Adding project-specific instructions |
| `/vim` | Toggle vim editing mode | If you want vim keybindings in the prompt input |

### Tools & Collaboration

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `/mcp` | Manage MCP server connections | Connecting external tools (Supabase, GitHub, etc.) |
| `/agents` | Manage running sub-agents | Check what's running in the background |
| `/skills` | View available skills | See what custom skills are available in this project |

---

## 4. QUICK INPUT MODES

### `!` — Bash Mode

Type `!` followed by any shell command. It runs immediately and the
output feeds into Claude's context:

```
! git status
! git log --oneline -5
! npm test
! cat src/lib/constants.ts
```

Use this instead of asking Claude to check something — you get the
answer instantly and Claude sees it too.

### `@` — File Reference

Type `@` followed by a file path to explicitly attach a file to
your prompt. Tab completion works:

```
@src/features/auth/login-form.tsx fix the validation error
```

This makes your intent unambiguous — Claude knows exactly which file
you're talking about.

### `\` + Enter — Multiline Prompt

Type `\` at the end of a line, then Enter, to continue on the next
line. Use for 2–3 line prompts. For longer prompts, use `Ctrl+G`.

---

## 5. CLAUDE.md — YOUR PROJECT'S STANDING INSTRUCTIONS

Every project should have a `CLAUDE.md` in the root directory.
Claude Code reads it automatically at session start.

**Recommended structure for Commander-governed projects:**

```markdown
# Project: [Name]

## Commander Governance
This project is governed by Commander v1.0.
Read all Commander documents before any code:
- Constitution: https://raw.githubusercontent.com/IDSS123a/commander/main/CONSTITUTION.md
- Engineering Rules: https://raw.githubusercontent.com/IDSS123a/commander/main/ENGINEERING_RULES.md
- Architecture Patterns: https://raw.githubusercontent.com/IDSS123a/commander/main/ARCHITECTURE_PATTERNS.md
- ACA Communication Protocol: https://raw.githubusercontent.com/IDSS123a/commander/main/ACA_COMMUNICATION_PROTOCOL.md
- Done Checklist: https://raw.githubusercontent.com/IDSS123a/commander/main/DONE_CHECKLIST.md

## Project Constitution
https://raw.githubusercontent.com/IDSS123a/[repo]/main/CONSTITUTION.md

## Current Sprint
https://raw.githubusercontent.com/IDSS123a/[repo]/main/sprints/SPRINT_XX.md

## Project-Specific Notes
[Anything specific to this project that doesn't belong in the Constitution]
```

This eliminates the need to paste URLs at the start of every session.
Claude Code reads it, fetches the documents, and proceeds.

---

## 6. CONTEXT RECOVERY — Resuming a Session

When resuming work (new day, new terminal, or after `/compact`):

```
! git log --oneline -10
! git diff --stat
```

Then tell Claude: "Resume work on [project]. Check git state and
the current sprint, then continue."

Claude will recover context from the codebase, git history,
CLAUDE.md, and any Commander documents referenced.

---

## 7. THE REAL "GOD MODE"

The actual maximum-power Claude Code configuration is not a secret
code. It is a documented CLI flag:

```bash
claude --dangerously-skip-permissions
```

This skips all permission prompts. Claude executes every tool call
without asking. Use with caution — only on projects where you trust
the ACA to make safe changes.

For a less extreme version, use `Shift+Tab` to toggle to auto-accept
mode during a trusted sequence, then toggle back to manual.

---

## 8. CUSTOM COMMANDS

Claude Code lets you create custom slash commands by adding markdown
files to `.claude/commands/` in your project:

```
.claude/
  commands/
    ship.md        → /ship
    test-all.md    → /test-all
    sprint-done.md → /sprint-done
```

### Recommended Commander Custom Commands

**`.claude/commands/ship.md`**
```
Review the current diff against the Done Checklist from Commander.
Run tests. If tests pass, commit with a structured message
(type: description) and push to the current branch.
```

**`.claude/commands/sprint-done.md`**
```
Run the full Done Checklist from:
https://raw.githubusercontent.com/IDSS123a/commander/main/DONE_CHECKLIST.md

Report each item as PASS or FAIL.
For any FAIL item: fix it, then re-check.
After all items pass, write the handoff note.
```

**`.claude/commands/context-check.md`**
```
Run:
  git log --oneline -10
  git diff --stat
  cat package.json | head -20

Report: project name, current branch, recent changes,
and uncommitted work. Then check the current sprint document.
```

---

## 9. WHAT DOES NOT WORK (CONFIRMED)

The following viral "codes" have been tested against Claude Code
CLI with JSON output and cost tracking. None of them exist in the
command registry:

| "Code" | Result | Evidence |
|--------|--------|----------|
| `/ghost` | "Unknown skill: ghost" — zero tokens consumed | CLI intercepts before model, 12ms |
| `/godmode` | "Unknown skill: godmode" — zero tokens consumed | Identical to /ghost |
| `L99` | Treated as text. No behaviour change measured. | Token comparison: 61 vs 90 tokens, normal variance |
| `BEASTMODE` | Treated as text. May increase verbosity. | No structural change in output |
| `/buddha` | "Unknown skill: buddha" — zero tokens consumed | Does not exist |
| `/UDA` | "Unknown skill: UDA" — zero tokens consumed | Does not exist |
| `ULTRATHINK` | Treated as text. May trigger longer reasoning. | Placebo — use `Alt+T` for real extended thinking |
| `OODA` | Model recognises the framework name and may structure output around it. | Works as a prompt instruction, not a command. Commander C-5 does this reliably. |

**The pattern:** If it starts with `/` and isn't a registered command,
Claude Code rejects it before it reaches the model. If it's plain text
(L99, BEASTMODE), the model reads it as confusing context that
sometimes shifts tone — the same result you'd get from writing
"respond like a senior engineer" in plain English.

Commander's ACA Communication Protocol (C-1 through C-11) achieves
the same effects reliably because they are explicit standing
instructions, not vibes.

---

## 10. KEYBINDINGS CUSTOMISATION

If the default shortcuts don't match your muscle memory, Claude Code
supports full keybinding customisation:

```bash
/keybindings
```

This opens `~/.claude/keybindings.json`. Changes apply immediately
without restarting Claude Code.

Popular customisation: make `Ctrl+Enter` submit and `Enter` insert
a newline (useful for multi-line prompts):

```json
{
  "$schema": "https://claude.ai/schemas/keybindings.json",
  "bindings": [
    {
      "context": "Chat",
      "keys": {
        "ctrl+enter": "chat:submit",
        "enter": "input:newline"
      }
    }
  ]
}
```

---

## VERSIONING

```
v1.3  2026-07-23  Added: measured context practice (/context at phase
                  boundaries, deliberate /compact with focus
                  instructions). Note: recurring rituals now ship as
                  skills in automation/.claude/skills/ (/kraj,
                  /sprint-close, /commander-audit) — no need to
                  re-create them as custom commands per project.

v1.0  2026-07-13  Initial Claude Code Operations Guide.
                  Covers: real shortcuts, real slash commands,
                  CLAUDE.md template, custom commands, and
                  confirmed non-working viral codes.
                  Source: Claude Code docs, cheatsheets,
                  leaked source analysis, and independent
                  CLI testing by multiple researchers.
```

---

*Commander v1.3 — IDSS123a Organisation — Davor Mulalić — direktor@idss.ba*
