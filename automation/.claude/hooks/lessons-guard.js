#!/usr/bin/env node
/**
 * lessons-guard.js — Commander Automation, Layer 2 (deterministic enforcement)
 * Claude Code Stop hook
 *
 * Fires when Claude Code tries to finish its response.
 * If code files were modified in this session (ACTIVITY_LOG updated)
 * but the sprint lessons file was NOT updated afterwards, this hook
 * BLOCKS completion (exit code 2) and instructs Claude to capture
 * lessons first. Claude Code feeds stderr back to Claude, which then
 * writes the lessons and finishes.
 *
 * Result: lessons capture is enforced by the system, not by memory.
 *
 * No dependencies. Node built-ins only.
 */
const fs = require('fs');
const path = require('path');

let input = '';
process.stdin.on('data', (d) => (input += d));
process.stdin.on('end', () => {
  try {
    const data = JSON.parse(input || '{}');

    // Loop protection: if we already blocked once this stop cycle, allow finish
    if (data.stop_hook_active) process.exit(0);

    const projectDir = data.cwd || process.cwd();
    const corrDir = path.join(projectDir, 'corrections');
    const logFile = path.join(corrDir, 'ACTIVITY_LOG.md');

    // No activity log → nothing was changed this session → allow finish
    if (!fs.existsSync(logFile)) process.exit(0);

    const logMtime = fs.statSync(logFile).mtimeMs;

    // Find the newest SPRINT_*_LESSONS.md
    let newestLessonsMtime = 0;
    if (fs.existsSync(corrDir)) {
      for (const f of fs.readdirSync(corrDir)) {
        if (/^SPRINT_.*_LESSONS\.md$/i.test(f)) {
          const m = fs.statSync(path.join(corrDir, f)).mtimeMs;
          if (m > newestLessonsMtime) newestLessonsMtime = m;
        }
      }
    }

    // Grace window: if lessons were updated within 10 min before the
    // last code change, consider them current (avoids nagging on
    // trivial follow-up edits right after a lessons write).
    const GRACE_MS = 10 * 60 * 1000;

    if (newestLessonsMtime + GRACE_MS >= logMtime) {
      process.exit(0); // lessons are current → allow finish
    }

    // Lessons are stale → block and instruct Claude
    process.stderr.write(
      'STANDING ORDER (Commander M-18, automated guard): files were ' +
        'modified this session but corrections/SPRINT_XX_LESSONS.md was ' +
        'not updated. Before finishing: (1) review corrections/ACTIVITY_LOG.md ' +
        'for what changed, (2) append any corrections, gotchas, course ' +
        'corrections, or Commander improvement candidates from this session ' +
        'to the current sprint lessons file using the standard entry format, ' +
        '(3) if genuinely nothing lesson-worthy happened, append a single ' +
        'line: "### [date] — No lessons this session (routine changes only)". ' +
        'Then finish your response.'
    );
    process.exit(2);
  } catch (e) {
    process.exit(0); // never break the session
  }
});
