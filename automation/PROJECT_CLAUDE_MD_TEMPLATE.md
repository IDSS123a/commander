# CLAUDE.md — [PROJECT NAME]
# Commander-Governed Project
# Template version: 1.2 — July 2026
# INSTRUKCIJA: Kopiraj ovaj fajl kao CLAUDE.md u root svakog novog projekta.
# Zamijeni [PROJECT NAME] i [project-repo] stvarnim vrijednostima, obriši ove 3 linije.

---

## GOVERNANCE — READ FIRST, EVERY SESSION

This project is governed by Commander v1.2. Before writing any code,
read documents per M-21 tier rules appropriate to your task:

**TIER 2 (sprints, features, bug fixes) — read these:**

```
https://raw.githubusercontent.com/IDSS123a/commander/main/CONSTITUTION.md
https://raw.githubusercontent.com/IDSS123a/commander/main/ENGINEERING_RULES.md
https://raw.githubusercontent.com/IDSS123a/commander/main/ARCHITECTURE_PATTERNS.md
https://raw.githubusercontent.com/IDSS123a/commander/main/ACA_COMMUNICATION_PROTOCOL.md
https://raw.githubusercontent.com/IDSS123a/commander/main/DONE_CHECKLIST.md
```

Project Constitution (project-specific rules, wins over Commander for this project):
```
https://raw.githubusercontent.com/IDSS123a/[project-repo]/main/CONSTITUTION.md
```

Current sprint:
```
https://raw.githubusercontent.com/IDSS123a/[project-repo]/main/sprints/SPRINT_XX.md
```

---

## AUTOMATIC LESSON CAPTURE — NO PERMISSION NEEDED

**This is a standing order. Execute it automatically. Never ask the
Director whether to do it. Never wait for a reminder.**

### Continuous capture (during work)

The moment ANY of the following happens, immediately append an entry
to `corrections/SPRINT_[current]_LESSONS.md` — in the same turn,
before continuing with the task:

1. The Director corrects something you did (wrong approach, wrong
   assumption, wrong output format, misunderstood intent)
2. You hit an environment gotcha (tooling trap, dependency issue,
   platform quirk, failed command that needed a workaround)
3. You discover a bug caused by violating or overlooking a Commander
   rule
4. You make a 🔄 COURSE CORRECTION
5. You identify an improvement candidate for Commander (a rule that
   is missing, unclear, outdated, or slowed the work)

Entry format (append, never overwrite):

```markdown
### [YYYY-MM-DD HH:MM] — [one-line title]
- **What happened:** [1-2 sentences]
- **Resolution:** [what fixed it]
- **Commander relevance:** [M-XX / E-XX / C-XX / "new rule candidate" / "none"]
```

If `corrections/` folder or the sprint file does not exist yet:
create it silently and continue.

**Why continuous, not end-of-sprint:** session context gets compacted
during long work. A lesson captured immediately survives; a lesson
held in memory until sprint end may be lost. The filesystem is the
memory (M-18).

### End-of-sprint consolidation (automatic)

When a sprint is declared complete (Done Checklist passed), WITHOUT
being asked:

1. Review `corrections/SPRINT_[current]_LESSONS.md` — consolidate
   duplicate entries, sharpen wording
2. Add the three summary sections at the top of the file:
   `## Corrections Applied`, `## Gotchas Discovered`,
   `## Commander Improvement Candidates`
3. Fill in the COMMANDER COMPLIANCE score (from DONE_CHECKLIST.md)
4. Commit the file: `docs: sprint XX lessons learned`
5. State in the handoff note: "Lessons captured: [N] entries in
   corrections/SPRINT_XX_LESSONS.md"

### End-of-project (only step that needs the Director)

When the Director says **KRAJ**, execute M-22 (KRAJ Protocol) from
CONSTITUTION.md exactly. Reference: PROMPT_LIBRARY/kraj.md.
Do NOT push changes to the Commander repository without explicit
approval — M-22 Step 4 (CONFIRM) requires it.

---

## PROJECT-SPECIFIC NOTES

[Add anything specific to this project: stack deviations per M-16,
special institutional rules, environment quirks, deployment target.]

---

*Commander v1.2 — IDSS123a Organisation — Davor Mulalić*

---

## AUTOMATION LAYER (hooks — deterministic)

This project has Commander Automation hooks installed in `.claude/`:

- `hooks/log-change.js` (PostToolUse) — every file edit is automatically
  logged to `corrections/ACTIVITY_LOG.md`. You do not need to do this
  manually; it happens at the system level.
- `hooks/lessons-guard.js` (Stop) — you will be blocked from finishing
  a response if files changed but lessons were not captured. When the
  guard message appears: review ACTIVITY_LOG.md, append lessons (or the
  explicit "No lessons this session" line), then finish.

Treat the guard as an ally, not an obstacle — it exists because session
memory is unreliable and the filesystem is not (M-18).
