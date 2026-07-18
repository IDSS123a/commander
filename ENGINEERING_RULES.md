# ENGINEERING_RULES.md — Universal Engineering Standards
# Commander — Project Operating System
# Version 1.2 — July 2026

---

> These rules apply to every project under IDSS123a.
> Project-specific rules are in the project Constitution.
> When a project rule conflicts with this document, the project rule wins for that project.
>
> **Severity:** 🔴 CRITICAL  🟡 STANDARD  🟢 PREFERRED
> **Status:** `[ACTIVE]` `[DEPRECATED: reason, date]` `[SUPERSEDED BY E-XX]`

---

## E-1. TypeScript `[ACTIVE]` 🔴 CRITICAL

- `"strict": true` in every `tsconfig.json` — mandatory, no exceptions
- No `any` types — ever
- No `@ts-ignore` — ever
- No `as unknown as X` casts — if you need one, the design is wrong
- All shared types in `types/index.ts`
- All API shapes defined as Zod schemas in `lib/validation/schemas.ts`
- Every async function has an explicit return type annotation
- No implicit `undefined` returns
- When narrowing a discriminated union parsed from an API response
  (e.g. `{ deleted: true } | { deleted: false; blockers: X }`),
  use an explicit literal comparison — `if (result.deleted === false)` — never `if (!result.deleted)`. The negation form has been observed
  to fail to narrow the union correctly in some TS configurations,
  leaving the discriminant field typed as possibly undefined even
  after the check.

---

## E-2. Validation — Zod on Every Boundary `[ACTIVE]` 🔴 CRITICAL

All inputs validated with Zod. All schemas in `lib/validation/schemas.ts`.
Never write inline validation logic. Never repeat a schema.

```
// Correct
import { DocumentUploadSchema } from '@/lib/validation/schemas';
const result = DocumentUploadSchema.safeParse(body);
if (!result.success) return { success: false, error: result.error.message };

// Never
if (!body.name || body.name.length > 100) { ... }
```

Zod validates at every system boundary:

- API route inputs
- Server Action inputs
- Form submissions (with React Hook Form + Zod Resolver)
- External API responses (parse before trusting)

**Known pitfall (Zod 3.25.x):** `.default()` fields make `z.infer<>` mark that field — and sometimes sibling fields in
nested array objects with no default of their own — as optional
in the inferred type, even though `.safeParse()` guarantees the
value is present at runtime. If this version is in use: hand-write
the TypeScript interface instead of `z.infer<>`, use the Zod schema
purely for runtime validation, and cast `parsed.data as ManualType` once, immediately after the success check. Otherwise: pin Zod below
3.25, or confirm the bug is fixed in whatever version is current.

---

## E-3. Forms `[ACTIVE]` 🟡 STANDARD

Use **React Hook Form** with **Zod Resolver** for all forms.

```
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { LoginSchema } from '@/lib/validation/schemas';

const form = useForm({ resolver: zodResolver(LoginSchema) });
```

Never use uncontrolled native HTML forms for business logic forms.

---

## E-4. Security `[ACTIVE]` 🔴 CRITICAL

