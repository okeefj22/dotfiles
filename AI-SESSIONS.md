# AI-SESSIONS.md - Session History Index

> **Purpose**: Lightweight index of AI-assisted work sessions. Individual session details live in `~/ai-sessions/`. Consult this when resuming previous work or checking if something has already been done.

> **Privacy**: This file and `~/ai-sessions/` are tracked by chezmoi and published to a **public GitHub repo** (`okeefj22/dotfiles`). Never include sensitive information: passwords, API keys, tokens, internal URLs, proprietary code, or work-specific details that shouldn't be public.

**Related**: See [AGENTS.md](AGENTS.md) for current environment state and tool documentation.

---

## Session Index

| Date | File | Summary |
|------|------|---------|
| 2026-03-31 | [2026-03-31-session-linking.md](ai-sessions/2026-03-31-session-linking.md) | Linked AGENTS.md and AI-SESSIONS.md, split sessions into individual files |
| 2026-02-22 | [2026-02-22-dotfile-setup.md](ai-sessions/2026-02-22-dotfile-setup.md) | Chezmoi setup, AGENTS.md creation, zsh cleanup, Brewfile overhaul |

---

## Session Template

When adding a new session, create a file in `~/ai-sessions/` following this convention:

**Filename**: `YYYY-MM-DD-slug.md`

**Structure**:
```markdown
# Session: YYYY-MM-DD - Title

## Context
1-2 sentences on what prompted this session.

## Changes Made
Concise bullet list of what was done. Reference AGENTS.md sections
rather than duplicating stable info.

## Key Decisions & Rationale
Only non-obvious decisions that future agents/you would benefit from understanding.

## Lessons Learned
If any.

## AGENTS.md Updated?
Yes/No - and brief note of what changed. Always keep AGENTS.md as the
source of truth for current environment state.
```

**Guidelines**:
- Keep sessions focused and concise - avoid repeating info that lives in AGENTS.md
- Add a row to the Session Index table above (newest first)
- Track the new file with chezmoi: `chezmoi add ~/ai-sessions/YYYY-MM-DD-slug.md`
- Remember: this is a **public repo** - no sensitive information
