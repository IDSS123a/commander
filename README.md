# Commander — Project Operating System

**Owner:** Davor Mulalić — P.U. Internationale Deutsche Schule Sarajevo
**Purpose:** Universal AI Coding Assistant operating system for all projects
**Version:** 1.1 — July 2026

---

## What This Is

Commander is a **Project Operating System (POS)** — a standardised set of documents
and rules that any AI Coding Assistant (ACA) must follow when working on any project
under the IDSS123a organisation.

It is **model-agnostic**: it works equally with Claude, Windsurf, Cursor, Bolt,
Lovable, Google Antigravity, GitHub Copilot, and any future ACA.

It is **self-improving**: every project feeds corrections and improvements back into
Commander through the sprint-level learning system (M-18), making the next project
start from a stronger baseline.

---

## How to Use Commander in Any New Project

For the **first message of a brand-new project** (or when adopting an
existing codebase into Commander governance for the first time), use
`PROMPT_LIBRARY/start-new-project.md` — it walks the ACA through
reading all Commander documents in order, then the project's own
repository if one exists, before any code is discussed.

For every later ACA conversation on an already-governed project,
provide these URLs:

```
Commander Constitution:
https://raw.githubusercontent.com/IDSS123a/commander/main/CONSTITUTION.md

Commander ACA Communication Protocol:
https://raw.githubusercontent.com/IDSS123a/commander/main/ACA_COMMUNICATION_PROTOCOL.md

Project Constitution:
https://raw.githubusercontent.com/IDSS123a/[project-repo]/main/CONSTITUTION.md

Current Sprint:
https://raw.githubusercontent.com/IDSS123a/[project-repo]/main/sprints/SPRINT_XX.md
```

The ACA fetches all documents, reads them completely, then proceeds.
No long pastes. No lost context. No repeated explanations.

---

## Quick Mode (for MVPs and Prototypes)

Full Commander governance is designed for institutional platforms. For
one-day MVPs, rapid prototypes, or validation experiments, use Quick Mode.

**Read only:**
- CONSTITUTION.md — M-1 through M-5 (the five 🔴 CRITICAL mindset rules)
- ENGINEERING_RULES.md — E-1 (TypeScript), E-4 (Security), E-5 (Error Handling)
- ACA_COMMUNICATION_PROTOCOL.md — C-1 through C-5 (core communication rules)

**Skip in Quick Mode:**
- ARCHITECTURE_PATTERNS.md, FEATURE_LIFECYCLE.md, DONE_CHECKLIST.md
- Sprint documents (no sprints — build in one pass)

**Upgrade path:** If the prototype is validated and becomes a real project,
apply Full Commander governance before sprint 2.

---

## Document Hierarchy & Precedence

```
Commander/CONSTITUTION.md              ← Universal mindset (always wins)
Commander/ENGINEERING_RULES.md        ← Universal code standards (wins on code)
Commander/ARCHITECTURE_PATTERNS.md    ← Universal structural rules (wins on structure)
Commander/ACA_COMMUNICATION_PROTOCOL.md ← ACA output standards (wins on communication)
Commander/FEATURE_LIFECYCLE.md        ← Universal build process
Commander/DONE_CHECKLIST.md           ← Universal definition of done
Commander/DECISION_LOG.md             ← Universal technology decisions
Commander/ACA_MANAGEMENT_GUIDE.md     ← ACA management practices
Commander/CLAUDE_CODE_OPERATIONS.md   ← Director's Claude Code guide
Commander/PROMPT_LIBRARY/             ← Reusable prompt templates
[Project]/CONSTITUTION.md            ← Project-specific rules (inherits Commander)
[Project]/sprints/SPRINT_XX.md       ← Current sprint scope
[Project]/corrections/               ← Sprint-level lessons learned
```

**Conflict resolution:** Higher in this list wins in its domain.
See CONSTITUTION.md header for the explicit precedence order.

---

## Severity Levels

Every rule in Commander is tagged with a severity level:

| Level | Meaning | Policy |
|-------|---------|--------|
| 🔴 CRITICAL | Violation causes structural damage | Never skip. No exceptions. |
| 🟡 STANDARD | Violation creates technical debt | Follow by default. Document exceptions. |
| 🟢 PREFERRED | Best practice | Flexible in exceptional, documented situations. |

