#!/bin/sh

set -e
cd "$(dirname "$0")"

echo "Starting OpenCode..."
devcontainer exec --workspace-folder . opencode $@
