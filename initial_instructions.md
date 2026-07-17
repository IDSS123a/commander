# INITIAL INSTRUCTIONS — Commander Project Bootstrap
# Version 1.2 — July 2026
# USAGE: Copy/paste this entire document as the FIRST message in Claude Code
# (or any other ACA) when the Director wants to start a new project.
# That is all. Commander takes over from here.

---

## YOUR ROLE

You are initializing a new web application project governed by the
COMMANDER system. The Director (Davor Mulalić) is a non-coder. He will
answer a few questions — everything else is YOUR job, executed
automatically, without asking for permission at each step.

**Communicate with the Director in Bosnian. All code, documents, and
commits in English (except where Commander specifies BCS).**

---

## STEP 1 — READ THE GOVERNANCE (silently, before anything else)

This is a Tier 3 task (M-21). Fetch and read completely, in this order:

```
1. https://raw.githubusercontent.com/IDSS123a/commander/main/CONSTITUTION.md
2. https://raw.githubusercontent.com/IDSS123a/commander/main/ENGINEERING_RULES.md
3. https://raw.githubusercontent.com/IDSS123a/commander/main/ARCHITECTURE_PATTERNS.md
4. https://raw.githubusercontent.com/IDSS123a/commander/main/ACA_COMMUNICATION_PROTOCOL.md
5. https://raw.githubusercontent.com/IDSS123a/commander/main/FEATURE_LIFECYCLE.md
6. https://raw.githubusercontent.com/IDSS123a/commander/main/DONE_CHECKLIST.md
7. https://raw.githubusercontent.com/IDSS123a/commander/main/DECISION_LOG.md
```

Note: M-21 says DECISION_LOG.md is "NEVER loaded at session start."
Project bootstrap is the explicit exception — the ACA needs prior
technology decisions to scaffold correctly. After bootstrap, revert
to normal M-21 tier rules.

Do not summarize these documents to the Director. Just obey them.

---

## STEP 2 — ASK THE DIRECTOR (the ONLY manual part)

Ask exactly these questions, in Bosnian, all at once, numbered:

1. **Naziv projekta?** (postaje ime foldera i GitHub repo-a: web-app-[naziv])
2. **Projektna ideja?** (2-3 rečenice: šta app radi i za koga)
3. **Režim?** FULL (produkcija, sprintovi) ili QUICK (prototip,
   jedan prolaz — Commander M-20)
4. **Postojeći codebase?** (Ako da: koji stack? Mapira na M-16.
   Ako ne: koristimo Commander default stack — Next.js + Supabase +
   Vercel, per DL-001 through DL-008)
5. **Ključna poslovna pravila?** (sve što ACA ne smije izmisliti
   po M-4: uloge korisnika, jezici, institucionalna ograničenja —
   ili "standardno")

Wait for answers. Then execute Steps 3–5 in one continuous run,
narrating only with brief ✅ status lines.

---

## STEP 3 — SCAFFOLD EVERYTHING (automatic, no permission requests)

Adapt to your environment:
- **Claude Code / filesystem + git available:** execute directly.
- **No filesystem (e.g. web chat):** generate all files as downloadable
  package + ONE setup command for the Director. Do not skip anything.

Execute:

1. Create project folder and `git init` (or use current folder if empty).
2. Create GitHub repo `IDSS123a/web-app-[naziv]` via `gh repo create`
   if gh CLI is authenticated; if not, give the Director ONE line:
   "Kreiraj repo web-app-[naziv] na github.com/IDSS123a i reci mi kad je gotovo."
3. Install Commander Automation — fetch these files from the Commander
   repo into the project:
   ```
   https://raw.githubusercontent.com/IDSS123a/commander/main/automation/.claude/settings.json
     → .claude/settings.json
   https://raw.githubusercontent.com/IDSS123a/commander/main/automation/.claude/hooks/log-change.js
     → .claude/hooks/log-change.js
   https://raw.githubusercontent.com/IDSS123a/commander/main/automation/.claude/hooks/lessons-guard.js
     → .claude/hooks/lessons-guard.js
   ```
   If raw URL fetch fails for `.claude` paths (GitHub may hide dotfiles),
   fall back: download `automation/commander-automation.zip`, extract,
   and copy the `.claude/` folder into the project root.
4. Create `corrections/` folder with empty `ACTIVITY_LOG.md`.
5. Generate `CLAUDE.md` from
   `https://raw.githubusercontent.com/IDSS123a/commander/main/automation/PROJECT_CLAUDE_MD_TEMPLATE.md`
   — fill in [PROJECT NAME] and [project-repo], remove template
   instruction lines, update version references to v1.2.
6. Generate project `CONSTITUTION.md`: project name, idea, business
   rules from the Director's answers. Stack per Commander defaults
   (Next.js + Supabase + Vercel) UNLESS the Director indicated an
   existing codebase in question 4 — in that case, document the
   deviation per M-16 and record it in the project's DECISION_LOG.md.
7. Generate `sprints/SPRINT_01.md`: first sprint scoped to project
   skeleton + core data model + auth (FULL mode). In QUICK mode: skip
   sprints entirely.
8. Initialize the stack per ARCHITECTURE_PATTERNS.md defaults (or the
   documented deviation from Step 6).
9. First commit: `chore: project initialization under Commander v1.2`
   and push.
10. Report: "✅ Projekat [naziv] inicijalizovan. Commander upravlja.
    Počinjemo Sprint 1?" (QUICK mode: "Počinjemo gradnju?")

---

## STEP 4 — STANDING ORDERS FOR THE ENTIRE PROJECT

These run automatically for every session until the project ends.
Never ask the Director whether to do them.

1. **Every session start:** re-read CLAUDE.md and the current sprint
   doc. Load documents per M-21 tier appropriate to the task.
2. **Lesson capture:** the moment a correction, gotcha, course
   correction, or Commander improvement candidate occurs — append it
   to `corrections/SPRINT_XX_LESSONS.md` immediately, same turn
   (format per PROJECT_CLAUDE_MD_TEMPLATE). The hooks enforce this;
   cooperate with the lessons-guard when it blocks you.
3. **When the Director says a sprint is done** (any phrasing):
   automatically run the full DONE_CHECKLIST, fix FAILs, fill
   COMMANDER COMPLIANCE score, consolidate the lessons file, write
   the handoff note, commit and push, and propose SPRINT_XX+1 scope.
4. **All Commander rules apply at all times** — especially M-4
   (never invent business rules), C-8 (complete output always),
   and the communication protocol (C-1 to C-11).

---

## STEP 5 — MAGIC WORD: "KRAJ"

When the Director writes **KRAJ**, execute M-22 (KRAJ Protocol) from
CONSTITUTION.md exactly. For reference:

```
https://raw.githubusercontent.com/IDSS123a/commander/main/PROMPT_LIBRARY/kraj.md
```

The protocol has 5 steps: COLLECT → ANALYSE → PROPOSE → CONFIRM → EXECUTE.

**Critical:** Do NOT commit anything to the Commander repository without
the Director's explicit approval in Step 4 (CONFIRM). Present the
COMMANDER_UPDATE_PROPOSAL.md first and wait.

---

## FAILURE RULES

- If any URL fetch fails: retry once, then tell the Director which
  URL failed and continue with everything else.
- If the environment cannot execute something (no git, no filesystem):
  produce the artifact + ONE command for the Director instead. Never
  silently skip a step.
- Never ask the Director technical questions the codebase, Commander
  docs, or your own judgment can answer (C-6).

---

*Commander v1.2 — IDSS123a Organisation — Davor Mulalić — direktor@idss.ba*
