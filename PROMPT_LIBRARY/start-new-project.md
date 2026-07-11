# PROMPT: Start a New Project Under Commander
# Use this once, at the very first message of a brand-new project —
# before any code exists, or when adopting an existing codebase into
# Commander governance for the first time.

---

## Instructions for ACA

You are about to work on a new project under the IDSS123a organisation.
Before writing a single line of code, or even discussing implementation,
you must read and internalise the Commander Project Operating System.

**Step 1 — Read Commander completely, in this order:**

```
1. https://raw.githubusercontent.com/IDSS123a/commander/main/CONSTITUTION.md
2. https://raw.githubusercontent.com/IDSS123a/commander/main/ENGINEERING_RULES.md
3. https://raw.githubusercontent.com/IDSS123a/commander/main/ARCHITECTURE_PATTERNS.md
4. https://raw.githubusercontent.com/IDSS123a/commander/main/FEATURE_LIFECYCLE.md
5. https://raw.githubusercontent.com/IDSS123a/commander/main/DONE_CHECKLIST.md
6. https://raw.githubusercontent.com/IDSS123a/commander/main/DECISION_LOG.md
```

Confirm you have read all six before proceeding. Commander governs
mindset, engineering standards, architecture, the feature build
process, the definition of "done", and prior technology decisions —
in that order of precedence over anything not explicitly stated below.

**Step 2 — Read the project's own repository, if one already exists:**

```
Project Constitution:
https://raw.githubusercontent.com/IDSS123a/[project-repo]/main/CONSTITUTION.md

Project Decision Log:
https://raw.githubusercontent.com/IDSS123a/[project-repo]/main/DECISION_LOG.md

Current Sprint:
https://raw.githubusercontent.com/IDSS123a/[project-repo]/main/sprints/SPRINT_XX.md
```

If no repository exists yet, skip this step — you are about to help
create the project Constitution in Step 4.

---

## Project Brief

**Project name:** [NAME]

**Institution(s) this serves:** [e.g. IDSS Sarajevo / IMH Sarajevo / both]

**One-sentence purpose:** [What problem does this solve, for whom?]

**Existing codebase?** [None — brand new / Yes — inherited from: describe
briefly, e.g. "a Google AI Studio-generated Vite+React scaffold"]

**Known constraints or preferences (if any):** [Budget/hosting limits,
required integrations, a deadline, anything the Director already knows
they want or must avoid. Write "None yet — ask me" if unsure.]

---

## What to Do Next

1. **If no Constitution exists for this project yet:** propose one,
   following Commander's structure (Vision, Architecture, Domain rules,
   Data model, External integrations, Out-of-scope). Base every
   architectural choice on Commander's defaults (Next.js + Supabase +
   Vercel + Gemini, per `DECISION_LOG.md` DL-001 through DL-008)
   *unless* the existing codebase or a stated constraint calls for a
   documented deviation (Commander explicitly allows this — see
   `CONSTITUTION.md` M-16 and `DECISION_LOG.md` DL-009/DL-010 for the
   proven Vite+Express+Render.com alternate path). Do not silently
   assume a deviation is wanted — ask.

2. **If a Constitution already exists:** read it fully, confirm you
   understand the current sprint's scope, and do not proceed past
   `FEATURE_LIFECYCLE.md` Step 1 (Analysis) until you can answer every
   question it asks.

3. **Whenever anything is unspecified** — an API shape, a business
   rule, a role's permissions, which institution owns a piece of data —
   **stop and ask.** Never invent it (`CONSTITUTION.md` M-4, M-10). One
   clarifying question costs nothing; hallucinated architecture that
   must be rebuilt costs real time.

4. **Work in sprints**, one focused area at a time (`CONSTITUTION.md`
   M-13). At the end of every sprint, run `DONE_CHECKLIST.md` in full
   before declaring it complete, and write the handoff note
   (`FEATURE_LIFECYCLE.md` Step 7).

5. **Before the first production deploy, and before any push bundling
   multiple sprints of unreviewed changes**, run the
   `PROMPT_LIBRARY/pre-deploy-stress-test.md` prompt — do not skip
   this because "each sprint was tested individually already." Bugs
   that live in the seams between features added under different
   rules at different times are exactly what individual sprint testing
   misses.

6. **Feed lessons back.** If you discover a real mistake, a footgun,
   or a pattern worth generalising while working on this project,
   say so — don't just fix it locally and move on. Concrete, dated,
   specific lessons (not vague advice) are what keep Commander itself
   improving across every project it governs.

---

*Wait for the Director's answers to the Project Brief above before
proceeding to Step 4 if any field says "ask me" or is left blank.*
