# Agents Sandbox

A containerized development environment for multi-language projects, primarily configured for Elixir and Python development.

This repo provides a safe and easy way to use LLM agent frameworks in a sandboxed environment, so that they cannot run wild on your computer and accidentally delete all your files.

This repo gets you up and running with two available agent frameworks: Claude Code and OpenCode. Claude Code has better models, but OpenCode has some pretty good models (e.g. Kimi K2.5) available on a reasonably generous free tier. If you are just getting your feet wet, try out OpenCode.

## Prerequisites

You must have Docker and npm installed on the host machine.

## Quick Start

Run these scripts from the host:

```bash
# Setup (host): Install devcontainers CLI
npm i -g @devcontainers/cli

# Start the dev container
./up.sh

# Enter the container shell
./shell.sh

# Run OpenCode directly
./opencode.sh

# Run Claude Code directly
./claude.sh

# Restart the container
./restart.sh

# Stop the container
./down.sh
```

## General workflow

- Every time you start OpenCode or Claude Code, you should use "init" as the first prompt. This will cause the agent to do some initial checks to set up the workspace and make sure everything is ready to go.

- The agent is configured to look for projects in the `./projects` directory. (This directory is gitignored. You may add a new Git repo inside the project so that its history does not pollute the Git history of this sandbox.)

- After this initialization process has completed, you can issue whatever commands you want, e.g "Create a 'Hello World' Elixir project'
  - Any files in this repo may be modified by the agent.

## Environment

- **Languages**: Elixir and Python are supported out-of-the-box (via ASDF)
- **Security**: Outbound firewall restricts network access to allowed domains only
  - To add a domain to the allowlist, edit the domains in `.devcontainer/init-firewall.sh`, then restart the container (`./restart.sh`). (This is done in the host, not in the container.)

## Setup

You may want to source the setup script first after entering the container: `source /workspace/env.sh`

## Known Issues

- The API keys are not saved correctly when restarting the container.
