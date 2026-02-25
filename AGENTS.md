# Multi-Language Development Workspace

- This workspace is used to create and work on software development projects in various different languages.
- Some common languages used in this workspace are: Elixir, Python
- User calls `AGENTS.md` and `CLAUDE.md` the "agent file".
  - The workspace contains a top-level agent file: `/workspace/AGENTS.md`, which is symlinked to `CLAUDE.md`.

## Guidelines

- Your context window is precious:
  - Do not waste tokens! Know when to keep going, and when to stop.
  - Instead of reading a whole file, you may want to read a portion of it, or call out to an external tool to get the information you need.
  - You may search the web to discover new information when needed (e.g., research, documentation, latest developments).

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
  - Source `/workspace/env.sh` to set up necessary environment variables including `POSTGRES_HOST`.
    - If `container.local.env` doesn't exist or connection fails, tell the user to run `/workspace/scripts/env-generator.sh` from the host machine to regenerate it.

## Project-Specific Instructions

- Check for LLM/agent docs using globs (case-insensitive): `*usage*.md`, `*claude*.md`, `*agent*.md`, `.claude/`
- When you know what language the project is written in, check for a language-specific agent file in `/workspace/.agents/languages`.
  - Example: For an Elixir project: `/workspace/.agents/languages/elixir.md`
- If you are supposed to be managing the Git history, ensure that you make regular commits.
- After first reading the agent file, STOP and await further instructions, unless you have been instructed to continue.

### Project agent files

- In addition to the default `AGENTS.md` file, a project may contain the other local (i.e. gitignored) agent files:
  - `AGENTS.gitignored.md` - High-level instructions that are specific to the machine you are currently working from
  - `AGENTS.TODO.gitignored.md` - Use this to manage your ongoing assignments.

## Tools

### tmux

- Prefer `tmux` for shell persistence.
- If you are running a tmux session that the user should watch, use a persistent tmux session, and do not kill it when you are done.
