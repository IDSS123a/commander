# PROMPT: Code Review
# Use this prompt to review code written in a previous session.

---

## Instructions for ACA

Read these documents before responding:

1. Commander Constitution:
   https://raw.githubusercontent.com/IDSS123a/commander/main/CONSTITUTION.md

2. Commander Engineering Rules:
   https://raw.githubusercontent.com/IDSS123a/commander/main/ENGINEERING_RULES.md

3. Commander Architecture Patterns:
   https://raw.githubusercontent.com/IDSS123a/commander/main/ARCHITECTURE_PATTERNS.md

4. Commander Done Checklist:
   https://raw.githubusercontent.com/IDSS123a/commander/main/DONE_CHECKLIST.md

5. Project Constitution:
   [INSERT PROJECT CONSTITUTION URL]

**Code to review:**
[PASTE CODE OR SPECIFY FILE PATHS]

---

Review the code against:
1. Every item in DONE_CHECKLIST.md
2. Architecture patterns from ARCHITECTURE_PATTERNS.md
3. Engineering rules from ENGINEERING_RULES.md
4. Project-specific rules from the project Constitution

Report findings in this format:
- PASS: [item that is correct]
- FAIL: [item that violates a rule] → [specific fix required]
- WARN: [potential issue that needs attention]

Do not suggest changes unrelated to the rules. Do not rewrite working code
that already follows the rules.