| Requirement               | Standard                                                                                                                                                                                                 |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Authentication            | Defined per project. Default: email + password only.                                                                                                                                                     |
| Password hashing          | bcrypt, cost factor minimum `12`                                                                                                                                                                         |
| Sessions                  | HTTP-only cookie, `SameSite=Strict`                                                                                                                                                                      |
| RBAC                      | Enforced at API/Server Action level. Never trust client-side role claims.                                                                                                                                |
| Input validation          | Zod on every route and Server Action. Reject and log invalid inputs.                                                                                                                                     |
| File validation           | MIME type + extension whitelist + size limit on every upload                                                                                                                                             |
| File content verification | MIME type from the client is a claim, not a fact — verify actual file content (magic bytes) matches the claimed type before storing, not just the reported Content-Type/extension.                       |
| Outbound email content    | Any user-controlled free text (title, name, message body) embedded in an outbound HTML email MUST be HTML-escaped before insertion. Any user-controlled text placed in an email SUBJECT line must have embedded `\r\n` stripped (defense-in-depth even if the mail provider's API already sanitizes it). Write this as one shared helper, not re-implemented per feature. |
| Secret management         | `.env` only. Never commit. Never log. Never expose to client.                                                                                                                                            |
| Service keys              | Server-side only. Never in client bundle. Never in component files.                                                                                                                                      |

**Confirmed-safe RBAC pattern:** resolve role via a server-side profile
lookup keyed by the verified auth-provider user id, on every request —
never decode a role from the JWT payload or trust a header. Verify
this live: a forged/garbage token, a token for a different role, and
direct route calls bypassing the UI must all be correctly rejected
because role never came from client-supplied data.

**Known limitation to disclose, not silently accept:** banning/
disabling a user via most auth providers (Supabase Auth included)
blocks new logins immediately but does NOT invalidate an
already-issued access token — it remains valid until its natural
expiry (often ~1h), because ban status is checked at token issuance,
not on every verification. Document this in the project Constitution
and surface it in the admin UI rather than building a custom
revocation blocklist, unless the project's risk profile specifically
requires instant cutoff.

---

## E-5. Error Handling `[ACTIVE]` 🔴 CRITICAL

Every async operation must have a `try/catch`. No silent failures. Ever.

Every caught error must:

1. Log to server console: timestamp, location, message, stack
2. Log to `audit_log` table (for write operations)
3. Return a user-friendly message — never expose stack traces or internals to users

Standard response shapes — use these everywhere:

```
// Error response
{ success: false, error: string, code?: string }

// Success response
{ success: true, data: T }
```

A caught error is not "handled" just because it doesn't crash the
server. Before falling back to a generic 500, check for the specific,
anticipatable failure reasons — resource not found (404), conflicting/
duplicate state (409), permission denied (403) — and return the
precise status with a specific message. Generic 500 should mean
"truly unexpected," not "an admin acted on a stale ID" or "tried to
reuse an email that already exists."

---

## E-6. API Routes and Server Actions `[ACTIVE]` 🔴 CRITICAL

Every API route and Server Action must follow this exact sequence:

```
1. Authenticate    (is the user logged in?)
2. Authorise       (does their role permit this action?)
3. Validate        (Zod schema on request body)
4. Execute         (business logic)
5. Return          (standardised response shape)
```

Every API route must have a JSDoc comment block:

```
/**
 * POST /api/documents/upload
 * Role required: admin, super_admin
 * Body: DocumentUploadSchema
 * Response: { success: true, data: { documentId: string, status: 'staging' } }
 * Errors: 401 (unauthenticated), 403 (wrong role), 422 (validation), 500 (server)
 */
```

---

## E-7. State Management `[ACTIVE]` 🟡 STANDARD

Follow this priority order. Only descend when the level above is insufficient.

```
1. Server state in Server Components      (no client JS needed)
2. Server Actions                         (mutations, form submissions)
3. React Context                          (shared UI state across components)
4. useState / useReducer                  (local component state)
```

Never use Redux, MobX, or Zustand without explicit written approval
in the project `DECISION_LOG.md`.

---

## E-8. Monitoring and Error Tracking `[ACTIVE]` 🟡 STANDARD

- **Sentry** for error tracking — install from project start, not as an afterthought
- **Project-specific LLM monitoring** — defined in each project Constitution
- Log at INFO level: significant user actions (login, document upload, quiz completion)
- Log at ERROR level: all caught exceptions with full context
- Never log: passwords, tokens, API keys, personal data

---

## E-9. Naming Conventions `[ACTIVE]` 🟢 PREFERRED

| Element               | Convention             | Example                 |
| --------------------- | ---------------------- | ----------------------- |
| Files                 | kebab-case             | `document-upload.ts`    |
| React components      | PascalCase             | `QuizCard.tsx`          |
| Functions             | camelCase              | `getActiveChunks()`     |
| Constants             | SCREAMING\_SNAKE\_CASE | `MAX_QUIZ_QUESTIONS`    |
| Database tables       | snake\_case            | `document_chunks`       |
| Database columns      | snake\_case            | `created_at`            |
| CSS classes           | kebab-case             | `quiz-option-btn`       |
| Environment variables | SCREAMING\_SNAKE\_CASE | `GEMINI_API_KEY_1`      |
| Feature folders       | kebab-case             | `features/quiz-engine/` |

No abbreviations except: `req`, `res`, `id`, `url`, `api`, `db`.
Write `document` not `doc`. Write `chapter` not `chp`. Write `question` not `qst`.

---

## E-10. Documentation `[ACTIVE]` 🟡 STANDARD

Every new module must update these (where applicable):

- JSDoc on all exported functions and classes
- `schema-audit.md` if database schema changed
- `.env.example` if new environment variable added
- API JSDoc block on every new route or Server Action
- `constants/index.ts` for every new named constant
- `CHANGELOG.md` — one line per feature: `[DATE] [FEATURE] Description`
- `DECISION_LOG.md` if a significant technology or architecture choice was made

**Commit messages follow Conventional Commits:**
`feat:` / `fix:` / `chore:` / `docs:` / `refactor:`
Max 72 characters. No period at end. Do not deliberate — apply mechanically.

---

## E-11. Forbidden Patterns `[ACTIVE]` 🟡 STANDARD

Never do these without explicit written approval in the project `DECISION_LOG.md`:

| Pattern                                       | Reason                                  |
| --------------------------------------------- | --------------------------------------- |
| Hardcoded hex/pixel values in component files | Use design tokens                       |
| Raw SQL repeated in multiple files            | Use repository functions                |
| `console.log` in production routes            | Use structured logging                  |
| Magic numbers anywhere                        | Name them in `constants/index.ts`       |
| Inline `style={{}}` for layout                | Use Tailwind classes                    |
| `setTimeout` for logic flow control           | Use proper async/await                  |
| Fetching data directly in a React component   | Use Server Components or Server Actions |
| Business logic inside UI components           | Move to domain layer                    |
| Skipping `.env.example` update                | Always update when adding env vars      |

---

## E-12. Environment Gotchas (learned the hard way) `[ACTIVE]` 🟡 STANDARD

- **Never name a server's port env var bare `PORT`.** Some dev/
  hosting sandboxes export a global `PORT` for the primary web
  process — a second process (e.g. an API server alongside a Vite
  dev server) binding the same name collides. Use a distinct name
  (`API_PORT`) for any secondary process; let the real deploy
  target's assigned `PORT` take priority only in production.
- **npm scripts may run through `cmd.exe`, not bash**, depending on
  the launching tool/OS. Inline `VAR=value command` syntax fails
  silently there. Use `cross-env VAR=value command` in any script
  that sets an environment variable.
- **`UNABLE_TO_VERIFY_LEAF_SIGNATURE` on outbound HTTPS** from a
  Node process launched inside certain sandboxes (proxy/AV doing
  TLS interception the OS trusts but Node's bundled CA store
  doesn't) — fix with `NODE_OPTIONS=--use-system-ca` (Node ≥22.9).
- **Anything a production script invokes (`npm run start`, cron
  workers, build tools like `tsx`/`cross-env` themselves) must be
  listed in `dependencies`, never `devDependencies`.** Local dev
  never notices because local `npm install` installs both — this
  is invisible until a real production platform runs
  `npm install --omit=dev` and every deploy fails. Verify by
  actually running `npm install --omit=dev && npm run start` locally before trusting a deploy config — reusing an
  already-populated `node_modules` will never surface this.

---

*Commander v1.2 — IDSS123a Organisation*
