# ENGINEERING_RULES.md — Universal Engineering Standards
# Commander — Project Operating System
# Version 1.0 — June 2026

---

> These rules apply to every project under IDSS123a.
> Project-specific rules are in the project Constitution.
> When a project rule conflicts with this document, the project rule wins for that project.

---

## E-1. TypeScript

- `"strict": true` in every `tsconfig.json` — mandatory, no exceptions
- No `any` types — ever
- No `@ts-ignore` — ever
- No `as unknown as X` casts — if you need one, the design is wrong
- All shared types in `types/index.ts`
- All API shapes defined as Zod schemas in `lib/validation/schemas.ts`
- Every async function has an explicit return type annotation
- No implicit `undefined` returns

---

## E-2. Validation — Zod on Every Boundary

All inputs validated with Zod. All schemas in `lib/validation/schemas.ts`.
Never write inline validation logic. Never repeat a schema.

```typescript
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

---

## E-3. Forms

Use **React Hook Form** with **Zod Resolver** for all forms.

```typescript
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { LoginSchema } from '@/lib/validation/schemas';

const form = useForm({ resolver: zodResolver(LoginSchema) });
```

Never use uncontrolled native HTML forms for business logic forms.

---

## E-4. Security

| Requirement | Standard |
|---|---|
| Authentication | Defined per project. Default: email + password only. |
| Password hashing | bcrypt, cost factor minimum `12` |
| Sessions | HTTP-only cookie, `SameSite=Strict` |
| RBAC | Enforced at API/Server Action level. Never trust client-side role claims. |
| Input validation | Zod on every route and Server Action. Reject and log invalid inputs. |
| File validation | MIME type + extension whitelist + size limit on every upload |
| Secret management | `.env` only. Never commit. Never log. Never expose to client. |
| Service keys | Server-side only. Never in client bundle. Never in component files. |

---

## E-5. Error Handling

Every async operation must have a `try/catch`. No silent failures. Ever.

Every caught error must:
1. Log to server console: timestamp, location, message, stack
2. Log to `audit_log` table (for write operations)
3. Return a user-friendly message — never expose stack traces or internals to users

Standard response shapes — use these everywhere:

```typescript
// Error response
{ success: false, error: string, code?: string }

// Success response
{ success: true, data: T }
```

---

## E-6. API Routes and Server Actions

Every API route and Server Action must follow this exact sequence:

```
1. Authenticate    (is the user logged in?)
2. Authorise       (does their role permit this action?)
3. Validate        (Zod schema on request body)
4. Execute         (business logic)
5. Return          (standardised response shape)
```

Every API route must have a JSDoc comment block:

```typescript
/**
 * POST /api/documents/upload
 * Role required: admin, super_admin
 * Body: DocumentUploadSchema
 * Response: { success: true, data: { documentId: string, status: 'staging' } }
 * Errors: 401 (unauthenticated), 403 (wrong role), 422 (validation), 500 (server)
 */
```

---

## E-7. State Management

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

## E-8. Monitoring and Error Tracking

- **Sentry** for error tracking — install from project start, not as an afterthought
- **Project-specific LLM monitoring** — defined in each project Constitution
- Log at INFO level: significant user actions (login, document upload, quiz completion)
- Log at ERROR level: all caught exceptions with full context
- Never log: passwords, tokens, API keys, personal data

---

## E-9. Naming Conventions

| Element | Convention | Example |
|---|---|---|
| Files | kebab-case | `document-upload.ts` |
| React components | PascalCase | `QuizCard.tsx` |
| Functions | camelCase | `getActiveChunks()` |
| Constants | SCREAMING_SNAKE_CASE | `MAX_QUIZ_QUESTIONS` |
| Database tables | snake_case | `document_chunks` |
| Database columns | snake_case | `created_at` |
| CSS classes | kebab-case | `quiz-option-btn` |
| Environment variables | SCREAMING_SNAKE_CASE | `GEMINI_API_KEY_1` |
| Feature folders | kebab-case | `features/quiz-engine/` |

No abbreviations except: `req`, `res`, `id`, `url`, `api`, `db`.
Write `document` not `doc`. Write `chapter` not `chp`. Write `question` not `qst`.

---

## E-10. Documentation

Every new module must update these (where applicable):

- JSDoc on all exported functions and classes
- `schema-audit.md` if database schema changed
- `.env.example` if new environment variable added
- API JSDoc block on every new route or Server Action
- `constants/index.ts` for every new named constant
- `CHANGELOG.md` — one line per feature: `[DATE] [FEATURE] Description`
- `DECISION_LOG.md` if a significant technology or architecture choice was made

---

## E-11. Forbidden Patterns

Never do these without explicit written approval in the project `DECISION_LOG.md`:

| Pattern | Reason |
|---|---|
| Hardcoded hex/pixel values in component files | Use design tokens |
| Raw SQL repeated in multiple files | Use repository functions |
| `console.log` in production routes | Use structured logging |
| Magic numbers anywhere | Name them in `constants/index.ts` |
| Inline `style={{}}` for layout | Use Tailwind classes |
| `setTimeout` for logic flow control | Use proper async/await |
| Fetching data directly in a React component | Use Server Components or Server Actions |
| Business logic inside UI components | Move to domain layer |
| Skipping `.env.example` update | Always update when adding env vars |

---

*Commander v1.0 — IDSS123a Organisation*
