# COMMANDER_CHANGELOG.md — Version Diff Reference
# Purpose: an ACA detecting a version mismatch (.commander-version vs
# live CONSTITUTION.md header) reads ONLY this file to learn what
# changed — instead of re-reading every Commander document.
# NOT loaded at session start (M-21). Read only on version mismatch
# or when the Director asks about Commander history.

---

## v1.5.5 (2026-09-26) — Vibe-Coding Journal M-22 KRAJ (end-of-project)

The project's first-ever KRAJ pass -- full AUDIT_LOG.md entry is
AUDIT-004; the approved `COMMANDER_UPDATE_PROPOSAL.md` with every
citation lives in the project repository. Evidence base: all 8
`corrections/SPRINT_0N_LESSONS.md` files, the 3 most recent handoffs,
and all 91 entries of the project's own `DECISION_LOG.md`.

- ADDED (ENGINEERING_RULES.md E-5): a timeout inside a key/endpoint
  rotation loop is retryable, not terminal -- two live production
  outages, six weeks apart, were both this exact shape.
- ADDED (ARCHITECTURE_PATTERNS.md A-3): any UPDATE/DELETE-by-id must
  check the affected-row count; Supabase/PostgREST returns success on
  zero matched rows.
- ADDED (ARCHITECTURE_PATTERNS.md A-8): PostgREST NULL filter --
  `.is(col, null)`, never `.eq(col, null)`, which TypeScript cannot
  catch.
- ADDED (ARCHITECTURE_PATTERNS.md, new A-11): de-duplicate concurrent
  in-flight requests to a shared per-page-load endpoint (only
  overlapping calls merge; legitimate interval polling still fires
  fresh).
- ADDED (DONE_CHECKLIST.md Security, two items): a real live
  adversarial pass (forged token, self-escalation, cross-tier read) is
  a mandatory gate before real payments/production data; an "X is
  exempt from Y" claim is proven only by making X fail Y.
- ADDED (Learned-From, six existing rules -- verified already covered
  in substance, so these are narrow additions, not new rules): E-4's
  RBAC pattern names the decode-only-library pitfall (`jwt-decode`);
  security-review.md's RLS checklist notes owner-scoped isn't
  automatically column-safe; E-12 adds a third occurrence of long-lived
  tokens expiring silently; M-2 adds "search for a dormant
  implementation first"; M-4 adds "surface an instruction conflict,
  don't silently resolve it"; M-12 adds the inverse library-discipline
  caution (hand-rolled parsing of a standard format).
- FIXED (hygiene, no rule/behavior change): six more Commander
  documents (`AUDIT_LOG.md`, `DECISION_LOG.md`,
  `ACA_COMMUNICATION_PROTOCOL.md`, `initial_instructions.md`,
  `PROMPT_LIBRARY/commander-audit.md`, and internal `# Version` headers
  in five files whose footers alone had been bumped by earlier
  releases) were still stamped v1.5.2 or v1.5.3. All twelve documents
  plus `VERSION` now agree on v1.5.5.
- Severity changes: none. Deprecation candidates: none. New DECISION_LOG
  entries: none (the reusable insights found were process/methodology
  lessons, filed as Learned-From additions instead).

Source: Vibe-Coding Journal project, M-22 KRAJ, September 2026.

---

## v1.5.4 (2026-09-26) — Vibe-Coding Journal lessons

- ADDED (ARCHITECTURE_PATTERNS.md A-3, Database Repository Pattern): a
  repository function feeding a batch loop (AI calls, outbound HTTP —
  anything with a real per-row cost) must take a mandatory, named
  `limit`, never an unbounded `SELECT *` "because it's just a queue" —
  a failed run's leftover rows otherwise compound whole into the next
  run and can blow that run's own time/rate budget. Found live,
  independently, twice on the same project before being generalized.
- ADDED (ARCHITECTURE_PATTERNS.md A-7, Environment Variables Pattern):
  three env var gotchas found live in one session — (1) a numbered
  set (`KEY_1`, `KEY_2`, ...) scanned by a loop with a hardcoded upper
  bound silently drops anything added past it, no error; (2) a local
  `.env`/`.env.local` change never reaches a deployed platform's own
  Production store on its own, always confirm it landed there before
  trusting a fix is live; (3) on Vercel, a `NEXT_PUBLIC_*` var cannot
  be saved as type Secret, and once saved as Secret cannot be
  converted to Config in place — delete and re-add instead.
