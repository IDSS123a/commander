# ARCHITECTURE_PATTERNS.md — Universal Structural Rules
# Commander — Project Operating System
# Version 1.1 — July 2026

---

## A-1. The Five Layers

Every project under IDSS123a uses this exact architecture.
Each feature belongs to exactly one layer. Never mix layers.

```
┌─────────────────────────────────────────┐
│  PRESENTATION                           │
│  React components, pages, UI, forms     │
├─────────────────────────────────────────┤
│  APPLICATION                            │
│  Server Actions, API routes,            │
│  orchestration, session, middleware     │
├─────────────────────────────────────────┤
│  DOMAIN                                 │
│  Business rules, permissions,           │
│  feature logic, validation schemas      │
├─────────────────────────────────────────┤
│  INFRASTRUCTURE                         │
│  Database repositories,                 │
│  external API clients, storage,         │
│  email, AI provider interface           │
├─────────────────────────────────────────┤
│  EXTERNAL SERVICES                      │
│  Supabase, Gemini, Resend,              │
│  OCR.Space, Sentry, Vercel...           │
└─────────────────────────────────────────┘
```

**Dependency direction is strictly top-down:**
- Presentation may call Application
- Application may call Domain and Infrastructure
- Domain must not know that Next.js exists
- Infrastructure must not contain business logic
- External Services are only called from Infrastructure

**Concrete enforcement rule:**
A React component must never directly query the database.
```
React Component
  → calls Server Action or API route        (Application)
    → calls repository function             (Infrastructure)
      → reads from Supabase                 (External)
```

> **Express stack equivalent (see M-16, DL-009):**
>
> The five layers remain identical. Only the Application layer changes:
> - Server Actions → Express route handlers in `server/routes/`
> - Next.js middleware → Express middleware in `server/middleware/`
> - Server Components → not applicable (Vite SPA fetches via API)
>
> Dependency direction is still strictly top-down:
> ```
> React SPA (Vite)
>   → calls Express API route                (Application)
>     → calls repository function            (Infrastructure)
>       → reads from Supabase                (External)
> ```

---

## A-2. Feature-Based Folder Structure

```
features/
  [feature-name]/
    components/       UI components specific to this feature
    actions.ts        Server Actions for this feature
    repository.ts     All database queries for this feature
    domain.ts         Business rules and logic
    schemas.ts        Zod validation schemas
    types.ts          TypeScript types for this feature
    hooks.ts          Custom React hooks (client-side)
    constants.ts      Feature-specific constants
```

**Shared (cross-feature) resources go here:**
```
lib/
  ai/                 AI provider interface and implementations
  db/                 Supabase client (server + browser)
  email/              Resend client
  validation/         Shared Zod schemas
  permissions.ts      RBAC permission checks (single source of truth)

constants/
  index.ts            All global named constants

types/
  index.ts            All shared TypeScript types

components/
  ui/                 Shadcn/ui components (never modify directly)
```

> **Express stack equivalent (see M-16, DL-009):**
> ```
> src/                          ← Vite SPA (Presentation)
>   features/
>     [feature-name]/
>       components/
>       hooks.ts
>       types.ts
>       constants.ts
>
> server/                       ← Express backend (Application + Infrastructure)
>   features/
>     [feature-name]/
>       routes.ts               ← Express route handlers (replaces actions.ts)
>       repository.ts           ← Database queries (identical pattern)
>       domain.ts               ← Business rules (identical pattern)
>       schemas.ts              ← Zod validation (identical pattern)
>   middleware/
>     auth.ts                   ← Authentication middleware
>     permissions.ts            ← RBAC checks (identical to lib/permissions.ts)
>   lib/
>     db/                       ← Supabase client (server-only)
> ```

---

## A-3. Database Repository Pattern

Every feature has its own `repository.ts`. All database queries live there.
Never write database queries in Server Actions, API routes, or components.

```typescript
// features/documents/repository.ts

/**
 * Get all active documents ordered by creation date descending
 */
export async function getActiveDocuments(): Promise<Document[]> {
  const { data, error } = await supabase
    .from('documents')
    .select('*')
    .eq('status', 'active')
    .order('created_at', { ascending: false });

  if (error) throw new Error(`getActiveDocuments failed: ${error.message}`);
  return data;
}
```

Repository functions:
- Are pure functions (input → output, no side effects beyond DB)
- Throw errors with descriptive messages (never swallow)
- Never contain business logic (that belongs in `domain.ts`)
- Are imported only by Server Actions and API routes

> **Express stack equivalent:** Repository functions are imported
> only by Express route handlers in `server/features/[name]/routes.ts`.
> The pattern, naming, and error handling are identical.

---

## A-4. Permissions Pattern

All permission checks live in `lib/permissions.ts`. Single source of truth.
Never write permission logic inline in routes or components.

```typescript
// lib/permissions.ts

export function canActivateDocument(role: UserRole): boolean {
  return role === 'super_admin';
}

export function canUploadDocument(role: UserRole): boolean {
  return role === 'admin' || role === 'super_admin';
}

export function canViewAllProgress(role: UserRole): boolean {
  return role === 'admin' || role === 'super_admin';
}
```

Every API route and Server Action imports from here:

