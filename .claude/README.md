# Claude Code Reference

## Where to put instructions for Claude

- `CLAUDE.md` or `.claude/CLAUDE.md` - Main project instructions
- `.claude/rules/*.md` - Modular context files (all auto-loaded)
- `CLAUDE.local.md` - Personal project notes (gitignored)
- `~/.claude/CLAUDE.md` - Personal preferences across all projects

## Config files

- `.claude/settings.json` - Team settings (in git)
- `.claude/settings.local.json` - Personal settings (gitignored)

## Features

- `@path/to/file` - Import other files in markdown
- YAML frontmatter with `paths:` - Scope rules to specific files
- `/init` - Bootstrap a CLAUDE.md file

## Docs

https://code.claude.com/docs/en/memory.md
https://code.claude.com/docs/en/settings.md
