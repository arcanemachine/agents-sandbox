# Multi-Language Development Workspace

On initial startup, check which model you are using. If you are using Opus, IMMEDIATELY warn the user so that they can change the model.

**IMPORTANT**: Ask before destructive actions (updating deps, deleting files, modifying configs, etc.)

**Environment**: Running in a dev container with firewall restrictions

**Primary use**: Elixir development, configured via asdf

**NOTE**: User calls AGENTS.md and CLAUDE.md the "agents file" or "memory file". When user says "memory file", they mean those files (top-level or project-level).
- The AGENTS.md and CLAUDE.md files are all symlinked to the same location. If the user asks to edit the file, editing any one of those files will be sufficient (top-level or project-level).

**DO NOT WORRY ABOUT LANGUAGE VERSIONS** - Used whatever has been configured.

## Workflow Preferences

**Git management** - User manages Git history manually. Don't worry about it unless explicitly asked.

**Task tracking** - Use task management tools proactively for multi-step work (3+ steps)

**Temporary todo file** - Create `AGENTS.TODO.md` in the project directory. Keep it simple:
- Brief bullet points only, no subsections
- Add ISO datetime stamp heading for each session
- Remove items when they have been completed (if unsure, then ask first)

**Sub-agents** - Use specialized agents (Explore, Bash, general-purpose) when appropriate for:
- Complex codebase searches
- Background/parallel work
- Multi-step research tasks

**New repo setup** - Check for LLM/agent docs using globs (case-insensitive): `*usage*.md`, `*claude*.md`, `*agent*.md`, `*ai*.md`, `.claude/`

## Dev Container

**Location**: `/workspace/.devcontainer/`

**Firewall**: Restricts outbound network access to explicitly allowed domains only
- Firewall config: `/workspace/.devcontainer/init-firewall.sh`
- Allowed domains must be added to the domain list in init-firewall.sh
- Changes require container restart to take effect

## Environment Setup

**On user "init" command**: ALWAYS run `/workspace/scripts/setup.sh` first to ensure environment is properly configured.

**Environment**: Source `/workspace/env.sh` to set up environment variables including `POSTGRES_HOST`. If container.env doesn't exist or connection fails, run `/workspace/scripts/env-generator.sh` from the host machine to regenerate it.

## IEx Sessions (CRITICAL)

**ALWAYS use TMUX** when opening IEx sessions so they are persistent and user can view output:
```bash
tmux new-session -d -s <session_name> "bash -l -c 'cd /path/to/project && iex -S mix'"
```

- Use `tmux attach -t <session_name>` to view the session
- Use `tmux ls` to list active sessions

**User can view IEx output themselves** - When running IEx commands for the user in tmux, just execute them. User knows when output is there and does not need assistance viewing it. Do not show or capture output from tmux for the user - they can see it themselves in tmux.

**Use correct syntax to invoke the correct environment**: May need to use `bash -l -c 'your command'`

**Elixir versions**: Use what's in project's .tool-versions file(s), not latest

**Checking versions**: `cat ~/.tool-versions` for required, `bash -l -c 'asdf current'` for active
**Missing versions**: If `.tool-versions` is missing, use `bash -l -c 'asdf list all <lang>'` to find latest stable, then install
**Web searches**: Prefer using local tools over web searches when possible

## Tools

**View directories and files tree structure**: `/workspace/bin/erd -y iflat -s name --suppress-size <path>` (respects .gitignore) (For directories only, add the flag `--dirs-only`.)

## OpenCode

**Config:** `/workspace/.opencode/opencode.json`
**Ollama Host:** `172.16.0.1:11434`
**List models:** `curl http://172.16.0.1:11434/api/tags`

## Gotchas

**Tmux send-keys breaks on `!`** - Don't use for complex Elixir code, use `mix run -e` instead

## Projects

### Factory Man

**Start IEx**:
```bash
tmux new-session -d -s factory_demo \
  "bash -l -c 'export POSTGRES_HOST=<IP> && export MIX_ENV=test && cd /workspace/projects/factory_man && iex -S mix'"
```

**CRITICAL**: Use `MIX_ENV=test` (factories in test/support/)

**Running Tests**: Always source `/workspace/env.sh` first to set up the environment, then run tests:
```bash
source /workspace/env.sh
cd /workspace/projects/factory_man && mix test
```

**Environment Setup**: Elixir/Mix commands require the asdf environment to be loaded. Always use `bash -l -c 'command'` or ensure `.bashrc` is sourced before running elixir/mix commands directly.