```typescript
import { canUploadDocument } from '@/lib/permissions';

if (!canUploadDocument(session.user.role)) {
  return { success: false, error: 'Nedovoljno prava pristupa.', code: 'FORBIDDEN' };
}
```

**Ownership-based checks need the same treatment as role checks.**
When permission depends on *who created* a record (not just role),
extract a small pure function — `canEditRecord(profile, record)` —
and call it identically on both client (to hide/disable controls)
and server (to actually enforce). Without this, buttons render as
clickable for records the user cannot actually edit, and the
server silently 403s.

---

## A-5. AI Provider Interface

The AI layer is always behind an interface. Never call an AI SDK directly
from business logic or UI code.

```typescript
// lib/ai/ai-provider.interface.ts

export interface AIProvider {
  generate(prompt: string, system: string, options: GenerateOptions): Promise<GenerateResult>;
  embed(texts: string[], taskType: EmbedTaskType): Promise<EmbedResult>;
}

export type GenerateOptions = {
  maxTokens: 512 | 2048 | 8192;
  temperature: 0.3 | 0.7;
};

export type EmbedTaskType = 'RETRIEVAL_DOCUMENT' | 'RETRIEVAL_QUERY';
```

Swapping AI providers:
1. Create new class implementing `AIProvider`
2. Update `AI_PROVIDER` in `.env`
3. Update `lib/ai/ai-provider.factory.ts`
4. Zero changes to any business logic or UI

---

## A-6. Database Migration Pattern

Every schema change is a numbered SQL file in `/migrations/`.

```
migrations/
  001_initial_schema.sql
  002_add_pgvector_extension.sql
  003_add_document_chunks.sql
  004_add_user_progress.sql
```

Every migration file must begin with:

```sql
-- Migration: 003_add_document_chunks
-- Date: 2026-06-28
-- Author: ACA (Windsurf / Claude / Cursor)
-- Description: Add document_chunks table for RAG pipeline embeddings
-- Rollback: DROP TABLE document_chunks;
```

Rules:
- One migration per logical change
- Never modify a migration after it has been applied
- Never drop a column without explicit written Director approval
- Always include a rollback comment

---

## A-7. Environment Variables Pattern

All secrets and configuration in `.env`. Never in code.

`.env` is never committed to GitHub.
`.env.example` is always committed — with placeholder values only.

```env
# .env.example — commit this
# .env — NEVER commit this

# Supabase
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url_here
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_anon_key_here
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key_here

# AI Provider (Gemini default)
AI_PROVIDER=gemini
GEMINI_API_KEY_1=your_key_here
...
```

When adding a new environment variable:
1. Add to `.env` (real value)
2. Add to `.env.example` (placeholder value)
3. Add to `CHANGELOG.md`: `[DATE] [ENV] Added VARIABLE_NAME for X purpose`

---

## A-8. Supabase Client Pattern

Two clients — never mix them:

```typescript
// lib/db/supabase.ts — SERVER ONLY
// Used in: Server Components, Server Actions, API routes, repository functions
import { createServerClient } from '@supabase/ssr';

// lib/db/supabase-browser.ts — CLIENT ONLY
// Used in: Client Components that need real-time subscriptions
import { createBrowserClient } from '@supabase/ssr';
```

The service role key (`SUPABASE_SERVICE_ROLE_KEY`) is used only in:
- Background jobs (QStash handlers)
- Admin operations that bypass Row Level Security

Never use the service role key in client-side code.
Never use the service role key in standard API routes.

> **Express stack equivalent:** There is no browser client. The Vite
> SPA calls the Express API; the Express API uses a single server
> Supabase client created once in `server/lib/db/supabase.ts`.
> The service role key restriction remains identical.

---

## A-9. Memoize Derived Values Used as Effect Dependencies

Any array/object computed fresh in a component body (`.filter()`,
`.sort()`, `{ ...spread }`) is a NEW reference on every render. If
that value is used as a `useEffect` dependency — especially one
whose body calls a parent state-setter — the effect fires on every
render, including unrelated ones, and can produce an unbounded
render loop that a screenshot will not reveal (React's internal
safety cutoff prevents an actual freeze, but the console logs
"Maximum update depth exceeded" and CPU is wasted continuously).

Rule: wrap any derived array/object with `useMemo` before using it
as an effect dependency or passing it to a callback that updates
state elsewhere. Verify by checking the browser console at error
level after any interaction that changes unrelated local state —
see `DONE_CHECKLIST.md`.

*Learned from web-app-chronos: an unmemoized filtered/sorted list fed
a `useEffect` that synced print-view state to a parent — the loop ran
silently on every single page load for months, undetected because two
earlier stress-test passes checked network calls and screenshots but
never the console.*

---

## A-10. Pre-Check Deletion Blockers, Never Loosen Audit FK Rules

When an entity (typically a user) has `ON DELETE NO ACTION`
foreign keys from audit/history tables — which is correct and
should stay `NO ACTION`, since audit trails must be permanent —
deleting that entity will fail at the database level the moment
any referencing row exists. Do not "fix" this by changing the
delete rule to CASCADE or SET NULL.

Instead: before attempting the delete, query every table with such
a reference for a non-zero count, and if any exist, return a
specific blocked response (which tables, how many rows) instead of
a raw database error — and offer a reversible alternative (e.g.
ban/disable instead of delete) in the same response.

---

*Commander v1.1 — IDSS123a Organisation*
