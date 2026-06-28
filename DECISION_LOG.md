# DECISION_LOG.md — Universal Technology Decisions
# Commander — Project Operating System
# Version 1.0 — June 2026

---

> This document records WHY we chose specific technologies and patterns.
> It is never deleted. Old decisions are marked [SUPERSEDED] if overridden.
> Every ACA must read this before proposing alternatives.
> To override a decision: add a new entry below the original, mark original [SUPERSEDED].

---

## DL-001 — Database ORM: Supabase Client (not Drizzle ORM)

**Date:** 2026-06-28
**Decision:** Use Supabase's native type-safe client directly. Do not introduce Drizzle ORM.
**Rationale:**
Supabase generates TypeScript types directly from the database schema (`supabase gen types`).
Adding Drizzle would create two abstraction layers over the same database that must be kept
in sync. For projects deeply integrated into the Supabase ecosystem (Auth, Storage, Realtime,
pgvector, RLS), this adds complexity without benefit.
Drizzle has merit in projects using raw PostgreSQL without Supabase. Not here.
**Upgrade path:** If we ever move off Supabase, migrate to Drizzle at that point.

---

## DL-002 — Document Processing: OCR.Space (not Docling/Unstructured)

**Date:** 2026-06-28
**Decision:** Use OCR.Space REST API for document text extraction.
**Rationale:**
Docling and Unstructured are Python libraries requiring a Python server or Docker container —
a separate deployment from the Next.js/Vercel stack. This adds operational complexity that
is not justified for a non-coder operating with free ACA tools.
OCR.Space is a REST API: send a file, receive text. Works inside Vercel serverless functions.
25,000 requests/month free tier is sufficient for IDSS Handbook document volume.
**Upgrade path:** Migrate to Docling when: (a) we have Python infrastructure, or (b) OCR.Space
quality is insufficient for specific document types.
**Known limit:** OCR.Space has a 1MB per file limit. Large PDFs must be split before processing.

---

## DL-003 — Deployment: Vercel (not Google Cloud Run)

**Date:** 2026-06-28
**Decision:** Deploy all projects on Vercel.
**Rationale:**
Google Cloud Run requires Docker, Artifact Registry, IAM configuration, Cloud Build or
GitHub Actions pipeline, and billing setup. For a non-coder team using free ACA tools,
this represents weeks of infrastructure work before any application code ships.
Vercel deploys a Next.js app with one `git push`. The operational simplicity outweighs
the theoretical flexibility of Cloud Run at this stage.
**Upgrade path:** Migrate to Cloud Run when: (a) Vercel free tier limits are exceeded,
or (b) a specific feature requires persistent server processes Vercel cannot support.

---

## DL-004 — State Management: Server-first (not Redux/MobX/Zustand)

**Date:** 2026-06-28
**Decision:** Use Server Components → Server Actions → React Context → useState.
Never use Redux, MobX, or Zustand unless a specific, documented case requires it.
**Rationale:**
Next.js App Router with React Server Components eliminates the need for global client
state managers in the vast majority of cases. Server state belongs on the server.
Client state managers add bundle size, complexity, and ACA confusion with no benefit
when Server Components are available.

---

## DL-005 — AI Provider: Gemini as Default with Provider Interface

**Date:** 2026-06-28
**Decision:** Use Gemini (`gemini-2.5-flash`) as the default AI provider.
Wrap all AI calls behind an `AIProvider` interface in `lib/ai/`.
**Rationale:**
Gemini's free tier (8 API keys × 15 RPM = ~120 RPM effective) is sufficient for
institutional use. The Provider Interface means swapping to Claude, OpenAI, or any
other provider requires only a new implementation class — zero changes to business logic.
**Current model strings:**
- Generation: `gemini-2.5-flash` (exact string, no other version)
- Embeddings: `text-embedding-004` (exact string, dimension: 768)

---

## DL-006 — Monitoring: Sentry + LLM-specific tools

**Date:** 2026-06-28
**Decision:** Use Sentry for general error tracking. Use project-specific LLM monitoring
(Maxim AI, Langtrace) for AI observability. Do not use OpenTelemetry at this stage.
**Rationale:**
Sentry is practical and free for this scale. OpenTelemetry is an enterprise distributed
tracing standard — appropriate for multi-service architectures, premature here.
LLM monitoring tools (Maxim AI, Langtrace) are purpose-built for tracking token usage,
response quality, and hallucination rates — things Sentry does not cover.

---

## DL-007 — Forms: React Hook Form + Zod Resolver

**Date:** 2026-06-28
**Decision:** Use React Hook Form with Zod Resolver for all forms.
**Rationale:**
Standard, well-understood pattern. All ACAs generate it correctly. Integrates natively
with our Zod validation schema pattern. Reduces form boilerplate significantly.

---

## DL-008 — Folder Structure: Feature-based (not type-based)

**Date:** 2026-06-28
**Decision:** Organise code by feature (`features/documents/`), not by type (`components/`).
**Rationale:**
Feature-based organisation means everything related to a feature is co-located.
An ACA opening the codebase for the first time immediately knows where to find and
add code for any feature. Type-based organisation forces ACA to hunt across multiple
folders for related code, increasing the chance of inconsistencies and mistakes.

---

*Commander v1.0 — IDSS123a Organisation*
