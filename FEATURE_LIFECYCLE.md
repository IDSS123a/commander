# FEATURE_LIFECYCLE.md — Universal Feature Build Process
# Commander — Project Operating System
# Version 1.5 — August 2026

---

Every feature follows this 7-step lifecycle without exception.

**Scope by size:**
- Small bug fix (single-line change): Steps 4–7 only
- UI-only change (no data or logic): Steps 3–7 only
- New feature or module: All 7 steps

---

## Step 1 — ANALYSIS

*As of v1.4: produced via `/specify`, not freeform reasoning.*

Run `/specify` to produce `specs/[feature-name]/SPEC.md` — purpose,
user stories, acceptance criteria, and the explicit scope boundary
(what this feature does NOT do). No tech stack or implementation
detail belongs in this file; that's Step 2's job.

Two standing checks apply regardless of feature, worth keeping in
mind while writing `SPEC.md`'s acceptance criteria:

- If this feature includes an undo/revert capability, check it
  against the RBAC model before designing it. A "revert last action"
  pattern that assumes uniform permissions breaks the moment "who
  can delete" is narrower than "who can create" — design undo to
  only cover operations reversible within the user's existing
  permissions, not as a blanket capability.
- If this feature replaces a mocked/placeholder integration,
  text-search the whole `src/` tree for the old system's name in UI
  copy — not just a symbol/import search. A label can render
  perfectly and be factually wrong about what the app now does
  ("Google Drive", "Simulate the cron job", "remembered for 30 days"
  with no such logic wired). Treat any static UI copy making a
  specific, falsifiable claim as something to verify against actual
  wired logic, not just visually.

If `/specify` cannot answer all of `SPEC.md`'s sections: STOP and ask.

---

## Step 2 — PLAN

*As of v1.4: produced via `/plan-feature`, not a code comment block.*

Run `/plan-feature` to produce `specs/[feature-name]/PLAN.md` from
`SPEC.md` — architecture, data model, API/Server Action contracts, and
which Commander rules constrained each decision, checked against
`ARCHITECTURE_PATTERNS.md` and `ENGINEERING_RULES.md` directly rather
than reasoned from memory.

Confirm the plan matches the Constitution before writing any code.
If the plan contradicts the Constitution: the Constitution wins —
`/plan-feature` stops and surfaces the conflict rather than resolving
it silently.

---

## Step 3 — IMPLEMENTATION ORDER

*As of v1.4: the checklist lives in `specs/[feature-name]/TASKS.md`,
produced by `/tasks` from `PLAN.md`.* Build strictly in that order —
`TASKS.md` mirrors this sequence and must not be reordered:

```
1. Database migration       (if new tables or columns needed)
      ↓
2. TypeScript types         (types/index.ts or feature/types.ts)
      ↓
3. Zod validation schema    (lib/validation/schemas.ts)
      ↓
4. Repository function      (features/[name]/repository.ts)
      ↓
5. Domain logic             (features/[name]/domain.ts)
      ↓
6. Server Action / API route (features/[name]/actions.ts or app/api/...)
      ↓
7. UI component             (features/[name]/components/)
      ↓
8. Integration              (wire UI to Server Action)
```

Verify each step before moving to the next.
Do not write the UI before the data layer is complete and tested.
Check off items in `TASKS.md` as each completes — don't hold progress
in session memory alone.

---

## Step 4 — SELF-REVIEW

Read your own code before considering it complete:

- [ ] Does it match the specification exactly?
- [ ] Does every async function have try/catch?
- [ ] Are all inputs validated with Zod?
- [ ] Is every role/permission check in place?
- [ ] Are there any magic numbers? → move to `constants/index.ts`
- [ ] Are there any `any` types or `@ts-ignore`? → fix them
- [ ] Is any business logic in the UI layer? → move to domain layer
- [ ] Is any database query outside a repository function? → move it
- [ ] Does the Supabase service role key appear anywhere inappropriate? → remove it

---

## Step 5 — TESTING

Test end-to-end in the browser before declaring done:

- Happy path: everything works as expected
- Each user role: test super_admin, admin, user separately
- Failure paths: invalid input, unauthorized access, empty state, API error
- Mobile viewport: all interactions must work on narrow screen
- Loading states: every async action must show a loading indicator
- Error states: every error must show a user-friendly message
- Any "add N months/years to a date" logic ships with explicit test
  cases for month-end dates (28/29/30/31) and leap-year Feb 29 — not
  just today's date. This class of bug is invisible in normal
  dogfooding and only appears in production months later when a real
  deadline happens to land near a month boundary.
- Any "refresh parent data after a child action succeeds" callback:
  check whether the parent's loading indicator un-mounts the child.
  Fix pattern: track "has this loaded at least once" with a `useRef`
  (not `useState`, so it doesn't itself trigger a re-render loop) and
  only show a blocking spinner on the first load; subsequent
  refreshes happen silently so in-flight local child state (success
  toasts, confirmation screens) survives. Verify this live — it is
  invisible from reading the code.

---

## Step 6 — DOCUMENTATION

Update all relevant documentation:

- [ ] JSDoc on all new or changed exported functions
- [ ] JSDoc comment block on every new API route or Server Action
- [ ] `schema-audit.md` if database schema changed
- [ ] `.env.example` if new environment variable added
- [ ] `constants/index.ts` if new named constant added
- [ ] `CHANGELOG.md` — one line: `[DATE] [FEATURE] What was done`
- [ ] `DECISION_LOG.md` if a technology or architecture choice was made

---

## Step 7 — COMMIT AND HANDOFF

Write a clear, structured commit message:

```
feat(documents): implement upload pipeline with file validation and staging

- Admin can upload PDF, DOCX, XLSX via POST /api/documents/upload
- File validated: MIME type, extension whitelist, max 10MB
- Document stored as status='staging' pending Super Admin approval
- SHA-256 hash computed for future diff comparison
- Audit log entry created for every upload attempt

Enables: Sprint 08 (OCR Pipeline)
Ref: Constitution O-3
```

Write a handoff note in the sprint document or as a code comment:

```
HANDOFF NOTE — Sprint 07
Completed: Document upload, file validation, staging storage, audit log
Not completed: OCR pipeline (Sprint 08), diff generation (Sprint 09)
Open risks: OCR.Space 1MB file limit may affect large PDFs
Technical debt: None
Next sprint: Sprint 08 — OCR Pipeline
```

---

*Commander v1.5 — IDSS123a Organisation*
