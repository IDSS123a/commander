# PROMPT: Pre-Deploy / Pre-Push Stress Test
# Use before the first production deploy, and before any push that
# bundles multiple sprints' worth of unreviewed changes.

---

## Instructions for ACA

Read these documents before responding:

1. Commander Engineering Rules (Section E-4 — Security, E-12 — Environment Gotchas):
   https://raw.githubusercontent.com/IDSS123a/commander/main/ENGINEERING_RULES.md

2. Commander Architecture Patterns (Section A-9, A-10):
   https://raw.githubusercontent.com/IDSS123a/commander/main/ARCHITECTURE_PATTERNS.md

3. Commander Done Checklist:
   https://raw.githubusercontent.com/IDSS123a/commander/main/DONE_CHECKLIST.md

4. Project Constitution:
   [INSERT PROJECT CONSTITUTION URL]

**Scope:** [SPECIFY: entire app / everything since the last stress test / specific features]

---

Run all four passes, in order, on isolated temporary accounts — never
on real user data. Delete all test accounts/data afterward and verify
against the database.

1. **Static audit** — read every route/domain/repository file added or
   changed since the last such audit, checking against
   `ENGINEERING_RULES.md` E-4 (Security) and `security-review.md`.

2. **Live pentest** — RBAC bypass on every route (no auth, wrong role,
   forged token), mass-assignment, IDOR, XSS payloads in every
   free-text field, injection attempts. Confirm findings live in the
   actual browser, not just via the API.

3. **Regression check** — re-verify RBAC/visibility rules on features
   NOT touched this round still hold after shared-file changes
   (`permissions.ts`, router mounting, etc.).

4. **Boundary/functional test** — field length limits (off-by-one both
   directions), duplicate unique values, date boundaries (month-end,
   leap years), empty/zero-item collections.

Check the browser console at ERROR level throughout, not just network
status codes and screenshots (see `ARCHITECTURE_PATTERNS.md` A-9,
`DONE_CHECKLIST.md`). Fix everything found before declaring ready.

Report findings with severity, file:line, and fix status.
