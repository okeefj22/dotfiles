# Add a new alias: just alias <shorthand> <command...>
# Example: just alias gcmsg git commit -m
alias shorthand +command:
    #!/usr/bin/env bash
    set -euo pipefail

    ALIASES_FILE="$ZDOTDIR/aliases.zsh"
    SHORTHAND="{{ shorthand }}"
    COMMAND="{{ command }}"

    red()    { gum style --foreground 1 "$*"; }
    yellow() { gum style --foreground 3 "$*"; }
    green()  { gum style --foreground 2 "$*"; }
    cyan()   { gum style --foreground 6 "$*"; }
    bold()   { gum style --bold         "$*"; }

    # 1. Shorthand already an alias?
    existing_def=$(grep -E "^alias ${SHORTHAND}=" "$ALIASES_FILE" | head -1 || true)
    if [[ -n "$existing_def" ]]; then
        red "Shorthand '${SHORTHAND}' is already defined:"
        cyan "  ${existing_def}"
        exit 1
    fi

    # 2. Shorthand already a binary in PATH?
    if path_bin=$(command -v "$SHORTHAND" 2>/dev/null); then
        yellow "Warning: '${SHORTHAND}' already exists in PATH as: ${path_bin}"
        gum confirm "Add the alias anyway (it will shadow the binary)?" || exit 0
    fi

    # 3. Command already aliased with a different shorthand?
    existing_alias=$(grep -E "^alias [^=]+='${COMMAND}'$" "$ALIASES_FILE" | head -1 || true)
    if [[ -n "$existing_alias" ]]; then
        existing_shorthand=$(echo "$existing_alias" | sed "s/^alias \([^=]*\)=.*/\1/")
        yellow "Command '${COMMAND}' is already aliased as '${existing_shorthand}'"
        gum confirm "Add '${SHORTHAND}' as a second alias for this command?" || exit 0
    fi

    # 4. Insert into the aliases file
    first_word="${COMMAND%% *}"
    new_line="alias ${SHORTHAND}='${COMMAND}'"
    result=$(alias-insert "$ALIASES_FILE" "$first_word" "$new_line")

    if [[ "$result" == "existing" ]]; then
        green "Added to existing '# ${first_word}' section:"
    else
        green "Created new '# ${first_word}' section and added alias:"
    fi
    cyan "  ${new_line}"
    echo ""
    bold "To activate in your current shell, run:"
    cyan "  source ${ALIASES_FILE}"

# One-time setup: generate SSH key, register on GitHub, switch chezmoi remote to SSH
# Run after: gh auth login (as okeefj22) and gh auth refresh -s admin:public_key
setup-chezmoi-ssh:
    #!/usr/bin/env bash
    set -euo pipefail

    KEY="$HOME/.ssh/id_ed25519_personal"
    SSH_HOST="github.com-personal"
    CHEZMOI_DIR="$HOME/.local/share/chezmoi"
    REMOTE_SSH="git@${SSH_HOST}:okeefj22/dotfiles.git"

    red()   { gum style --foreground 1 "$*"; }
    green() { gum style --foreground 2 "$*"; }
    cyan()  { gum style --foreground 6 "$*"; }
    bold()  { gum style --bold         "$*"; }

    # 1. Check gh is authenticated as okeefj22
    if ! gh auth status 2>&1 | grep -q "okeefj22"; then
        red "Error: gh is not authenticated as okeefj22"
        cyan "  Run: gh auth login"
        exit 1
    fi

    # 2. Generate SSH key if it doesn't exist
    if [[ -f "$KEY" ]]; then
        green "SSH key already exists: $KEY"
    else
        bold "Generating SSH key..."
        ssh-keygen -t ed25519 -f "$KEY" -C "$(git config user.email || echo 'personal')"
        green "SSH key generated: $KEY"
    fi

    # 3. Add to SSH agent
    eval "$(ssh-agent -s)" > /dev/null 2>&1 || true
    ssh-add "$KEY" 2>/dev/null || true
    green "SSH key added to agent"

    # 4. Register on GitHub if not already there
    KEY_FINGERPRINT=$(ssh-keygen -lf "$KEY" | awk '{print $2}')
    if gh ssh-key list 2>/dev/null | grep -q "$KEY_FINGERPRINT"; then
        green "SSH key already registered on GitHub"
    else
        bold "Registering SSH key on GitHub..."
        if gh ssh-key add "${KEY}.pub" --title "$(hostname)" 2>/dev/null; then
            green "SSH key registered on GitHub"
        else
            red "Failed to register SSH key. You may need to run:"
            cyan "  gh auth refresh -h github.com -s admin:public_key"
            cyan "Then re-run: just setup-chezmoi-ssh"
            exit 1
        fi
    fi

    # 5. Verify SSH connection
    if ssh -T "git@${SSH_HOST}" 2>&1 | grep -q "successfully authenticated"; then
        green "SSH authentication to GitHub verified"
    else
        red "SSH authentication failed. Check ~/.ssh/config has the ${SSH_HOST} host alias."
        exit 1
    fi

    # 6. Switch chezmoi remote to SSH
    CURRENT_REMOTE=$(git -C "$CHEZMOI_DIR" remote get-url origin 2>/dev/null || echo "")
    if [[ "$CURRENT_REMOTE" == "$REMOTE_SSH" ]]; then
        green "chezmoi remote already using SSH"
    else
        git -C "$CHEZMOI_DIR" remote set-url origin "$REMOTE_SSH"
        green "chezmoi remote switched to SSH: $REMOTE_SSH"
    fi

    echo ""
    bold "Setup complete! chezmoi push no longer depends on gh auth."
    cyan "  Test with: chezmoi cd && git push --dry-run"

test:
    echo "Hello, world!"
    echo "This is a test."
    echo "Justfile is working correctly."
    echo "All tests passed!"

gum-colors:
    #!/usr/bin/env bash
    echo "Gum Color Palette Preview"
    echo "=========================="
    echo ""
    # Iterate through all 256 colors
    for color in {0..255}; do
      gum style \
        --foreground "$color" --border-foreground "$color" --border double \
        --align center --width 70 --margin "0 1" --padding "1 2" \
        "Color $color" \
        "Gum Color Preview" \
        "Terminal Color Palette Demo"
    
      # Optional: pause every 10 colors so you can see them better
      if [ $((color % 10)) -eq 9 ]; then
        echo ""
        read -p "Press Enter to continue (showing colors $((color-9))-$color)..."
        echo ""
      fi
    done
    echo ""
    echo "Done! Preview complete."
