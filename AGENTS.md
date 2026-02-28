# Multi-Language Development Workspace

This is the workspace agent file. The workspace has its own repo and agent files.

Do not confuse the project repo with the workspace repo!
  - Workspace: `/workspace`
  - Projects: `/workspace/projects/[project-name]`

This workspace is used to create and work on software development projects in various different languages.
- User calls `AGENTS.md` and `CLAUDE.md` the "agent file".
  - The workspace contains a top-level agent file: `/workspace/AGENTS.md`, which is symlinked to `CLAUDE.md`.
  - Projects may have their own agent file(s).

## Guidelines

- Think before you act. Don't do anything stupid!
- If you don't know something you can search the web to discover new information when needed.

## Workflow preferences

- The main directory is `/workspace`.
  - If in doubt, start in `/workspace` when looking for files.
- Temp files go in `/tmp` or `/workspace/tmp` (for stuff that may be useful in a future session).

### Language versions

- Use `asdf` to manage language versions.
  - Use whatever language has been configured. Avoid installing new language versions whenever possible.

### Source control

- User may want to manage Git repos manually. If unsure, do not manage the Git repo.
- If you are managing a Git repo for a project, ensure you are working with the correct repo!
  - Do not confuse the workspace repo (`/workspace/.git`) with the project repo (`/workspace/projects/[project-name]/.git`).

## Initialization instructions

- If the user says "init" on startup:
  - Run `/workspace/scripts/setup.sh` to ensure environment is properly configured.
  - Source `/workspace/env.sh` to set up necessary environment variables including `POSTGRES_HOST`.
    - If `container.local.env` doesn't exist or connection fails, tell the user to run `/workspace/scripts/env-generator.sh` from the host machine to regenerate it.

## Project-Specific Instructions

- Check for LLM/agent docs using globs (case-insensitive): `*usage*.md`, `*claude*.md`, `*agent*.md`, `.claude/`
- When you know what language the project is written in, check for a language-specific agent file in `/workspace/.agents/languages`.
  - Example: For an Elixir project: `/workspace/.agents/languages/elixir.md`
- If you are supposed to be managing the Git history, ensure that you make regular commits.
- After first reading the agent file, STOP and await further instructions, unless you have been instructed to continue.

## Tools

### tmux

- Prefer `tmux` for shell persistence.
- If you are running a tmux session that the user should watch, use a persistent tmux session, and do not kill it when you are done.
