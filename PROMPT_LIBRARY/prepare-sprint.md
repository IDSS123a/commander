# PROMPT: Prepare Next Sprint
# Use this prompt to plan the next sprint based on current state.

---

## Instructions for ACA

Read these documents before responding:

1. Commander Constitution:
   https://raw.githubusercontent.com/IDSS123a/commander/main/CONSTITUTION.md

2. Project Constitution:
   [INSERT PROJECT CONSTITUTION URL]

3. Project Feature Backlog:
   [INSERT FEATURE_BACKLOG URL]

4. Project Changelog:
   [INSERT CHANGELOG URL]

5. Previous Sprint (for handoff notes):
   [INSERT PREVIOUS SPRINT URL]

---

Based on what has been completed (CHANGELOG) and what remains (FEATURE_BACKLOG),
prepare the next sprint document in this exact format:

```markdown
# SPRINT_XX — [Feature Name]
# [Project Name]
# Date: [DATE]

## Goal
One sentence describing what this sprint achieves.

## Scope — IN
- Specific item 1
- Specific item 2

## Scope — OUT (do not build in this sprint)
- Item being deferred
- Item being deferred

## Acceptance Criteria
Feature is complete when:
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Technical Notes
Specific implementation details, Constitution references, known constraints.

## Files Expected to Change
- `path/to/file.ts`
- `path/to/component.tsx`
- `migrations/XXX_description.sql`
```

Keep scope narrow. One sprint = one focused feature area.
