# PROMPT: Security Review
# Use this prompt before any deployment or after adding auth/permissions features.

---

## Instructions for ACA

Read these documents before responding:

1. Commander Engineering Rules (Section E-4 — Security):
   https://raw.githubusercontent.com/IDSS123a/commander/main/ENGINEERING_RULES.md

2. Project Constitution:
   [INSERT PROJECT CONSTITUTION URL]

**Scope of review:**
[SPECIFY: entire app / specific feature / specific files]

---

Review specifically for:

**Authentication:**
- [ ] Every protected route checks for valid session before executing
- [ ] Session validation happens server-side, not client-side

**Authorisation:**
- [ ] Every route checks user role after authentication
- [ ] All permission checks use `lib/permissions.ts` (no inline role checks)
- [ ] Client UI hides options, but API enforces them

**Data exposure:**
- [ ] No secrets, tokens, or API keys in client-side code
- [ ] No Supabase service role key in standard routes
- [ ] No raw error messages or stack traces returned to users
- [ ] No sensitive data in console.log statements

**Input validation:**
- [ ] All API inputs validated with Zod before use
- [ ] All file uploads check MIME type, extension, and size
- [ ] All file uploads verify actual content (magic bytes), not just reported MIME type
- [ ] No user-provided data used in database queries without sanitisation

**Outbound content:**
- [ ] User-controlled text in outbound email bodies is HTML-escaped
- [ ] User-controlled text in outbound email SUBJECT lines has embedded `\r\n` stripped
- [ ] Every admin/error response returns the precise status code (404/409/403) for anticipatable failures, not a generic 500
- [ ] If the auth provider supports "ban"/"disable": confirmed and documented whether it invalidates already-issued tokens immediately or only blocks new logins

**Environment:**
- [ ] No hardcoded credentials anywhere in code
- [ ] `.env.example` does not contain real values

**Database — Row Level Security (Supabase):**
- [ ] RLS is ENABLED on every table before deployment; default policy denies all
- [ ] Every policy is owner-scoped (`auth.uid()`) — never `USING (true)` or `FOR ALL` without a WHERE/ownership condition
- [ ] Firebase rules (if used) require `request.auth != null` and scope to `request.auth.uid`

**Object-level access control (IDOR):**
- [ ] Every route/action taking a resource ID verifies the authenticated user OWNS that resource (`user.id == resource.owner_id`) — SEPARATE from the auth + role checks above

**Client-bundled secrets:**
- [ ] No secret in any `NEXT_PUBLIC_`, `VITE_`, or `REACT_APP_` variable — these are compiled into the browser bundle

**Network boundary:**
- [ ] CORS uses an explicit domain allowlist, never `*`
- [ ] Security headers set at the edge/framework (at least CSP, `X-Content-Type-Options`, `X-Frame-Options`)
- [ ] Any server-side fetch of a user-supplied URL is validated against an allowlist (no internal / `169.254.169.254` metadata targets) — SSRF

**Abuse resistance:**
- [ ] Login, registration, and password-reset endpoints are rate-limited (block after N failures per IP/window); don't trust `X-Forwarded-For` unless behind a trusted proxy
- [ ] Payment/webhook endpoints verify the provider signature; amounts and ownership are re-checked server-side, never trusted from the client

Report each finding as: PASS / FAIL / WARN with specific file and line reference.
