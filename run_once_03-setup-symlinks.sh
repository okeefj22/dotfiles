#!/bin/bash
# Create wrapper scripts/symlinks for GUI applications that don't add themselves to PATH
# This runs once per machine via chezmoi run_once_

set -euo pipefail

LINK_DIR="$HOME/.local/bin"
mkdir -p "$LINK_DIR"

# --- Wrapper scripts ---
# Some apps (like Vivaldi) can't be symlinked directly because the binary
# resolves framework paths relative to itself. Use `open -a` instead.

# Vivaldi wrapper
VIVALDI_WRAPPER="$LINK_DIR/vivaldi"
if [ -d "/Applications/Vivaldi.app" ]; then
    rm -f "$VIVALDI_WRAPPER"
    cat > "$VIVALDI_WRAPPER" << 'WRAPPER'
#!/bin/bash
open -a "Vivaldi" "$@"
WRAPPER
    chmod +x "$VIVALDI_WRAPPER"
    echo "Created wrapper: vivaldi -> open -a Vivaldi"
else
    echo "Warning: /Applications/Vivaldi.app not found. Skipping vivaldi wrapper."
    echo "  Install it first (e.g. via brew bundle) and re-run: chezmoi apply"
fi

# --- Direct symlinks ---
# Add entries here for apps that work fine as direct symlinks: "name|target"
SYMLINKS="
"

echo "$SYMLINKS" | while IFS='|' read -r name target; do
    [ -z "$name" ] && continue
    link="$LINK_DIR/$name"

    if [ -e "$target" ]; then
        ln -sf "$target" "$link"
        echo "Linked $name -> $target"
    else
        echo "Warning: $target not found. Skipping $name symlink."
        echo "  Install it first (e.g. via brew bundle) and re-run: chezmoi apply"
    fi
done

echo "Symlink setup complete."
