@echo off
rem === COMMANDER AUTOMATION INSTALLER (v1.2) ===
rem Usage: install-automation.bat C:\path\to\project
rem Copies .claude hooks + settings into the target project.

if "%~1"=="" (
    echo Usage: install-automation.bat C:\path\to\project
    pause
    exit /b 1
)

set TARGET=%~1
set SOURCE=%~dp0

if not exist "%TARGET%" (
    echo [FAIL] Target folder does not exist: %TARGET%
    pause
    exit /b 1
)

echo Installing Commander Automation into: %TARGET%
echo.

if not exist "%TARGET%\.claude\hooks" mkdir "%TARGET%\.claude\hooks"
if not exist "%TARGET%\corrections" mkdir "%TARGET%\corrections"

copy /Y "%SOURCE%.claude\hooks\log-change.js" "%TARGET%\.claude\hooks\log-change.js"
copy /Y "%SOURCE%.claude\hooks\lessons-guard.js" "%TARGET%\.claude\hooks\lessons-guard.js"
copy /Y "%SOURCE%.claude\hooks\version-check.js" "%TARGET%\.claude\hooks\version-check.js"
copy /Y "%SOURCE%.claude\hooks\patterns-detect.js" "%TARGET%\.claude\hooks\patterns-detect.js"

if not exist "%TARGET%\.commander-version" (
    echo 1.2> "%TARGET%\.commander-version"
    echo [OK] .commander-version created: 1.2
) else (
    echo [SKIP] .commander-version already exists - not overwritten
)

if exist "%TARGET%\.claude\settings.json" (
    echo [WARNING] %TARGET%\.claude\settings.json already exists.
    echo Saved new version as settings.commander.json - merge "hooks" section manually
    echo or ask Claude Code to merge it for you.
    copy /Y "%SOURCE%.claude\settings.json" "%TARGET%\.claude\settings.commander.json"
) else (
    copy /Y "%SOURCE%.claude\settings.json" "%TARGET%\.claude\settings.json"
)

if not exist "%TARGET%\CLAUDE.md" (
    if exist "%SOURCE%PROJECT_CLAUDE_MD_TEMPLATE.md" (
        copy "%SOURCE%PROJECT_CLAUDE_MD_TEMPLATE.md" "%TARGET%\CLAUDE.md"
        echo [OK] CLAUDE.md template copied - edit [PROJECT NAME] and [project-repo]
    )
) else (
    echo [SKIP] CLAUDE.md already exists - not overwritten
)

echo.
echo === INSTALLED ===
echo Layer 1: log-change.js      - logs every file change automatically
echo Layer 2: lessons-guard.js   - enforces lesson capture before Claude finishes
echo Layer 3: version-check.js   - detects Commander version drift at session start
echo Layer 4: patterns-detect.js - auto-detects recurring rule violations
echo Layer 5: CLAUDE.md          - standing orders read at session start
echo.
echo Requirement: Node.js in PATH (already true for all Next.js/Vite projects)
echo.
pause
