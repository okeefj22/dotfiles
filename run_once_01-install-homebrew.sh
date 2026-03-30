#!/bin/bash
# Install Homebrew if not already installed
# This runs once per machine via chezmoi run_once_

set -euo pipefail

if command -v brew &>/dev/null; then
    echo "Homebrew is already installed."
    exit 0
fi

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to PATH for Apple Silicon Macs
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

echo "Homebrew installed successfully."
