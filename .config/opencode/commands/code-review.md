---
description: Code review a pull request (port of the Claude Code code-review plugin). Args - PR number/URL, optional --comment
---

Provide a code review for the pull request given in: $ARGUMENTS

Use the `gh` CLI for everything GitHub-related. Do not use webfetch. Only call a tool when it has a clear purpose. Create a todo list before starting.

Steps:

1. Use a cheap `explore` subagent to check if any is true: PR is closed, PR is a draft, PR is trivial or automated and obviously correct, or an earlier review comment from you already exists (`gh pr view <PR> --comments`). If any is true, stop. Still review PRs written by AI.
2. Use a subagent to list paths (not contents) of every relevant `AGENTS.md` / `CLAUDE.md`: the root one and those in directories of modified files.
3. Use a subagent to read the PR (`gh pr view`, `gh pr diff`) and summarize the changes. Give every later subagent the PR title and description.
4. Launch 4 `general` subagents in parallel. Each returns issues with description and reason:
   - Agents 1 and 2: audit the diff for `AGENTS.md` / `CLAUDE.md` compliance. Only consider rule files whose path is a parent of the changed file.
   - Agent 3: scan the diff only, no extra context, for obvious significant bugs. Skip nitpicks and anything that needs outside context.
   - Agent 4: look for problems in the introduced code: security issues, incorrect logic. Only inside changed code.

   Only flag HIGH SIGNAL issues:
   - code that fails to compile or parse (syntax, types, missing imports, unresolved refs)
   - code that definitely gives wrong results regardless of input
   - clear rule violations where you can quote the exact rule

   Do NOT flag style, quality concerns, input-dependent issues, or subjective suggestions. If unsure, do not flag.
5. For each bug or logic issue, and each rule violation, launch a validation subagent with the PR title/description and the issue. It confirms the issue is real with high confidence.
6. Drop every issue that was not validated.
7. Print a summary: each issue briefly, or "No issues found. Checked for bugs and AGENTS.md/CLAUDE.md compliance."

   If `--comment` is NOT in the arguments, stop here and post nothing.
   If `--comment` is present and no issues: post that summary with `gh pr comment`, then stop.
   If `--comment` is present and issues exist: list planned comments privately, then post one inline review comment per unique issue with `gh api repos/{owner}/{repo}/pulls/{n}/comments` (use `commit_id`, `path`, `line`, `side`). Add a committable ```suggestion block only for small self-contained fixes that fully resolve the issue (not 6+ lines, not multi-location). Never duplicate comments.

False positives, do NOT flag:
- pre-existing issues
- things that look like bugs but are correct
- pedantic nitpicks a senior engineer would skip
- anything a linter catches (do not run the linter)
- general quality concerns (coverage, generic security) unless a rule file requires them
- issues explicitly silenced in code (lint ignore)

Link format in comments (must render in Markdown): `https://github.com/<owner>/<repo>/blob/<full-40-char-sha>/<path>#L<start>-L<end>`. Full SHA is required (no `$(git rev-parse HEAD)`), repo must match, include at least 1 line of context before and after.
