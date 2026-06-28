# FEATURE_LIFECYCLE.md — Universal Feature Build Process
# Commander — Project Operating System
# Version 1.0 — June 2026

---

Every feature follows this 7-step lifecycle without exception.

**Scope by size:**
- Small bug fix (single-line change): Steps 4–7 only
- UI-only change (no data or logic): Steps 3–7 only
- New feature or module: All 7 steps

---

## Step 1 — ANALYSIS

Before touching the keyboard, answer these questions:

- What is the institutional purpose of this feature?
- Which Constitution section governs it?
- Which database tables does it touch?
- Which API routes or Server Actions does it require?
- Which UI components does it need?
- What does this feature explicitly NOT do? (scope boundary)

If you cannot answer all of these: STOP and ask.

---

## Step 2 — PLAN

Write a brief plan as a comment block in the feature's main file:

```typescript
/**
 * FEATURE: Document Upload Pipeline
 * PURPOSE: Allow Admin to upload institutional documents for Super Admin approval
 * TOUCHES: documents table, Supabase Storage bucket 'staging-documents'
 * ROUTES: POST /api/documents/upload, GET /api/documents/:id/status
 * SERVER ACTIONS: uploadDocument(), getDocumentStatus()
 * OUT OF SCOPE: OCR (Sprint 08), RAG indexing (triggered post-approval)
 * SPRINT: 07
 * CONSTITUTION REF: O-3 (Document Upload Pipeline)
 */
```

Confirm the plan matches the Constitution before writing any code.
If the plan contradicts the Constitution: the Constitution wins.

---

## Step 3 — IMPLEMENTATION ORDER

Build strictly in this order. Never jump ahead.

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

*Commander v1.0 — IDSS123a Organisation*
