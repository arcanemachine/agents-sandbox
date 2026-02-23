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
export PATH="/workspace/bin:$PATH"
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
touch ~/.asdf_ready         # Generic marker

# Symlink OpenCode config from workspace
mkdir -p ~/.config/opencode

echo "Configuring OpenCode symlink..."
if [ -L ~/.config/opencode ]; then
    echo "opencode config already symlinked"
elif [ -d ~/.config/opencode ]; then
    # Backup existing config and create symlink
    mv ~/.config/opencode ~/.config/opencode.$(date +%Y%m%d_%H%M%S).bak
    ln -s /workspace/.opencode ~/.config/opencode
    echo "Backed up existing opencode config and created symlink"
    echo "OpenCode config already symlinked"
else
    ln -s /workspace/.opencode ~/.config/opencode
    echo "Created OpenCode config symlink"
fi

# Symlink Pi config from workspace
mkdir -p ~/.pi

echo "Configuring pi config symlink..."
if [ -L ~/.pi ]; then
    echo "pi config already symlinked"
elif [ -d ~/.pi ]; then
    # Backup existing config and create symlink
    mv ~/.pi ~/.config/.pi.$(date +%Y%m%d_%H%M%S).bak
    ln -s /workspace/.pi ~/.pi
    echo "Backed up existing pi config and created symlink"
else
    ln -s /workspace/.pi ~/.pi
    echo "Created pi config symlink"
fi

echo "Setup complete!"
echo ""
/workspace/bin/workspace-status
