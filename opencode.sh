#!/bin/sh

set -e
cd "$(dirname "$0")"

echo "Starting OpenCode..."
devcontainer exec --workspace-folder . bash -c "set -a && source config.env && set +a && source env.sh && exec opencode"
