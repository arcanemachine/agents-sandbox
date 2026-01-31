# OpenCode Sandbox

A containerized development environment for multi-language projects, primarily configured for Elixir development.

## Quick Start

```bash
# Start the dev container
./up.sh

# Enter the container shell
./shell.sh

# Run Claude Code directly
./claude.sh

# Run OpenCode directly
./opencode.sh

# Restart the container
./restart.sh

# Stop the container
./down.sh
```

## Environment

- **Languages**: Elixir (via asdf), Python (on-demand), Node.js
- **Security**: Outbound firewall restricts network access to allowed domains only

## Working with Elixir

All Elixir/Erlang commands must use the login shell wrapper:

```bash
bash -l -c 'cd /workspace/projects/some_elixir_project && mix deps.get'
bash -l -c 'cd /workspace/projects/some_elixir_project && iex -S mix'
```

## Setup

**Important**: Always run the setup script first after entering the container: `source /workspace/env.sh`