- FIXED (hygiene, no rule/behavior change): the version identity stamp
  at the bottom of `CONSTITUTION.md`, `CLAUDE_CODE_OPERATIONS.md` and
  `FEATURE_LIFECYCLE.md` still read v1.5.2 — the v1.5.3 update had
  only bumped the three files it actually changed content in. All
  seven Commander documents plus `VERSION` now agree on v1.5.4.

Source: Vibe-Coding Journal project, September 2026.

---

## v1.5.3 (2026-08-07) — IDSS Timetable lessons

Director-approved proposal (`COMMANDER_UPDATE_PROPOSAL.md` / execution content
in `COMMANDER_UPDATE_CONTENT.md`), read against the actual current content of
each target file before applying — two of the six proposed items were already
covered by v1.5.2 and skipped rather than duplicated.

- ADDED (ENGINEERING_RULES.md, new **E-14**): schema/config changes used by
  more than one layer require explicit consumer enumeration in the ANALYSIS
  phase (FEATURE_LIFECYCLE Step 1) and a round-trip test (load → save →
  compare) for every new/changed field — fields were silently lost in forms
  that didn't know about them, twice, before this was formalised.
- ADDED (ENGINEERING_RULES.md E-4 table, new row): CSV/Excel export of
  user-controlled text must guard against formula injection (`=`/`+`/`-`/`@`
  prefix) — minimum protection is an apostrophe prefix before writing the cell.
- ADDED (DONE_CHECKLIST.md): matching checklist items for both of the above,
  in Architecture and Security sections respectively.
- ADDED (ACA_MANAGEMENT_GUIDE.md §1.5, §5.9): non-coder-Director default
  communication standard (literal step-by-step, never assume terminal/git
  familiarity) and a `web_fetch`-on-GitHub caching-unreliability warning
  (prefer local git access when available). The project-specific IDSS
  Handbook content already in this file was left untouched — additions only.
- SKIPPED (already covered, not duplicated): "no secrets in frontend build"
  (E-4's existing Secret management/Service keys rows + security-review.md's
  Client-bundled secrets section already cover this) and "auth rate-limiting
  same sprint" (DONE_CHECKLIST's existing rate-limit item +
  security-review.md's Abuse resistance section already cover this).

Source: IDSS Timetable project, August 2026.

---

## v1.5.2 (2026-08-03) — Security hardening + native token/safety primitives

From a comparative study of ~20 external vibe-coding/Claude-Code repos + the
official Claude Code cheatsheet. Two evidence-based additions that pass the
"simple, fast, minimal-token" test; everything else was consciously rejected
(see DL-013). Zero cost to normal sessions — new content loads only at
security-review / DONE (M-21).

- ADDED (security-review.md + DONE_CHECKLIST.md): the top vibe-coding breach
  vectors Commander didn't cover — Supabase RLS (deny-by-default, owner-scoped),
  object-level access control / IDOR, the NEXT_PUBLIC_/VITE_ client-secret trap,
  wildcard CORS, auth-endpoint rate limiting, security headers, SSRF, webhook
  signature verification. (Taxonomy: benavlabs/vibe-check, MIT; rewritten.)
- ADDED (CLAUDE_CODE_OPERATIONS.md): `/btw` (side question without spending
  context) and `/rewind` / Esc Esc (roll back to a checkpoint; pairs with M-23).
- ADDED: DL-013 records the evidence, the source, and what was rejected
  (SuperClaude/multi-agent/subagent bloat) to protect token economy.

No rule meaning changed; no architecture change. Recommendation stands: FREEZE
and validate through real projects (DL-012).

---

## v1.5.1 (2026-08-03) — Hygiene patch (no functional change)

From an ACA system-review of v1.5. Fixes ONLY (no rule, behavior, or doc
content changed; identity stamps bumped 1.5 -> 1.5.1):
- install-automation.bat header no longer hardcodes a version (says
  "reads /VERSION") — that was the exact stamp still stuck on v1.4.
- lessons-guard.js comments corrected 4h -> 12h to match the code (the
  window was changed in v1.5 but three comments still said 4h).
