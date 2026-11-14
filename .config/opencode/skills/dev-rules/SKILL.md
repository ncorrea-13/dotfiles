---
name: dev-rules
description: Personal engineering rules for error/failure handling, git commits (Conventional Commits with scope, past tense, optional body), and backend+DB code standards (Clean Architecture, Prisma/SQL). Use before running builds/migrations/tests that may cascade-fail, before proposing or writing any git commit or PR, or when touching backend/Prisma/SQL layering.
---

# Development rules

## Error handling and failure loops

- **Stop on cascade failures:** If a build, migration, or test task hits more than 2 failures in a row, or complex cascading errors, stop right away. Think about the cost and benefit of trying again, and suggest another option to the user before retrying blindly.
- **No assumptions about dependencies:** Don't install global packages or change manager config files (`package.json`, `Cargo.toml`, `requirements.txt`) without first checking the current state of the environment. Ask if anything is unclear.

## Git and commit behavior

- **Atomic commits:** Code changes should be split into separate, logical units.
- **Strict Conventional Commits:** Every commit message must follow this structure: `type(scope): short description in past tense` (example: `feat(nvim): added lazy-lock pin`, `fix(sway): updated swaylock guard`). The scope is the module, tool, or area touched (for example `nvim`, `mise`, `sway`, `auth`, `api`). Omit it only when the change is truly global.
- **Commit once, validated:** Don't commit until the change is verified (tests and linters for the affected module pass, `git status` and `git diff` reviewed, only the intended files staged). Then make the commit once, with the right message. No commit-then-fix loops, no repeated `--amend` or reset/redo cycles. If something is unclear, stop and ask before committing. Move carefully.
- **Commit body (optional):** Add a body only when the why isn't obvious from the diff. Never restate the title. Use it for non-obvious bug fixes (root cause), design tradeoffs, breaking changes (add `BREAKING CHANGE:` in the footer), or multi-part changes. Format: blank line after the title, title at most 72 chars, body wrapped at about 72 chars, short bullets when there are several points, same language and past tense as the title.
- **Check before pushing:** Don't suggest pushing directly to main branches without making sure local tests and linters for the affected module pass first.

## Code and database standards (Backend / Prisma / SQL)

- **Limited queries:** When checking databases or schemas (Prisma, SQL), avoid full dumps of large historical tables. Use cursor-based filtering or pagination when it makes sense.
- **Clean Architecture / Modularity:** Keep a strict separation between layers (controllers, services, repositories/infrastructure). Don't couple the domain layer directly to frameworks or third-party libraries.
