#!/bin/sh

set -e

cd "$(dirname "$0")/.."

if [ -f config.env ]; then
  echo "Loading config from 'config.env'..."

  set -a
  . "$(dirname "$0")/../config.env"
  set +a
else
  echo "Config file not found. To create one, run: 'cp config.env.example config.env'"
fi

# shellcheck disable=SC2086
devcontainer exec --workspace-folder . ${1:?}
