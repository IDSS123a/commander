# COMMANDER_CHANGELOG.md — Version Diff Reference
# Purpose: an ACA detecting a version mismatch (.commander-version vs
# live CONSTITUTION.md header) reads ONLY this file to learn what
# changed — instead of re-reading every Commander document.
# NOT loaded at session start (M-21). Read only on version mismatch
# or when the Director asks about Commander history.

---

## v1.3 (2026-07-23)

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

*Commander v1.3 — IDSS123a Organisation — Davor Mulalić — direktor@idss.ba*
