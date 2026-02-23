#!/bin/sh

set -e
cd "$(dirname "$0")"

echo "Starting Claude with YOLO mode enabled..."
devcontainer exec --workspace-folder . claude --dangerously-skip-permissions $@
