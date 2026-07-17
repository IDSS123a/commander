# KRAJ — End-of-Project Commander Update

The Director has signalled end of project.
Execute CONSTITUTION.md M-22 (KRAJ Protocol) exactly.

## Required inputs (fetch all before starting):

1. All files in `[project-repo]/corrections/`
2. `[project-repo]/DECISION_LOG.md`
3. Last 3 sprint handoff notes from `[project-repo]/sprints/`
4. https://raw.githubusercontent.com/IDSS123a/commander/main/CONSTITUTION.md
5. https://raw.githubusercontent.com/IDSS123a/commander/main/DECISION_LOG.md
6. https://raw.githubusercontent.com/IDSS123a/commander/main/AUDIT_LOG.md

## Protocol

Follow M-22 Steps 1–5 in exact order:

1. **COLLECT** — Read all correction files, project decision log, last 3 sprint notes
2. **ANALYSE** — Identify rule violations, ineffective rules, uncovered problems, missing DL entries
3. **PROPOSE** — Generate `COMMANDER_UPDATE_PROPOSAL.md`
4. **CONFIRM** — Present to Director and wait for explicit approval
5. **EXECUTE** — Apply approved changes to Commander repository, update AUDIT_LOG.md

## Output

`COMMANDER_UPDATE_PROPOSAL.md` — presented to Director before any changes are committed.

## Critical rules

- Do NOT commit anything without Director's explicit "odobri" or "approved"
- Do NOT skip steps or combine steps
- Do NOT edit Commander files before Step 4 approval
- Include specific evidence (sprint numbers, violation counts) for every recommendation
