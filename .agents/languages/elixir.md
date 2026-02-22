# Elixir

### IEx Sessions

**ALWAYS use TMUX** when opening IEx sessions so they are persistent and user can view output:
  - WARNING: `tmux` send-keys breaks on `!`. Don't use for complex Elixir code, use `mix run -e` instead

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