---

## Rule Lifecycle

Every rule has a status tag:

| Tag | Meaning |
|-----|---------|
| `[ACTIVE]` | Current rule, enforced on all projects |
| `[DEPRECATED: reason, date]` | No longer enforced. Kept for history. |
| `[SUPERSEDED BY X-XX]` | Replaced by a newer rule. |

Rules are never deleted — they are deprecated or superseded.
This preserves the evolution history for audits. See M-17.

---

## Self-Improvement Loop

Commander improves with every project through this cycle:

```
┌─────────────────────────────────────────┐
│  1. Start project with current Commander │
│                                         │
│  2. ACA records corrections per sprint  │
│     → corrections/SPRINT_XX_LESSONS.md  │
│                                         │
│  3. Done Checklist includes Compliance  │
│     Scoring at end of each sprint       │
│                                         │
│  4. At project end: ACA reads all       │
│     corrections/ files and updates      │
│     Commander repository                │
│                                         │
│  5. Next project starts with improved   │
│     Commander                           │
└─────────────────────────────────────────┘
```

Additionally, an annual Commander Audit (M-19) reviews all rules
for relevance, consolidates overlaps, and retires outdated rules.

---

## Repository Structure

```
commander/
├── README.md                        ← This file
├── CONSTITUTION.md                  ← Universal mindset (M-1 to M-20)
├── ENGINEERING_RULES.md             ← Universal code standards (E-1 to E-12)
├── ARCHITECTURE_PATTERNS.md         ← Universal structural rules
├── FEATURE_LIFECYCLE.md             ← Universal build process
├── DONE_CHECKLIST.md                ← Universal definition of done
├── DECISION_LOG.md                  ← Universal technology decisions
├── ACA_MANAGEMENT_GUIDE.md          ← ACA management practices
├── ACA_COMMUNICATION_PROTOCOL.md    ← ACA output and interaction standards
├── CLAUDE_CODE_OPERATIONS.md        ← Director's Claude Code operator guide
├── AUDIT_LOG.md                     ← Commander Audit history
└── PROMPT_LIBRARY/
    ├── start-new-project.md
    ├── create-feature.md
    ├── bug-fix.md
    ├── review-code.md
    ├── security-review.md
    ├── prepare-sprint.md
    ├── pre-deploy-stress-test.md
    ├── sprint-lessons.md            ← Template for sprint corrections
    └── commander-audit.md           ← Prompt for annual Commander Audit
```

---

## Active Projects

| Project                               | Repository                                                                 | Status                             |
| ------------------------------------- | -------------------------------------------------------------------------- | ---------------------------------- |
| IDSS Handbook Web App                 | [web-app-idss-handbook](https://github.com/IDSS123a/web-app-idss-handbook) | Active                             |
| Chronos (Obligation/Deadline Tracker) | [web-app-chronos](https://github.com/IDSS123a/web-app-chronos)             | Active — v1.0, 10 sprints complete |
| VIP Travel                            | TBD                                                                        | Active                             |
| IDSS ISO QMS Web App                  | TBD                                                                        | Planned                            |
| AISBP Framework                       | TBD                                                                        | Planned                            |

---

## Version History

```
v1.0  2026-06  Initial Commander system. 6 core documents + Prompt Library.
               Proven across: IDSS Handbook (12 sprints), Chronos (10 sprints).

v1.1  2026-07  Added: severity levels (🔴/🟡/🟢), status tags ([ACTIVE]/[DEPRECATED]),
               document precedence order, deprecation protocol (M-17), sprint-level
               learning capture (M-18), annual audit protocol (M-19), Quick Mode (M-20),
               Commander Compliance scoring in Done Checklist,
               ACA Communication Protocol (C-1 to C-11),
               Claude Code Operations Guide, Audit Log,
               sprint-lessons and commander-audit prompt templates.
               Source: comprehensive system review, Claude Code research,
               viral prompt code debunking.
```

---

*Maintained by Davor Mulalić — direktor@idss.ba*
