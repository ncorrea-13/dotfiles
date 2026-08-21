---
name: dev-rules
description: Personal engineering rules for error/failure handling, git/commit conventions, and backend+DB code standards (Clean Architecture, Prisma/SQL). Use before running builds/migrations/tests that may cascade-fail, before proposing or writing git commits, or when touching backend/Prisma/SQL layering.
---

# Development rules

## Error handling and failure loops

- **Stop on cascade failures:** If a build, migration, or test task hits more than 2 failures in a row, or complex cascading errors, stop right away. Think about the cost and benefit of trying again, and suggest another option to the user before retrying blindly.
- **No assumptions about dependencies:** Don't install global packages or change manager config files (`package.json`, `Cargo.toml`, `requirements.txt`) without first checking the current state of the environment. Ask if anything is unclear.

## Git and commit behavior

- **Atomic commits:** Code changes should be split into separate, logical units.
- **Strict Conventional Commits:** Every commit message must follow this structure: `type(scope): short description in infinitive form` (example: `feat(auth): ...`, `fix(shared): ...`).
- **Check before pushing:** Don't suggest pushing directly to main branches without making sure local tests and linters for the affected module pass first.

## Code and database standards (Backend / Prisma / SQL)

- **Limited queries:** When checking databases or schemas (Prisma, SQL), avoid full dumps of large historical tables. Use cursor-based filtering or pagination when it makes sense.
- **Clean Architecture / Modularity:** Keep a strict separation between layers (controllers, services, repositories/infrastructure). Don't couple the domain layer directly to frameworks or third-party libraries.
