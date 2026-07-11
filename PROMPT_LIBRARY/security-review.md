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

Report each finding as: PASS / FAIL / WARN with specific file and line reference.
