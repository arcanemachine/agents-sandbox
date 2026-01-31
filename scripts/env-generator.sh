#!/bin/bash
# Generic environment variable generator script
# Run this from the host machine (where docker is available)
# Must be run from the workspace root directory
# Creates container.env file with current container environment variables

set -e

# Get script directory and navigate to workspace root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

ENV_FILE="$WORKSPACE_ROOT/container.env"
CONTAINER_NAME="postgres"

echo "Generating environment file..."

# Get Postgres container IP
IP_ADDRESS=$(docker inspect "$CONTAINER_NAME" --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}')

# Create fresh env file
cat > "$ENV_FILE" << EOF
# Auto-generated environment file
# Generated: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
POSTGRES_HOST=$IP_ADDRESS
EOF

echo "Created: $ENV_FILE"
echo "Contents:"
cat "$ENV_FILE"
