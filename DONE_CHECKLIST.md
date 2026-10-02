# DONE_CHECKLIST.md — Universal Definition of Done
# Commander — Project Operating System
# Version 1.6.2 — October 2026

---

> A feature or sprint is NOT done until every item on this checklist is checked.
> The ACA must go through this list explicitly before declaring any sprint complete.
> If any item fails: fix it before moving on.

---

## Code Quality

- [ ] TypeScript compiles with zero errors (`npx tsc --noEmit`)
- [ ] No `any` types anywhere in new or modified code
- [ ] No `@ts-ignore` comments anywhere in new or modified code
- [ ] No hardcoded values (hex colours, pixel sizes, magic numbers, strings)
  → All in `constants/index.ts` or CSS tokens
- [ ] No TODO comments left in production code
  → Either complete them or log them in `DECISION_LOG.md` as future work
- [ ] No unused imports or dead code
- [ ] No `console.log` in production routes or Server Actions
- [ ] Browser console checked at error level after loading every
  changed screen AND after triggering unrelated local-state
  interactions (not just the happy path) — zero uncaught errors
  or React warnings. Screenshots and network status codes do
  not catch render-loop bugs; the console does.

---

## Architecture

- [ ] No UI component directly queries the database
- [ ] No business logic lives inside UI components
- [ ] No database query lives outside a repository function
- [ ] No permission check lives outside `lib/permissions.ts`
- [ ] No AI SDK call made directly from business logic (goes through AIProvider interface)
- [ ] Feature folder structure matches `ARCHITECTURE_PATTERNS.md`
- [ ] Dependencies flow only top-down (Presentation → Application → Domain → Infrastructure)
- [ ] If this sprint changed a config/schema structure used by more than
      one layer (e.g. backend + frontend form): every consumer explicitly
      enumerated and checked, round-trip test (load → save → compare)
      done for every new/changed field (E-14)

---

## Security

- [ ] Every new API route checks: authentication, then authorisation (role), then Zod validation
- [ ] Every new Server Action checks: authentication, then authorisation, then Zod validation
- [ ] No secrets or keys in client-side code

- [ ] Supabase RLS enabled + deny-by-default on EVERY table (no `USING (true)`)
- [ ] Every resource-ID route verifies the user OWNS the object, not just their role (IDOR)
- [ ] No secret in any `NEXT_PUBLIC_` / `VITE_` / `REACT_APP_` variable
- [ ] Auth endpoints rate-limited; CORS is an allowlist (not `*`)
- [ ] No Supabase service role key in any route that doesn't require it
- [ ] All file uploads validate: MIME type, extension, size limit
- [ ] All user inputs validated with Zod before use
- [ ] If this sprint added/changed a CSV/Excel export of user-controlled
      text: formula-injection protection confirmed (text starting with
      =/+/-/@ handled safely — E-4 CSV/Excel export row)
