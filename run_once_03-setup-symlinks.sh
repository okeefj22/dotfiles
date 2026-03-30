#!/bin/bash
# Create symlinks for GUI applications that don't add themselves to PATH
# This runs once per machine via chezmoi run_once_

set -euo pipefail

LINK_DIR="$HOME/.local/bin"
mkdir -p "$LINK_DIR"

# Map of symlink name -> application binary path
declare -A SYMLINKS=(
    ["vivaldi"]="/Applications/Vivaldi.app/Contents/MacOS/Vivaldi"
)

for name in "${!SYMLINKS[@]}"; do
    target="${SYMLINKS[$name]}"
    link="$LINK_DIR/$name"

    if [[ -e "$target" ]]; then
        ln -sf "$target" "$link"
        echo "Linked $name -> $target"
    else
        echo "Warning: $target not found. Skipping $name symlink."
        echo "  Install it first (e.g. via brew bundle) and re-run: chezmoi apply"
    fi
done

echo "Symlink setup complete."
