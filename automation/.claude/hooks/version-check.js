#!/usr/bin/env node
/**
 * version-check.js — Commander Automation, Layer 1 (deterministic)
 * Claude Code SessionStart hook.
 *
 * v1.5 change: compares LOCAL files only — no network. The old version
 * fetched raw.githubusercontent.com/.../main/CONSTITUTION.md, which 404s
 * on a PRIVATE repo (the Director's IP requirement) and then failed
 * silently forever. Now it compares:
 *   .commander-version   — the version this project was bootstrapped on
 *   .commander/VERSION    — the version of the rules actually vendored here
 * and, if COMMANDER_HOME is set, that folder's /VERSION (newer-on-disk).
 * Best-effort: any problem exits silently and never blocks work.
 * No dependencies. Node built-ins only.
 */
const fs = require('fs');
const path = require('path');

const readVer = (p) => {
  try {
    const raw = fs.readFileSync(p, 'utf8').trim();
    return /^[\d.]+$/.test(raw) ? raw : null;
  } catch { return null; }
};

let input = '';
process.stdin.on('data', (d) => (input += d));
process.stdin.on('end', () => {
  try {
    const data = JSON.parse(input || '{}');
    const dir = data.cwd || process.cwd();
    const project = readVer(path.join(dir, '.commander-version'));
    if (!project) process.exit(0); // not a Commander project

    const vendored = readVer(path.join(dir, '.commander', 'VERSION'));
    const home = process.env.COMMANDER_HOME
      ? readVer(path.join(process.env.COMMANDER_HOME, 'VERSION')) : null;

    const notes = [];
    if (vendored && vendored !== project)
      notes.push(`vendored rules in .commander/ are v${vendored} but .commander-version says v${project}`);
    if (home && vendored && home !== vendored)
      notes.push(`a newer Commander (v${home}) exists at COMMANDER_HOME; this project has v${vendored}`);
    if (notes.length === 0) process.exit(0);

    process.stdout.write(JSON.stringify({
      hookSpecificOutput: {
        hookEventName: 'SessionStart',
        additionalContext:
          '⚠️ COMMANDER VERSION DRIFT (local): ' + notes.join('; ') +
          '. Inform the Director in Bosnian; read .commander/COMMANDER_CHANGELOG.md ' +
          'for the diff before proposing any upgrade. Do not upgrade without explicit approval.',
      },
    }));
    process.exit(0);
  } catch { process.exit(0); }
});