- .gitignore added (*.zip, OS junk) so release archives are never tracked
  (E-4). Any archive comes from GitHub Releases, not the source tree.

Deferred to a Director-approved proposal (rule/behavior changes, not hygiene):
version-check comparing latest release TAG instead of main; C-8 scoped to
Director-facing output vs internal filesystem edits.

---

## v1.5 (2026-08-02) — Minimal maintenance on canon v1.4

Scope: bug fixes + IP protection ONLY. The v1.4 architecture (fetch/tag model,
M-14, bootstrap, version-check-vs-main, spec→plan→tasks) is UNCHANGED — no rule
meaning altered, no model rewritten. Every doc's fetch/loading prose is exactly
as in v1.4, so code and docs stay consistent.

- ADDED: /VERSION single source; install-automation.bat now seeds
  .commander-version from /VERSION (was hardcoded — the exact drift bug).
- FIXED: patterns-detect.js scans all *_LESSONS.md (was SPRINT_* only, so
  QUICK-mode PROTOTYPE lessons never fed pattern detection).
- FIXED: lessons-guard.js session window 4h → 12h (real sessions run 8h+;
  4h silently bypassed enforcement on long days).
- FIXED: log-change.js caps ACTIVITY_LOG.md (~200KB / newest ~1500 lines).
- FIXED: project-guard.js reads file_path || path (catches MultiEdit).
- ADDED: LICENSE — proprietary / all-rights-reserved (© Davor Mulalić/IDSS123a).

Note: version-check.js is intentionally UNCHANGED. It fetches live `main`; on a
private repo that fetch simply returns nothing and the hook exits cleanly (no
false warning, no crash) — graceful degradation, not a bug.

---

## v1.4 (2026-07-24)

### v1.4 patch (2026-07-27)
- FIXED: `CLAUDE_CODE_OPERATIONS.md`'s `/compact` guidance — "at phase
  boundaries" was too vague to actually produce the behavior. Evidence:
  the v1.3/v1.4 Commander maintenance work itself ran as one unbroken
  multi-day conversation with zero deliberate `/compact` calls, later
  confirmed in Claude Pro's own usage breakdown (95% of that week's
  usage at >150k context, 78% from 8+ hour sessions). Replaced with
  three concrete checkpoints: after every numbered deliverable commit,
  every ~2 hours of continuous work, before switching topics or days.
  No version bump — this is an advisory-document clarity fix (M-21:
  these stay on `main`, never tag-pinned), not a new mechanism or rule.

Trigger: brutal stress-test + comparative report against GitHub Spec
Kit, BMAD, OpenSpec, and Agent OS (2026-07-23) — see AUDIT-002/AUDIT-003
in AUDIT_LOG.md for full detail.

- ADDED: `automation/.github/workflows/project-guard.yml` — runs
  `project-guard.js --scan` server-side on every push/PR, closing the
  gap where a push outside the ACA's own session (e.g. GitHub web
  upload) bypasses every local hook
- ADDED: release tagging practice — every version bump gets an
  annotated git tag immediately after push; bootstrap (`initial_
  instructions.md` Step 3, `install-automation.bat`) now fetches
  executable automation (hooks, settings, installer, CI workflow) from
  the release tag, never from `main`. Advisory documents deliberately
  stay on `main` (M-21); `version-check.js` is unchanged. Retroactively
  tagged v1.3.
- ADDED: first real M-19 audit (AUDIT-003) — E-3 and E-11 amended to
  match real, legitimate project practice found in idss-handbook
  (Server-Action forms, CSS-token styling); A-5, A-10, E-5 extended
  with 3 new rules (maxTokens sizing, AI-derived-content FK cascade,
  HTTP-200-≠-usable-output); governance/product commit ratio computed
  (54 : 77) and the computation step added to the audit skill for
  future runs
- ADDED: `specs/[feature-name]/` spec→plan→tasks layer — `/specify`
  (SPEC.md: what/why, no tech stack), `/plan-feature` (PLAN.md:
  technical approach checked against ARCHITECTURE_PATTERNS.md and
  ENGINEERING_RULES.md), `/tasks` (TASKS.md: ordered checklist).
  Closes the one structural gap every competing spec-driven framework
  treats as its core value proposition
