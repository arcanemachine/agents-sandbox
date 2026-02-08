# Multi-Language Development Workspace

On initial startup, check which model you are using. If you are using Opus, IMMEDIATELY warn the user so that they can change the model.

**IMPORTANT**: Ask before destructive actions (updating deps, deleting files, modifying configs, etc.)

**Environment**: Running in a dev container with firewall restrictions

**Primary use**: Elixir development, configured via asdf

**NOTE**: User calls AGENTS.md and CLAUDE.md the "agents file" or "memory file". When user says "memory file", they mean those files (top-level or project-level).

- The AGENTS.md and CLAUDE.md files are all symlinked to the same location. If the user asks to edit the file, editing any one of those files will be sufficient (top-level or project-level).

**DO NOT WORRY ABOUT LANGUAGE VERSIONS** - Used whatever has been configured.

## Tool Calling Instructions

 When using tools in this system, follow these guidelines:

 1. **Use JSON format for tool calls**: Each tool invocation must be in valid JSON format
 2. **Format**:

{
  "name": "tool-name",
  "arguments": {
    "parameter1": "value1",
    "parameter2": "value2"
  }
}

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

**Environment**: Source `/workspace/env.sh` to set up environment variables including `POSTGRES_HOST`. If `container.local.env` doesn't exist or connection fails, run `/workspace/scripts/env-generator.sh` from the host machine to regenerate it.

## IEx Sessions (CRITICAL)

**ALWAYS use TMUX** when opening IEx sessions so they are persistent and user can view output:

```bash
tmux new-session -d -s <session_name> "bash -l -c 'cd /path/to/project && iex -S mix'"
```

- Use `tmux attach -t <session_name>` to view the session
- Use `tmux ls` to list active sessions

**User can view IEx output themselves** - When running IEx commands for the user in tmux, just execute them. User knows when output is there and does not need assistance viewing it. Do not show or capture output from tmux for the user - they can see it themselves in tmux.

**Use correct syntax to invoke the correct environment**: May need to use `bash -l -c 'your command'`

**ASDF automatically handles versions** when run from project directory - no need to manually check .tool-versions files
**Web searches**: Prefer using local tools over web searches when possible

**Running tests**: Bash tool requires explicit PATH setup:

```bash
export PATH="$HOME/.asdf/shims:$HOME/.asdf/bin:$PATH" && export POSTGRES_HOST=<ip_if_needed> && mix test
```

**Tip**: Use the `workdir` parameter in Bash tool instead of `cd` - this ensures PATH and environment are preserved:

```bash
export PATH="$HOME/.asdf/shims:$HOME/.asdf/bin:$PATH" && export POSTGRES_HOST=$(cat /workspace/container.local.env | grep POSTGRES_HOST | cut -d= -f2) && mix test
```

with `workdir="/workspace/projects/<project-name>"`

**IMPORTANT**: Do NOT use `source /workspace/env.sh` with `workdir` - env.sh uses relative paths that break when workdir changes. Extract POSTGRES_HOST directly from container.local.env instead.

## OpenCode

**Config:** `/workspace/.opencode/opencode.json`
**Ollama Host:** `172.16.0.1:11434`
**List models:** `curl http://172.16.0.1:11434/api/tags`

## Gotchas

**Tmux send-keys breaks on `!`** - Don't use for complex Elixir code, use `mix run -e` instead

## Python Projects

**Check for Python via ASDF first** when starting a Python project:

1. Run `asdf list python` to check if Python is installed
2. If Python is not installed, ask the user which version they want (e.g., "Which Python version would you like to install? 3.11, 3.12, etc.")
3. Once user confirms, install with: `asdf install python <version>`
4. Set the version: `asdf local python <version>`
5. Then proceed with project setup

## Project-Specific Instructions

For project-specific setup and workflows, check `/workspace/projects/<project-name>/.claude/CLAUDE.md`