- [ ] Before enabling real payments or storing real production user
      data for the first time: a REAL, LIVE adversarial pass has been
      run — not a text/code review — against the running app: a
      forged/garbage auth token is rejected, a self-update attempt on
      a sensitive column (role, tier, status) fails, and a cross-tier
      or cross-role read attempt (e.g. a Basic account reading Premium
      content, a non-admin reading another user's data) is refused.
      (Vibe-Coding Journal, PDL-050/051/052, 2026-09-18: three 🔴
      CRITICAL vulnerabilities — auth bypass, self-admin-escalation,
      broad unauthorized reads — were all found live, but only nine
      days AFTER real sandbox payments had already shipped.)
- [ ] Every "role/tier X is exempt from check Y" claim was verified by
      deliberately making X fail Y and confirming access still holds —
      not by observing X pass while incidentally also satisfying Y.
      (Vibe-Coding Journal, `corrections/SPRINT_07_LESSONS.md` #3: an
      admin billing exemption was proven only after temporarily
      expiring the admin test account's own subscription and
      confirming dashboard access still worked.)

---

## Error Handling

- [ ] Every async function has try/catch
- [ ] Every error is logged to server console with: location, message, context
- [ ] Every write operation error is logged to audit_log
- [ ] No raw error messages exposed to users (user sees friendly message only)
- [ ] All API routes and Server Actions return standardised shape:
  `{ success: true, data: T }` or `{ success: false, error: string }`

---

## User Experience

- [ ] Every async action shows a loading state while in progress
- [ ] Every error shows a user-friendly message with a recovery action
- [ ] Every list or data view has a designed empty state (no blank screens)
- [ ] All interactions work on mobile viewport
- [ ] Accessibility: new UI elements have proper labels, roles, keyboard navigation
- [ ] Visual/animation features verified with a real-time capture (CDP
  or real hardware) or DOM state — not a hidden preview pane, which
  freezes `requestAnimationFrame` (v1.6)
- [ ] Performance claims measured per E-15 (production HTTPS, ≥ 5
  interleaved runs or PageSpeed Insights) (v1.6)

---

## Documentation

- [ ] JSDoc comment on every new or modified exported function
- [ ] JSDoc comment block on every new API route or Server Action
- [ ] `schema-audit.md` updated if database changed
- [ ] `.env.example` updated if new environment variable added
- [ ] `constants/index.ts` updated if new named constant added
- [ ] `CHANGELOG.md` updated with one line per completed feature
- [ ] `DECISION_LOG.md` updated if a technology or architecture decision was made

---

## Build and Deploy Readiness

- [ ] `npm run build` completes with zero errors
- [ ] `npm run build` completes with zero TypeScript errors
- [ ] No new environment variables missing from `.env.example`
- [ ] No new dependencies added without updating `DECISION_LOG.md`
- [ ] Every package a production script invokes (build tools,
  process runners, anything named in `start`/production npm
  scripts) is listed in `dependencies`, not `devDependencies` —
  verified by actually running
  `npm install --omit=dev && npm run start` locally, not
  assumed from a working local dev environment.
- [ ] Every cleanup/test-teardown script checks and logs the
  `error` return of every delete/admin API call — never assumes
  success from the absence of a thrown exception. A silently
  swallowed error leaves orphaned test data that resurfaces
  later as a confusing, unrelated-looking user-facing bug.
- [ ] No test/fixture rows left behind in production tables from
  manual testing — deleted in-session, or seeded with sentinel
  values (`1970-01-01`, `is_test` flag) that can never collide
  with real data (E-11). Future-dated fixtures silently defeat
  "already exists for today" idempotency checks later.
- [ ] Test data is created only through a channel that can also delete
  it, and is deleted in the same session. If it cannot be deleted, tell
  the Director exactly which row to reject/ignore BEFORE he meets it in
  the admin UI (v1.6 — a leftover test request was approved and raised
  an "email NOT sent" alert)
- [ ] Rate limits tested at the exact boundary: N requests allowed,
  N+1 blocked (v1.6 — an off-by-one blocked the 3rd of 3 allowed
  attempts and was found only live)

---

## Post-Deploy Verification

- [ ] Production URL loads without errors (not a Vercel/Render error page)
- [ ] Core user flow works end-to-end on the production URL
  (login → primary action → expected result)
- [ ] Browser console on production URL checked at error level — zero
  uncaught errors (production builds can surface errors that
  `npm run dev` silences)
- [ ] Environment variables confirmed set in hosting dashboard
  (Vercel → Settings → Environment Variables, or
  Render → Environment → Environment Variables) —
  a missing variable returns a generic 500 that looks like a
  code bug, not a config bug
- [ ] For Render.com deploys: confirm the live URL does NOT return
  the `x-render-routing: no-deploy` header (see DL-010) —
  this means no build has ever succeeded, not "cold start"

---

## Sprint-Level Learning (M-18)

- [ ] `corrections/SPRINT_XX_LESSONS.md` created or updated with:
  - Corrections applied during this sprint
  - Gotchas discovered (environment, tooling, library behaviour)
  - Commander improvement candidates (suggested rule changes)
- [ ] If this is the final sprint of a project:
  - All `corrections/*.md` files reviewed
  - Applicable improvements committed to Commander repository

---

## Commander Compliance Scoring

*Fill this section in the sprint handoff note. It provides data for
the annual Commander Audit (M-19).*

```
COMMANDER COMPLIANCE — Sprint XX
──────────────────────────────────
Rules followed without reminder:        ___/___
Rules violated, caught by ACA:          ___
Rules violated, caught by Director:     ___
Rules that slowed work or felt wrong:   [list or "none"]
New rules suggested by this sprint:     [list or "none"]
```

**How to count:**
- "Without reminder" = ACA followed the rule naturally without
  the Director pointing it out.
- "Caught by ACA" = ACA violated a rule, then self-corrected
  (🔄 COURSE CORRECTION).
- "Caught by Director" = Director had to point out a Commander
  violation the ACA missed.
- "Slowed work" = Be honest. If a rule required effort that
  didn't produce value, it's a deprecation candidate (M-17).

This scoring is not punitive — it is diagnostic. It tells the
Director which rules are working, which need reinforcement, and
which should be retired.

---

## Handoff

- [ ] Sprint document updated with completed items
- [ ] Handoff note written: completed, not completed, risks, technical debt, next sprint
- [ ] Commit message is clear and structured (see `FEATURE_LIFECYCLE.md` Step 7)
- [ ] Commander Compliance score recorded (above)

---

*Commander v1.6.2 — IDSS123a Organisation*
