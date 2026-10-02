# AUDIT_LOG.md — Commander Audit History
# Commander — Project Operating System
# Version 1.6.2 — October 2026

---

> This log records every Commander Audit (M-19) and significant
> system-level change. Entries are never deleted.

---

## AUDIT-001 — System Review & v1.1 Upgrade

**Date:** 2026-07-13
**Trigger:** Comprehensive system review after Chronos v1.0 completion
**Conducted by:** Director + Claude (Opus 4.6)

### Changes Made

**New rules added:**
- M-17: Deprecation Protocol `[ACTIVE]` 🟡
- M-18: Sprint-Level Learning Capture `[ACTIVE]` 🟡
- M-19: Annual Commander Audit `[ACTIVE]` 🟢
- M-20: Quick Mode for MVPs and Prototypes `[ACTIVE]` 🟢

**New documents added:**
- ACA_COMMUNICATION_PROTOCOL.md (C-1 through C-11) — replaces reliance
  on social media "prompt codes" with explicit ACA output standards
- CLAUDE_CODE_OPERATIONS.md — Director's operator guide for Claude Code
  real features and shortcuts
- AUDIT_LOG.md (this file)
- PROMPT_LIBRARY/sprint-lessons.md — template for per-sprint corrections
- PROMPT_LIBRARY/commander-audit.md — prompt for conducting annual audit

**Structural changes:**
- All rules in CONSTITUTION.md tagged with severity (🔴/🟡/🟢) and
  status ([ACTIVE])
- All rules in ENGINEERING_RULES.md tagged with severity and status
- Explicit document precedence order added to CONSTITUTION.md header
- DONE_CHECKLIST.md expanded with Commander Compliance scoring section
  and Sprint-Level Learning checkpoint
- README.md expanded with: Quick Mode, severity legend, rule lifecycle,
  self-improvement loop diagram, version history

**Severity assignments (initial):**

| Rule | Severity | Rationale |
|------|----------|-----------|
| M-1 CTO Principle | 🔴 | Foundational mindset |
| M-2 Thinking Order | 🔴 | Prevents component-first mistakes |
| M-3 Decision Hierarchy | 🔴 | Security > UI is life-saving |
| M-4 Anti-Hallucination | 🔴 | Single most expensive violation type |
| M-5 Layered Architecture | 🔴 | Structural integrity |
| M-6 Feature Folders | 🟡 | Important but not damaging if flexed |
| M-7 Single Source of Truth | 🔴 | Duplication causes drift |
| M-8 Iteration Philosophy | 🟡 | Good practice, sometimes overridden |
| M-9 AI Collaboration | 🟡 | Documentation standard |
| M-10 Context Insufficiency | 🔴 | Same class as M-4 |
| M-11 Refactoring Boundary | 🟡 | Process discipline |
| M-12 Library Discipline | 🟡 | Cost control |
| M-13 Sprint Discipline | 🟡 | Process discipline |
| M-14 GitHub is Runtime | 🟡 | Operational standard |
| M-15 Confidentiality Propagation | 🔴 | Security — learned from real breach |
| M-16 Stack Deviation | 🟡 | Flexibility rule |
| E-1 TypeScript | 🔴 | Type safety is structural |
| E-2 Zod Validation | 🔴 | Boundary protection |
| E-3 Forms | 🟡 | Standard practice |
| E-4 Security | 🔴 | Non-negotiable |
| E-5 Error Handling | 🔴 | Silent failures are structural |
| E-6 API Routes | 🔴 | Auth sequence is security |
| E-7 State Management | 🟡 | Preference, not safety |
| E-8 Monitoring | 🟡 | Operational standard |
| E-9 Naming | 🟢 | Consistency, not safety |
| E-10 Documentation | 🟡 | Handoff quality |
| E-11 Forbidden Patterns | 🟡 | Quality guard |
| E-12 Environment Gotchas | 🟡 | Learned traps |

