# PROMPT: Bug Fix
# Use this prompt when fixing a specific bug.

---

## Instructions for ACA

Read these documents before responding:

1. Commander Constitution:
   https://raw.githubusercontent.com/IDSS123a/commander/main/CONSTITUTION.md

2. Project Constitution:
   [INSERT PROJECT CONSTITUTION URL]

**Bug description:**
[DESCRIBE THE BUG HERE]

**Steps to reproduce:**
[LIST STEPS HERE]

**Expected behaviour:**
[WHAT SHOULD HAPPEN]

**Actual behaviour:**
[WHAT HAPPENS NOW]

**Relevant files:**
[LIST FILE PATHS IF KNOWN]

---

Fix the bug following these rules:
- Change only what is necessary to fix this bug
- Do not refactor unrelated code
- Do not change API contracts or database schema
- Do not introduce new libraries
- Write a clear commit message explaining what was fixed and why it broke
- Update CHANGELOG.md with one line: [DATE] [BUGFIX] Description
