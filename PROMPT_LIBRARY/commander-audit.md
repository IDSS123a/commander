# Commander Audit — Prompt Template

> **Usage:** Once per year, or after every 5 completed projects
> (whichever comes first), give this prompt to the ACA.
> See M-19 in CONSTITUTION.md.

---

## Prompt

```
Conduct a Commander Audit per M-19. Read all Commander documents at:
https://github.com/IDSS123a/commander

For EVERY rule across all documents (M-1 to M-XX, E-1 to E-XX, C-1 to C-XX):

1. STATUS CHECK: Is this rule still [ACTIVE]? Has the ecosystem changed
   (library versions, APIs, frameworks) in a way that makes it outdated?

2. USAGE CHECK: Based on the corrections/ folders across these project
   repositories, was this rule triggered in the last 3 projects?
   [List project repos to check]

3. SEVERITY CHECK: Is the current severity level (🔴/🟡/🟢) still
   accurate? Should any STANDARD rule be upgraded to CRITICAL based
   on repeated violations? Should any rule be downgraded?

4. OVERLAP CHECK: Does this rule overlap with another rule? Can they
   be consolidated?

5. DEPRECATION CHECK: Should this rule be deprecated (M-17)?
   If yes: what is the reason and what replaces it?

After reviewing all rules, produce:

AUDIT REPORT:
- Rules confirmed [ACTIVE] with no changes: [count]
- Rules with updated severity: [list with old → new]
- Rules deprecated: [list with reason]
- Rules consolidated: [list showing which merged into which]
- New rules suggested: [list with rationale]
- AUDIT_LOG.md entry: [ready to append]

Wait for Director approval before making any changes.
```

---

## Projects to Include in the Audit

Update this list as projects complete:

```
- https://github.com/IDSS123a/web-app-idss-handbook
- https://github.com/IDSS123a/web-app-chronos
- [add new projects as they complete]
```

---

## Post-Audit Checklist

After the Director approves the audit findings:

- [ ] CONSTITUTION.md updated (deprecated/new/modified rules)
- [ ] ENGINEERING_RULES.md updated
- [ ] ACA_COMMUNICATION_PROTOCOL.md updated
- [ ] AUDIT_LOG.md entry appended with full details
- [ ] README.md version history updated
- [ ] All changes committed with: `chore: Commander Audit [date]`

---

*Commander v1.1 — IDSS123a Organisation*
