---
name: md-format
description: Collapse manually-wrapped Markdown paragraphs into single lines (no fixed-column wrapping), without touching code blocks, tables, lists, headings, or blockquotes. Use when the user says "apply FORMAT.md", "remove manual wrapping", "unwrap this markdown", or asks to reformat a .md file's paragraph line breaks.
---

# md-format — Markdown formatting rule

Formatting rule for every `.md` file: it's not about the content, it's about how the _source_ of the `.md` looks.

## Main rule

**One paragraph = one single line of text in the source file**, no matter how long it gets. Don't use manual line breaks to fake a fixed column width (no wrapping at 80/100 characters by hand). Markdown already reflows text on its own when rendered — manual line breaks inside a paragraph add nothing and just make git diffs messier (a one-word change rewrites 5 lines instead of 1).

Before (wrong):

```
Suggested development plan, ordered by real dependencies between
modules (not by module number in the requirements doc). The idea
is to build the backend in layers and plug in the frontend as
each layer becomes stable.
```

After (correct):

```
Suggested development plan, ordered by real dependencies between modules (not by module number in the requirements doc). The idea is to build the backend in layers and plug in the frontend as each layer becomes stable.
```

## What does NOT get collapsed into one line

- **Code blocks** (between ` ``` `): left as they are, line by line, untouched — line breaks and indentation matter there (directory trees, snippets, JSON, etc.).
- **Tables**: each table row (including the separator row `|---|---|`) stays on its own line.
- **List items** (`-`, `*`, `1.`, etc.): each item is its own line. If an item was wrapped across several lines by hand, those lines get joined into one item line — but one item never merges with the next item or with a nested sublist.
- **Headings** (`#`, `##`, ...): always on their own line (already true by definition).
- Blank lines between blocks (paragraph/list/table/code): kept as they are, they separate the document's structure.

## Blockquotes

A blockquote (`>`) is a paragraph like any other: its continuation lines get collapsed into one line, just like a normal paragraph. The difference is that **each continuation line carries its own `>` marker, which must be dropped** when joining — if it's not dropped, the marker ends up stuck in the middle of the joined text, breaking the blockquote.

## Spacing

When joining lines from the same paragraph or item, use a single space between them (never join with no space, and never leave leftover double spaces from a line break in the middle of a word or sentence).

## Encoding

UTF-8, no BOM.

## How to apply it

Run `scripts/format.sh file1.md file2.md ...` — it applies the rule above with `awk`, in place. There's no need to touch the content or meaning of any document, it's a pure formatting pass.

Also run `scripts/replace-emdash.sh` for replacing `--` with `—` (em dash) in paragraphs, but not in code blocks, tables, or lists.

For PowerShell, see `scripts/unwrap-md.ps1`.
