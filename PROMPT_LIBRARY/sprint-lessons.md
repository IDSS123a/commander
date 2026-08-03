# Sprint Lessons — Prompt Template

> **Usage:** At the end of every sprint, give this prompt to the ACA.
> The ACA creates `corrections/SPRINT_XX_LESSONS.md` in the project repository.
> This file persists in the filesystem, independent of ACA session memory.

---

## Prompt

```
This sprint is complete. Before writing the handoff note, create
(or update) the file corrections/SPRINT_[NUMBER]_LESSONS.md with
the following structure:

# Sprint [NUMBER] — Lessons Learned
Date: [today's date]

## Corrections Applied
For each correction made during this sprint:
- What was wrong → What was fixed → Which Commander rule was relevant (M-XX / E-XX / C-XX)

## Gotchas Discovered
For each unexpected behaviour, environment issue, or tooling trap:
- What happened → Root cause → How it was resolved

## Commander Improvement Candidates
For each suggestion to improve Commander:
- Which document → Which rule (or new rule) → What should change → Why

If no items exist in a section, write "None this sprint."

Then proceed with the standard handoff note and Done Checklist.
```

---

## Why This Exists

ACA session memory is compressed during long projects. Lessons from
early sprints may be lost by the time the Director asks "update
Commander" at project end. This template ensures every lesson is
captured in a persistent file immediately after it's learned.

At project end, the final command references these files:

```
Read all files in corrections/ and update the Commander repository
(https://github.com/IDSS123a/commander) with all applicable
improvements. Follow the deprecation protocol (M-17) for any
rules that need updating.
```

---

*Commander v1.1 — IDSS123a Organisation*
