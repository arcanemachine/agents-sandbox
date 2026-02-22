# Multi-Language Development Workspace

- This workspace is used to create and work on software development projects in various different languages.
- Some common languages used in this workspace are: Elixir, Python
- User calls `AGENTS.md` and `CLAUDE.md` the "agent file".
  - The workspace contains a top-level agent file: `/workspace/AGENTS.md`, which is symlinked to `CLAUDE.md`.

## Guidelines

- Your context window is precious! Do not waste tokens!
  - Instead of reading a whole file, you may want to read a portion of it, or call out to an external tool to get the information you need.

## Environment

- This session is running in a devcontainer, which is configured here: `/workspace/.devcontainer/`

## Workflow preferences

### Language versions

- Use `asdf` to manage language versions.
- Use whatever language has been configured. Avoid installing new language versions whenever possible.

### Source control

- Use Git for source control.
- User may want to manage Git repos manually. If unsure, do not manage the Git repo.
- If you are managing a Git repo for a project, ensure you are working with the correct repo!
  - Do not confuse the workspace repo (`/workspace/.git`) with the project repo (`/workspace/projects/[project-name]/.git`).

## Initialization instructions

- When first starting up, check which LLM model you are using.
  - If you are using Opus, stop what you are doing and immediately warn the user so that they can change the model.
- If the user says "init" on startup:
  - Run `/workspace/scripts/setup.sh` to ensure environment is properly configured.
  - Source `/workspace/env.sh` to set up environment variables including `POSTGRES_HOST`.
    - If `container.local.env` doesn't exist or connection fails, tell the user to run `/workspace/scripts/env-generator.sh` from the host machine to regenerate it.

## Project-Specific Instructions

- A project may contain its own agent file.
- Check for LLM/agent docs using globs (case-insensitive): `*usage*.md`, `*claude*.md`, `*agent*.md`, `.claude/`
- When you know what language the project is written in, check for a language-specific agent file in `/workspace/.agents/languages`.
  - Example: For an Elixir project: `/workspace/.agents/languages/elixir.md`
- If you are supposed to be managing the Git history, ensure that you make regular commits.

## Tools

### tmux

- Prefer `tmux` for shell persistence.