- ADDED: DL-012 — pause further investment in untested
  model-agnosticism (graceful-degradation prose) until Commander runs
  on a real second ACA
- CHANGED: `FEATURE_LIFECYCLE.md` Steps 1–3 reference the new spec
  artifacts instead of describing freeform reasoning; Steps 4–7
  unchanged
- CHANGED: `CLAUDE_CODE_OPERATIONS.md` §5 — points to the real
  `PROJECT_CLAUDE_MD_TEMPLATE.md` instead of a stale inline example
  that had drifted out of sync (M-7)

---

## v1.3 (2026-07-23)

### v1.3 stress-test fixes (2026-07-23)
- FIXED: project-guard.js ReDoS — a pathological regex in the config
  (catastrophic backtracking) froze the hook on every edit; each rule
  now runs in a 500ms vm timebox: hook mode skips the dead rule (fail
  open), CLI `--scan` reports it as a config defect and exits 1
- FIXED: initial_instructions.md Step 3 — now installs all five hooks
  + guard config + skills; dead fallback to the removed
  commander-automation.zip replaced with a shallow `git clone` copy;
  version references brought to v1.3
- FIXED: README "New projects" — concise two-path bootstrap
  (paste initial_instructions.md / run install-automation.bat) instead
  of the stale start-new-project description

- ADDED: E-13 Mechanically Checkable Rules Ship as Automation (🟡) —
  scriptable rules (forbidden strings, secret patterns, lint gates)
  ship as hooks on hook-capable ACAs, or as the one-line
  `project-guard.js --scan` pre-commit step elsewhere. Prose
  duplicating a shipped hook is deleted. (ENGINEERING_RULES.md)
- ADDED: M-23 Destructive-Action Confirmation (🔴) — git history
  rewrites require explicit prior approval, no low-risk exception;
  external-state claims justifying destructive-adjacent actions are
  verified live before execution. (CONSTITUTION.md)
- ADDED: automation/.claude/hooks/project-guard.js — configurable
  forbidden-pattern guard: PostToolUse block mode + `--scan` CLI mode;
  per-project config (project-guard.config.json, example included)
- ADDED: automation/.claude/skills/ — /kraj, /sprint-close,
  /commander-audit: recurring rituals load instructions only on
  invocation; PROMPT_LIBRARY originals remain the fallback for ACAs
  without skill support
- ADDED: M-18 harvest from vibe-coding-journal sprint 06 — E-4
  pre-push secret audit covers tracked binaries; E-8 allowlist
  redaction of error bodies + external-trigger timeout-notification
  rule; E-11 + DONE_CHECKLIST no future-dated test fixtures in
  production tables; E-12 Vercel Sensitive env vars are write-only
- CHANGED: automation/PROJECT_CLAUDE_MD_TEMPLATE.md — all 15 🔴
  CRITICAL rules inlined as one-line compressions; full documents read
  on demand per M-21 tiers; replaces the 5-document raw-URL load every
  session (~60K tokens) with zero mandatory fetches
- CHANGED: automation/install-automation.bat — additionally installs
  project-guard.js, skills/, and seeds project-guard.config.json;
  `.commander-version` seeded as 1.3
- CHANGED: automation/.claude/settings.json — registers project-guard
  as second PostToolUse hook (five hooks total)
- CHANGED: CLAUDE_CODE_OPERATIONS.md — measured context practice:
  /context at phase boundaries, deliberate /compact with focus
  instructions
- REMOVED: automation/commander-automation.zip — tracked derived
  binary, prohibited by the new E-4 binary-audit rule (the folder it
  mirrors is the source of truth)

Constraint honoured: every v1.3 change replaces a manual step or
removes tokens (approved efficiency strategy, 2026-07-23); nothing
additive-only. Rejected by the same test: standing subagent rules,
blanket MCP server expansion.

## v1.2 (July 2026)

### v1.2 stress-test fixes (2026-07-18)
- FIXED: install-automation.bat now installs all 4 hooks and creates `.commander-version`
- FIXED: README.md Repository Structure updated (M-22, CHANGELOG, initial_instructions, kraj.md, automation/)
- FIXED: ENGINEERING_RULES.md version bumped to 1.2 (contains v1.2 Conventional Commits addition)
- FIXED: ACA_MANAGEMENT_GUIDE.md dead reference (recover-env.md → CLAUDE_CODE_OPERATIONS.md)
- FIXED: version-check.js sanitizes corrupt `.commander-version` content


