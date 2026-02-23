# Elixir

- Do not check `.tool-versions`. `asdf` handles this automatically.
- Use correct syntax to invoke the correct environment.
  - You may need to use `bash -l -c 'your command'`.

### IEx Sessions

- Use `tmux` when opening IEx sessions so they are persistent and user can view output.
  - WARNING: `tmux` send-keys breaks on `!`. Don't use for complex Elixir code, use `mix run -e` instead
- To start a new `tmux` session for Elixir: `tmux new-session -d -s <session_name> "bash -l -c 'cd /path/to/project && iex -S mix'`
- The user knows how `tmux` works and how to view any commands you have run in a session.

### Running tests

- Bash tool requires explicit PATH setup: `export PATH="$HOME/.asdf/shims:$HOME/.asdf/bin:$PATH" && export POSTGRES_HOST=<ip_if_needed> && mix test`

- Use the `workdir` parameter in Bash tool instead of `cd` - this ensures PATH and environment are preserved:
  - `export PATH="$HOME/.asdf/shims:$HOME/.asdf/bin:$PATH" && export POSTGRES_HOST=$(cat /workspace/container.local.env | grep POSTGRES_HOST | cut -d= -f2) && mix test`
  - with `workdir="/workspace/projects/[project-name]"`
  - WARNING: Do not use `source /workspace/env.sh` with `workdir`.
    - `env.sh` uses relative paths that break when workdir changes.
    - Extract `POSTGRES_HOST` directly from `container.local.env` instead.