### Issues Identified (for future audits)

- No rules deprecated yet — expected, system is young
- ARCHITECTURE_PATTERNS.md and FEATURE_LIFECYCLE.md not yet tagged
  with severity/status (deferred to next audit when those files evolve)
- ACA_MANAGEMENT_GUIDE.md may overlap with ACA_COMMUNICATION_PROTOCOL.md;
  monitor for consolidation opportunity

---

## AUDIT-002 — v1.3 Efficiency Upgrade

**Date:** 2026-07-23
**Trigger:** Approved efficiency strategy (official Claude Code
cheatsheet capabilities only) + M-18 harvest from
web-app-vibe-coding-journal (6 sprints)
**Conducted by:** Director + Claude Code (Fable 5)

v1.3 built on the stress-tested v1.2 in 11 reviewed commits: E-13,
M-23, project-guard.js completing the five-hook automation layer,
skills (/kraj, /sprint-close, /commander-audit), zero-fetch CLAUDE.md
template, measured-context practice, sprint-06 lessons harvest, and
the tracked commander-automation.zip removed per the new E-4 rule.
Full per-version diff: COMMANDER_CHANGELOG.md (single source — not
duplicated here). Hard constraint applied to every candidate: replace
a manual step or remove tokens; standing subagent rules and blanket
MCP expansion were rejected by that test.

**Process note (recorded per M-23b):** the session initially built on
a stale local copy of v1.2 because a failed `git clone` into an
existing directory went unnoticed (stderr suppressed) — an instance of
trusting local state over a live external check. The mandatory
pre-push `git ls-remote` caught the divergence before anything was
pushed; work was rebased onto the true origin/main. M-23b exists for
exactly this failure mode.

---

## AUDIT-003 — First Real M-19 Annual Audit

**Date:** 2026-07-23
**Trigger:** Brutal stress-test + comparative report (2026-07-23)
flagged that M-19 had never actually been executed — AUDIT-001 was a
severity-assignment pass and AUDIT-002 was the v1.3 upgrade itself,
neither ran the five-check protocol against real project evidence.
**Conducted by:** Director + Claude Opus 4.8
**Projects reviewed:** web-app-idss-handbook, web-app-chronos,
web-app-vibe-coding-journal (per `PROMPT_LIBRARY/commander-audit.md`,
corrected this audit to actually list all three — it was missing the
third).

### Evidence base

