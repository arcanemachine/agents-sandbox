#!/bin/sh

set -e
cd "$(dirname "$0")"

echo "Starting Pi coding agent..."
devcontainer exec --workspace-folder . bash -c "set -a && source config.env && set +a && source env.sh && exec pi"
