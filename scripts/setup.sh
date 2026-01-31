#!/usr/bin/env bash
set -euo pipefail

# Download and install asdf binary only if not already present
if [ ! -f ~/.local/bin/asdf ]; then
  echo "Installing asdf..."
  LATEST=$(curl -s https://api.github.com/repos/asdf-vm/asdf/releases/latest | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
  curl -sL "https://github.com/asdf-vm/asdf/releases/download/${LATEST}/asdf-${LATEST}-linux-amd64.tar.gz" -o /tmp/asdf.tar.gz
  mkdir -p ~/.local/bin
  tar -xzf /tmp/asdf.tar.gz -C /tmp
  mv /tmp/asdf ~/.local/bin/asdf
  rm -f /tmp/asdf.tar.gz
  echo "asdf installed"
else
  echo "asdf already installed, skipping download"
fi

# Configure ~/.bashrc
if ! grep -q '## asdf (Also configured in' ~/.bashrc 2>/dev/null; then
  cat >> ~/.bashrc << 'EOF'

## asdf (Also configured in '~/.bash_profile')
export ASDF_DATA_DIR="$HOME/.asdf"
export PATH="${ASDF_DATA_DIR}/shims:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/workspace/local/bin:$PATH"
. <(asdf completion bash)
EOF
  echo "Configured ~/.bashrc"
else
  echo "~/.bashrc already configured, skipping"
fi

# Configure ~/.bash_profile
if ! grep -q '## asdf (Also configured in' ~/.bash_profile 2>/dev/null; then
  cat >> ~/.bash_profile << 'EOF'

. "$HOME/.bashrc"

## asdf (Also configured in '~/.bashrc')
if [ -z "$ASDF_DATA_DIR" ]; then
  export ASDF_DATA_DIR="$HOME/.asdf"
  export PATH="${ASDF_DATA_DIR}/shims:$PATH"
  export PATH="$HOME/.local/bin:$PATH"
  export PATH="/workspace/bin:$PATH"
fi
EOF
  echo "Configured ~/.bash_profile"
else
  echo "~/.bash_profile already configured, skipping"
fi

# Make asdf available in current shell
export ASDF_DATA_DIR="$HOME/.asdf"
export PATH="/workspace/bin:$HOME/.local/bin:${ASDF_DATA_DIR}/shims:$PATH"

# Add plugins
asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git 2>/dev/null || true
asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.git 2>/dev/null || true

# Install versions from .tool-versions (skips if already installed)
asdf install

# Create marker files to indicate successful setup
touch ~/.asdf_elixir_ready  # Legacy marker for backward compatibility
touch ~/.asdf_ready         # Generic marker

# Symlink opencode config from workspace
mkdir -p ~/.config/opencode

echo "Configuring opencode symlink..."
if [ -L ~/.config/opencode ]; then
    echo "opencode config already symlinked"
elif [ -d ~/.config/opencode ]; then
    # Backup existing config and create symlink
    mv ~/.config/opencode ~/.config/opencode.backup.$(date +%Y%m%d_%H%M%S)
    ln -s /workspace/.opencode ~/.config/opencode
    echo "Backed up existing opencode config and created symlink"
else
    ln -s /workspace/.opencode ~/.config/opencode
    echo "Created opencode config symlink"
fi

echo "Setup complete!"
echo ""
/workspace/bin/workspace-status
