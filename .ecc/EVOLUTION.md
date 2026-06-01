# ECC Evolution Rules — Lessons Learned & Self-Improvement Protocol

**Purpose:** This file is a living document. Every time the AI agent makes a mistake, misses a prerequisite, or discovers a gotcha, a new entry MUST be added here. The agent MUST read this file at the start of every session (referenced from AGENTS.md) and MUST NEVER repeat a documented mistake.

---

## How to Use This File

1. **Before any task:** Read this file. Check if any rule applies to your current work.
2. **After any failure:** Add a new entry immediately. Format: date, category, what went wrong, root cause, fix, and the permanent rule going forward.
3. **Rules are cumulative:** Never delete entries. Only append or amend.

---

## Permanent Rules

### RULE-001: Git-track files BEFORE running code-review-graph
- **Date:** 2026-06-01
- **Category:** code-review-graph / Git
- **What went wrong:** After creating new C# files (UserSystem, TodoApp), ran `code-review-graph update` and `code-review-graph build`. The graph reported 0 new nodes. Status still showed `Files: 2`. All new code was invisible to the graph.
- **Root cause:** `code-review-graph` only indexes files tracked by Git. New files that haven't been `git add`-ed are completely ignored. The tool does NOT scan the filesystem — it scans the Git index.
- **Fix applied:** Ran `git add tests/ AGENTS.md .ecc/` before `code-review-graph build`. Graph jumped from 58 → 83 nodes, 2 → 15 files.
- **Permanent rule:** **ALWAYS run `git add <new-files>` BEFORE running `code-review-graph build` or `code-review-graph update`.** After ANY file creation, stage it to Git immediately. Then rebuild the graph. Then verify with `code-review-graph status` that file/node counts actually increased.

### RULE-002: Always verify tool output — never assume success
- **Date:** 2026-06-01
- **Category:** Verification / Trust
- **What went wrong:** Told the user the graph was updated and working. User ran `code-review-graph status` themselves and saw zero change. Agent had not actually verified the output.
- **Root cause:** Agent saw `code-review-graph update` return without error and assumed it worked. Did not check the actual `status` output to confirm node/file counts changed.
- **Permanent rule:** **After ANY tool execution, run the corresponding verification command and CHECK the output numbers/results.** Specifically:
  - After `code-review-graph build/update` → run `code-review-graph status` and confirm Files/Nodes/Edges increased.
  - After `dotnet test` → confirm `Passed: N` in output.
  - After `dotnet build` → confirm `Build succeeded` in output.
  - **Never tell the user "it works" without showing proof.**

### RULE-003: Don't create redundant configuration files
- **Date:** 2026-06-01
- **Category:** Organization / Cleanliness
- **What went wrong:** `code-review-graph install` auto-generated a `GEMINI.md` file at the project root, duplicating content already in `AGENTS.md`. User was confused about why it existed.
- **Root cause:** The install script generates platform-specific instruction files. Since we already consolidate everything in `AGENTS.md`, the extra file was redundant clutter.
- **Permanent rule:** **After running any `install` or `init` command from a third-party tool, immediately check what files it created.** Delete any that duplicate existing configuration. Keep ONE source of truth (`AGENTS.md`).

### RULE-004: Don't clone entire repos when you only need config files
- **Date:** 2026-06-01
- **Category:** Organization / Minimalism
- **What went wrong:** Cloned the entire ECC repository (~hundreds of files) into the user's workspace when only ~10 config/rule files were actually needed.
- **Root cause:** Laziness — cloning was the easiest path. Did not analyze what was truly needed first.
- **Permanent rule:** **Analyze what files you actually need BEFORE cloning/copying.** Extract only the minimum required files. If a repo has 500 files and you need 5, download those 5 — don't dump the whole thing.

### RULE-005: Use correct shell syntax for the current OS
- **Date:** 2026-06-01
- **Category:** Shell / Windows
- **What went wrong:** Used `rm -rf`, `mkdir -p`, `ls -la` (bash/Linux syntax) on Windows PowerShell. Commands failed.
- **Root cause:** Agent defaulted to Unix muscle memory.
- **Permanent rule:** **On Windows/PowerShell:** Use `Remove-Item -Recurse -Force`, `New-Item -ItemType Directory -Force`, `Get-ChildItem`. Never use `rm -rf`, `mkdir -p`, `ls -la`.

### RULE-006: Target the correct workspace directory
- **Date:** 2026-06-01
- **Category:** Workspace / Path
- **What went wrong:** Copied files to `d:\Ivais\egenesis` instead of the correct workspace `d:\Ivais\Ivais`.
- **Root cause:** Assumed wrong directory without verifying with the user.
- **Permanent rule:** **Always confirm the active workspace root from the user context metadata.** Check `user_information` for the workspace URI. Never assume.

---

## Self-Improvement Protocol

When a new mistake is discovered:

1. **STOP** current work immediately.
2. **Document** the mistake here using the template above (Date, Category, What went wrong, Root cause, Fix, Permanent rule).
3. **Fix** the immediate issue.
4. **Update** `AGENTS.md` and/or `.ecc/GRAPHS.html` if the rule affects those workflows.
5. **Resume** work.

This file grows over time. That's the point. Every failure makes the system smarter.
