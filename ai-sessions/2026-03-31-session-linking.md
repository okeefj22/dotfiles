# Session: 2026-03-31 - Linking AGENTS.md and AI-SESSIONS.md

## Context

AGENTS.md and AI-SESSIONS.md existed but weren't properly cross-referenced. AI-SESSIONS.md was a single growing file that would become increasingly expensive to load as sessions accumulated.

## Changes Made

- **Split AI-SESSIONS.md** into a slim index (~40 lines) + individual session files in `~/ai-sessions/`
- **Migrated** the 2026-02-22 session content to `~/ai-sessions/2026-02-22-dotfile-setup.md`, trimmed to remove info duplicated in AGENTS.md
- **Rewrote AI-SESSIONS.md** as a lightweight index with: session table, template/convention for future sessions, privacy reminder
- **Updated AGENTS.md** with: privacy/public repo warning, "Related Files" section linking to AI-SESSIONS.md, updated chezmoi managed files list, bumped last-updated date
- **Established convention**: session files named `YYYY-MM-DD-slug.md`, reference AGENTS.md instead of duplicating stable info

## Key Decisions & Rationale

| Decision | Rationale |
|----------|-----------|
| Split sessions into individual files | Keeps index cheap to load (~1 line per session vs ~200); only load detail when needed |
| Privacy note in both files | Both are public via chezmoi/GitHub; agents and users need the reminder |
| Session template standardized | Prevents bloat, ensures consistency, reminds to update AGENTS.md |
| Cross-reference near top of AGENTS.md | Auto-injected as system context; agents immediately know AI-SESSIONS.md exists |

## AGENTS.md Updated?

Yes - added privacy warning, Related Files section, updated chezmoi managed files list, bumped date to 2026-03-31.
