# Commander — Project Operating System

**Owner:** Davor Mulalić — P.U. Internationale Deutsche Schule Sarajevo
**Purpose:** Universal AI Coding Assistant operating system for all projects
**Version:** 1.0 — June 2026

---

## What This Is

Commander is a **Project Operating System (POS)** — a standardised set of documents
and rules that any AI Coding Assistant (ACA) must follow when working on any project
under the IDSS123a organisation.

It is **model-agnostic**: it works equally with Claude, Windsurf, Cursor, Bolt,
Lovable, Google Antigravity, GitHub Copilot, and any future ACA.

---

## How to Use Commander in Any New Project

For the **first message of a brand-new project** (or when adopting an
existing codebase into Commander governance for the first time), use
`PROMPT_LIBRARY/start-new-project.md` — it walks the ACA through
reading all six Commander documents in order, then the project's own
repository if one exists, before any code is discussed.

For every later ACA conversation on an already-governed project,
provide these URLs:

```
Commander Constitution:
https://raw.githubusercontent.com/IDSS123a/commander/main/CONSTITUTION.md

Project Constitution:
https://raw.githubusercontent.com/IDSS123a/[project-repo]/main/CONSTITUTION.md

Current Sprint:
https://raw.githubusercontent.com/IDSS123a/[project-repo]/main/sprints/SPRINT_XX.md
```

The ACA fetches all three, reads them completely, then proceeds.
No long pastes. No lost context.

---

## Document Hierarchy

```
Commander/CONSTITUTION.md          ← Universal mindset (always read first)
Commander/ENGINEERING_RULES.md    ← Universal code standards
Commander/ARCHITECTURE_PATTERNS.md ← Universal structural rules
Commander/FEATURE_LIFECYCLE.md    ← Universal build process
Commander/DONE_CHECKLIST.md       ← Universal definition of done
Commander/DECISION_LOG.md         ← Universal technology decisions
Commander/PROMPT_LIBRARY/         ← Reusable prompt templates
[Project]/CONSTITUTION.md         ← Project-specific rules (inherits Commander)
[Project]/sprints/SPRINT_XX.md    ← Current sprint scope
```

Higher layer always wins on conflict.

---

## Repository Structure

```
commander/
├── README.md
├── CONSTITUTION.md
├── ENGINEERING_RULES.md
├── ARCHITECTURE_PATTERNS.md
├── FEATURE_LIFECYCLE.md
├── DONE_CHECKLIST.md
├── DECISION_LOG.md
└── PROMPT_LIBRARY/
    ├── create-feature.md
    ├── bug-fix.md
    ├── review-code.md
    ├── security-review.md
    ├── prepare-sprint.md
    ├── pre-deploy-stress-test.md
    └── start-new-project.md
```

---

## Active Projects

| Project | Repository | Status |
|---|---|---|
| IDSS Handbook Web App | [web-app-idss-handbook](https://github.com/IDSS123a/web-app-idss-handbook) | Active |
| Chronos (Obligation/Deadline Tracker) | [web-app-chronos](https://github.com/IDSS123a/web-app-chronos) | Active — v1.0, 10 sprints complete |
| IDSS ISO QMS Web App | TBD | Planned |
| AISBP Framework | TBD | Planned |

---

*Maintained by Davor Mulalić — direktor@idss.ba*