- **web-app-idss-handbook:** `corrections/SPRINT_12_LESSONS.md` and
  `corrections/SPRINT_LESSONS_AUTH.md` — 2 real lesson files, 21
  sprints total. Commit history was reset 2026-07-17 ("history reset
  for data protection," M-15-consistent) — only 2 commits survive, so
  this repo's commit count is **excluded** from the governance/product
  ratio below as non-representative of real activity.
- **web-app-chronos:** 21 commits, 10 sprints, its own project-level
  `DECISION_LOG.md` (CD-001–CD-011). **No `corrections/` folder at
  all** — this project predates M-18 (added v1.1, after Chronos's
  active development). Zero lesson-file evidence is a historical gap,
  not a sign the rules were never violated; recorded here so a future
  audit doesn't misread silence as compliance.
- **web-app-vibe-coding-journal:** already exhaustively reviewed
  during the v1.3 M-18 harvest (6 sprints + `PROCESS_LESSONS.md`); not
  re-litigated here.

### Findings (per the five-check protocol)

1. **STATUS/USAGE — E-3 (Forms: React Hook Form + Zod mandatory)
   does not match real practice.** idss-handbook's entire
   `(auth)` route group never adopted RHF — Server Actions + FormData
   + `useState`, with an explicit written project-level justification
   (consistency with the rest of the codebase, M-8/M-12 over the
   letter of E-3). **Action taken:** E-3 amended (not deprecated) to
   explicitly accept the Server-Action-driven pattern for
   simple/few-field forms, reserving RHF for cross-field validation or
   complex client UX — the rule now matches what was already
   legitimate practice instead of contradicting it.
2. **STATUS/USAGE — E-11's Tailwind-only framing conflicted with a
   legitimate alternative.** idss-handbook's `DESIGN_SYSTEM.md` uses
   CSS custom-property tokens via inline `style={{}}`, not Tailwind
   classes — a real design system, not sloppy inline styling (though
   one hardcoded hex value was a genuine violation, already flagged in
   the project's own lessons file). **Action taken:** E-11 amended to
   name both Tailwind classes and CSS custom-property tokens as
   acceptable; the actual forbidden thing — hardcoded magic values —
   is now the explicit target either way.
3. **New rule candidate, adopted — A-10 extended.** FK from
   AI-generated/derived content to its regenerable parent must never
   be `ON DELETE CASCADE` (idss-handbook SPRINT_12: a live near-miss,
   not yet triggered, caught before Phase 18 regeneration work).
4. **New rule candidate, adopted — A-5 extended.** Size `maxTokens` to
   the longest expected structured output, not the average — a
   silent-truncation bug that only manifests on the longest real
   inputs and hides completely in short-input testing.
5. **New rule candidate, adopted — E-5 extended.** An external call
   returning HTTP 200 is not proof the payload was usable; a
   truncated/malformed AI response that fails downstream parsing and
   gets silently caught is indistinguishable from "working" until
   someone checks the data directly.
6. **OVERLAP/DEPRECATION:** no rule found unused across all three
   projects and no rule found purely overlapping — genuinely nothing
   to deprecate or consolidate this round. Recorded honestly rather
   than manufacturing a deprecation to look thorough.
7. **SEVERITY:** no severity changes indicated — no rule showed the
   repeat-violation pattern that would justify a 🟡→🔴 upgrade, and
   no 🔴 rule showed evidence of being safely relaxable.

### Governance/product commit ratio (D4, computed once, here)

Since inception (no prior real M-19 audit to date from):
commander-repo **54** commits; product repos (chronos 21 +
vibe-coding-journal 56 = 77; idss-handbook excluded, history reset)
**77** commits. Ratio ≈ **41 : 59** (commander : product). Read with
caution for a single data point — chronos and vibe-coding-journal
together span roughly a year of the Director's real project work,
while commander-repo's 54 commits are concentrated in two intense
governance sessions (v1.3, v1.4); the ratio will read very differently
once measured over a rolling window at the next audit rather than
since inception.

### Post-audit checklist (per `PROMPT_LIBRARY/commander-audit.md`)

- [x] `ENGINEERING_RULES.md` updated — E-3, E-5, E-11 amendments
- [x] `ARCHITECTURE_PATTERNS.md` updated — A-5, A-10 amendments
- [x] `PROMPT_LIBRARY/commander-audit.md` project list corrected
- [x] `automation/.claude/skills/commander-audit/SKILL.md` — ratio
  step added for future audits
- [x] `AUDIT_LOG.md` entry appended (this entry)
- [ ] `README.md` version history — covered in the v1.4 version-bump
  commit, not duplicated here

---

## AUDIT-004 — personal-web-page End-of-Project Update (M-22 KRAJ)

**Date:** 2026-09-26
**Trigger:** Director "GOTOVO. Ažuriraj System COMMANDER" → KRAJ protocol;
proposal approved with "odobri".
**Conducted by:** Director + Claude Opus 5.5
**Project reviewed:** https://github.com/mulalicd/personal-web-page
(4 sprints: backend rebuild, three.js hero, gamification, prerender —
the last shipped and rolled back).

### Findings
- **Repeat violations:** M-4/M-10 ×4 (single-observation claims) →
  learned-from text, no severity change (already 🔴); test data left in
  production ×2 → DONE_CHECKLIST item; untagged releases ×2 (v1.5.3,
  v1.5.4) → tags created + CI warning.
- **Rule that slowed work:** DL-005 model hard pin (dead model) →
  deprecated in favour of an availability-checked alias.
- **Uncovered problems:** performance measurement noise → E-15;
  content drift on a content site → A-11/DL-014; AI provider outages and
  prompt injection → A-5; hooks broken by `"type": "module"` → shipped
  hooks/package.json.

### Result
Commander v1.6 — see COMMANDER_CHANGELOG.md for the full list.

---

*Next audit due: January 2027 or after 5th project completion, whichever comes first.*

---

## AUDIT-004 — personal-web-page End-of-Project Update (M-22 KRAJ)

**Date:** 2026-09-26
**Trigger:** Director "GOTOVO. Ažuriraj System COMMANDER" → KRAJ protocol;
proposal approved with "odobri".
**Conducted by:** Director + Claude Opus 5.5
**Project reviewed:** https://github.com/mulalicd/personal-web-page
(4 sprints: backend rebuild, three.js hero, gamification, prerender —
the last shipped and rolled back).

### Findings
- **Repeat violations:** M-4/M-10 ×4 (single-observation claims) →
  learned-from text, no severity change (already 🔴); test data left in
  production ×2 → DONE_CHECKLIST item; untagged releases ×2 (v1.5.3,
  v1.5.4) → tags created + CI warning.
- **Rule that slowed work:** DL-005 model hard pin (dead model) →
  deprecated in favour of an availability-checked alias.
- **Uncovered problems:** performance measurement noise → E-15;
  content drift on a content site → A-11/DL-014; AI provider outages and
  prompt injection → A-5; hooks broken by `"type": "module"` → shipped
  hooks/package.json.

### Result
Commander v1.6 — see COMMANDER_CHANGELOG.md for the full list.

---

## AUDIT-005 — M-22 KRAJ: Vibe-Coding Journal End-of-Project Update (v1.6.1)

**Date:** 2026-09-26
**Trigger:** the Director typed KRAJ — the project's first-ever M-22 pass; only today's own working session (v1.5.4) had fed this project's lessons into Commander before this.
**Conducted by:** Director + Claude Sonnet 5

### Evidence base

`corrections/SPRINT_01_LESSONS.md` through `SPRINT_08_LESSONS.md` (8
files), `corrections/PROCESS_LESSONS.md` (both entries already M-23a/b,
excluded), the 3 most recent handoff notes
(`HANDOFF_CONTENT_PIPELINE_FIX.md`, `HANDOFF_SPRINT_08.md`,
`HANDOFF_TRIGGER_RELIABILITY.md`), and the project's own
`DECISION_LOG.md` in full — 91 entries, PDL-001 through PDL-091.
Cross-checked against the live v1.5.4 Commander content first, so
nothing already covered was re-proposed; two findings (JWT
signature verification, RLS default-deny) turned out already present
and were filed as narrow additions to the existing rules instead of
new ones. Full proposal, with every citation, is
`COMMANDER_UPDATE_PROPOSAL.md` in the project repository (2026-09-26),
approved by the Director before any Commander file changed.

### Changes made

**New rules added:**
- ENGINEERING_RULES.md E-5 — a timeout inside a key/endpoint rotation
  loop is retryable, not terminal (two live outages, PDL-027 and
  PDL-090, six weeks apart)
- ARCHITECTURE_PATTERNS.md A-3 — UPDATE/DELETE-by-id must check the
  affected-row count, not just the absence of an error (SPRINT_04 #4,
  PDL-020)
- ARCHITECTURE_PATTERNS.md A-8 — PostgREST NULL filter: `.is()` never
  `.eq()` (SPRINT_04 #1)
- ARCHITECTURE_PATTERNS.md new A-11 — de-duplicate concurrent
  in-flight requests to a shared per-page-load endpoint, without
  breaking legitimate polling (PDL-091)
- DONE_CHECKLIST.md Security — a real, live adversarial pass (forged
  token, self-escalation attempt, cross-tier read) is a mandatory gate
  before real payments/production data, not an ad hoc later audit
  (PDL-050/051/052, found 9 days after real payments had shipped)
- DONE_CHECKLIST.md Security — an "X is exempt from Y" claim is proven
  by making X fail Y, not by observing X pass while also satisfying Y
  (SPRINT_07 #3)

**Learned-From additions to existing rules (not new rules — verified
already covered in substance):**
- ENGINEERING_RULES.md E-4 (Confirmed-safe RBAC pattern) — named
  pitfall: a decode-only library (`jwt-decode`) gives zero signature
  guarantee (PDL-050, 🔴 CRITICAL, live in production)
- PROMPT_LIBRARY/security-review.md (RLS checklist) — owner-scoped is
  not automatically column-safe; a self-update policy can still allow
  self-escalating a sensitive column (PDL-051, 🔴 CRITICAL)
- ENGINEERING_RULES.md E-12 (Environment Gotchas) — a long-lived
  CLI/API token should be assumed expired after a multi-week gap
  (SPRINT_08 #11, PDL-048, and again 2026-09-26)
- CONSTITUTION.md M-2 (Architectural Thinking Order) — search for a
  prior, possibly-unwired implementation before writing new domain
  logic (PDL-025)
- CONSTITUTION.md M-4 (Anti-Hallucination Protocol) — surface a
  conflict with an earlier instruction, never silently treat newer
  code as "superseding" it (PDL-078)
- CONSTITUTION.md M-12 (Library Discipline) — the inverse caution:
  hand-rolled parsing of an established wire format is itself a
  library-discipline failure (SPRINT_04, PDL-011)

**Severity changes:** none — no existing rule's own text was found
insufficient at its current tag.
**Deprecation candidates:** none — no rule was found to have slowed
this project's work without payoff.
**New DECISION_LOG entries:** none this pass — the reusable insights
found were process/methodology lessons, attached to existing rules
above instead (the same shape as how M-23b was added from this
project's own PROCESS_LESSONS.md).

### Post-KRAJ checklist

- [x] `CONSTITUTION.md` updated — M-2, M-4, M-12 additions
- [x] `ENGINEERING_RULES.md` updated — E-4, E-5, E-12 additions
- [x] `ARCHITECTURE_PATTERNS.md` updated — A-3, A-8 additions, new A-11
- [x] `DONE_CHECKLIST.md` updated — 2 Security additions
- [x] `PROMPT_LIBRARY/security-review.md` updated — RLS column-scoping
- [x] All Commander documents and `VERSION` brought to a consistent
  version stamp (six had drifted to stale v1.5.2/1.5.3 headers or
  footers, unrelated to this project's own lessons — fixed as hygiene
  while already touching every file)
- [x] `COMMANDER_CHANGELOG.md` entry added
- [x] `AUDIT_LOG.md` entry appended (this entry)

**Concurrent KRAJ, merged by hand:** this update was prepared as v1.5.5
against commit 444e9b9, but a second session ran personal-web-page's own
KRAJ concurrently and pushed first, reaching v1.6 from the same starting
point — including its own new `A-11` in `ARCHITECTURE_PATTERNS.md`,
directly colliding with this update's own new `A-11`. Reconciled by
merge: personal-web-page's content kept as `A-11` (it landed first),
this update's in-flight-request pattern renumbered to `A-12`, both
sets of rule/checklist additions verified present after merge (no
content from either session was dropped), and the final version
raised to v1.6.1 to sit cleanly after both. This is the first time two
KRAJ updates from different projects have landed on Commander at
effectively the same time; worth the annual audit (M-19) checking
whether concurrent-update collision needs its own explicit protocol
(e.g. reserving the next rule number before writing content) rather
than being caught and fixed by hand after the fact.

---

## AUDIT-006 — M-22 KRAJ: Vibe-Coding Journal End-of-Project Update, second pass (v1.6.2)

**Date:** 2026-10-02
**Trigger:** the Director typed KRAJ again, after the Tools and Ideas features (and three smaller fixes) shipped since the project's first pass (AUDIT-005, v1.6.1).
**Conducted by:** Director + Claude Sonnet 5

### Evidence base

The project's own `DECISION_LOG.md`, PDL-092 through PDL-095 (the full
log now runs PDL-001 through PDL-095) -- the four entries added since
AUDIT-005 last read it through PDL-091. No new `corrections/` or
sprint-handoff files existed for this pass. Cross-checked against the
live v1.6.1 Commander content first, so nothing already covered was
re-proposed. Full proposal, with every citation, is
`COMMANDER_UPDATE_PROPOSAL.md` in the project repository (2026-10-02),
approved by the Director before any Commander file changed.

### Changes made

**Learned-From additions to existing rules (not new rules):**
- `ARCHITECTURE_PATTERNS.md` A-4 (Permissions Pattern) -- a permission
  gate can split by section instead of gating a whole page: Vibe-Coding
  Journal's "Top Tools to Try" feeds two subscription tiers from one
  endpoint, filtered by caller tier (PDL-094).
- `ARCHITECTURE_PATTERNS.md` A-5 (AI Provider Interface) -- classify a
  new AI content-growth call as EXTRACTIVE (corroborate across sources
  before publishing) or GENERATIVE (always human-review, never
  threshold-based auto-publish) before designing its safety gate,
  confirmed across three independent instances in this one project
  (PDL-042 University, PDL-094 Tools, PDL-095 Ideas).
- `ARCHITECTURE_PATTERNS.md` A-12 (De-duplicate Concurrent In-Flight
  Requests, shipped last pass from PDL-091) -- documented limitation:
  the in-flight cache only merges calls that overlap in time; two
  genuinely sequential calls to the same endpoint are invisible to it
  and need their two data needs composed into one response instead,
  which is the actual fix PDL-092 applied (`/api/me` + `rewards/state`
  merged into one endpoint).
- `ENGINEERING_RULES.md` E-12 (Environment Gotchas) -- a `git push` is
  not an instant deploy: an external cron trigger fired immediately
  after pushing a brand-new route can 404 against the still-live
  previous deployment; confirmed live triggering Vibe-Coding Journal's
  new `ideas-generate` endpoint minutes after pushing it, fixed by
  polling the URL until it stopped 404ing instead of guessing a sleep.

**Severity changes:** none. **Deprecation candidates:** none -- no
rule was found to have slowed this pass's work without payoff. **New
DECISION_LOG entries:** none -- same shape as AUDIT-005: the reusable
insights found were architecture/process lessons, attached to existing
rules above rather than filed as new standalone entries.
**Not proposed (considered and rejected):** PDL-092's Reddit
retirement and book pop-up interval, and PDL-093's hnrss.org-to-Algolia
migration, are business/vendor-specific decisions, not reusable
engineering material -- documented in the project's own
`COMMANDER_UPDATE_PROPOSAL.md` rather than silently dropped.

### Post-KRAJ checklist

- [x] `ARCHITECTURE_PATTERNS.md` updated -- A-4, A-5, A-12 additions
- [x] `ENGINEERING_RULES.md` updated -- E-12 addition
- [x] `COMMANDER_CHANGELOG.md` updated -- new v1.6.2 entry
- [x] `README.md` version history updated -- new v1.6.2 entry
- [x] `VERSION` and every document stamp unified to v1.6.2
- [x] Committed, pushed, tagged `v1.6.2`

---

*Next audit due: January 2027 or after 5th project completion, whichever comes first.*

---

*Commander v1.6.2 — IDSS123a Organisation*