- ADDED: M-21 Tiered Loading — read only what the task requires (CONSTITUTION.md)
- ADDED: M-22 KRAJ Protocol — end-of-project Commander update, 5 steps with mandatory Director approval (CONSTITUTION.md)
- ADDED: PROMPT_LIBRARY/kraj.md — KRAJ execution template
- ADDED: COMMANDER_CHANGELOG.md (this file)
- ADDED: automation/.claude/hooks/version-check.js — SessionStart hook, detects project vs Commander version drift
- ADDED: automation/.claude/hooks/patterns-detect.js — Stop hook, auto-detects rules recurring in 3+ sprint lessons files → corrections/PATTERNS.md
- ADDED: `.commander-version` file created at project bootstrap (initial_instructions.md Step 3)
- ADDED: Emergency Brake clause in M-4 — destructive actions always require explicit human confirmation
- ADDED: Conventional Commits format in E-10 (ENGINEERING_RULES.md)
- CHANGED: initial_instructions.md — complete rewrite (M-21/M-22 alignment, M-16 stack question in Step 2, corrected automation paths, KRAJ delegates to M-22 instead of defining its own protocol)
- CHANGED: PROMPT_LIBRARY/start-new-project.md — now a redirect to initial_instructions.md (single source of truth, M-7)
- CHANGED: automation/PROJECT_CLAUDE_MD_TEMPLATE.md — v1.2, M-21 tier references, KRAJ section references M-22
- CHANGED: README.md — workflow section rewritten around tiered loading
- CHANGED: automation/.claude/settings.json — registers SessionStart and second Stop hook

## v1.1 (July 2026)

- ADDED: Severity levels on all rules (🔴 CRITICAL / 🟡 STANDARD / 🟢 PREFERRED)
- ADDED: Status tags ([ACTIVE] / [DEPRECATED] / [SUPERSEDED])
- ADDED: Document precedence resolution order (CONSTITUTION.md preamble)
- ADDED: M-15 Confidentiality Rules Propagate to Every Surface (learned from web-app-chronos audit-log leak)
- ADDED: M-16 Stack Deviation Is a Path, Not an Exception
- ADDED: M-17 Deprecation Protocol
- ADDED: M-18 Sprint-Level Learning Capture (corrections/ folder)
- ADDED: M-19 Annual Commander Audit
- ADDED: M-20 Quick Mode for MVPs and Prototypes
- ADDED: ACA_COMMUNICATION_PROTOCOL.md (C-1 through C-11)
- ADDED: CLAUDE_CODE_OPERATIONS.md
- ADDED: AUDIT_LOG.md
- ADDED: automation/ — log-change.js + lessons-guard.js hooks, PROJECT_CLAUDE_MD_TEMPLATE.md, installer
- ADDED: PROMPT_LIBRARY/commander-audit.md, sprint-lessons.md
- ADDED: Express translation blocks in ARCHITECTURE_PATTERNS.md (A-1, A-2, A-3, A-8)
- ADDED: Post-Deploy Verification section in DONE_CHECKLIST.md
- ADDED: DL-011 Shadcn/UI (DECISION_LOG.md)
- ADDED: DL-009 Vite+Express alternate stack, DL-010 Render.com deployment
- CHANGED: DONE_CHECKLIST.md — Sprint-Level Learning and Commander Compliance Scoring sections
- CHANGED: PROMPT_LIBRARY/start-new-project.md, security-review.md, pre-deploy-stress-test.md — lessons from web-app-chronos (10 sprints, 2 stress tests)

## v1.0 (June 2026)

- Initial release: CONSTITUTION.md (M-1 through M-14), ENGINEERING_RULES.md (E-1 through E-12), ARCHITECTURE_PATTERNS.md (A-1 through A-10), FEATURE_LIFECYCLE.md, DONE_CHECKLIST.md, DECISION_LOG.md (DL-001 through DL-008), ACA_MANAGEMENT_GUIDE.md, PROMPT_LIBRARY (7 prompts), README.md

---

*Commander v1.5.2 — IDSS123a Organisation — Davor Mulalić — direktor@idss.ba*
