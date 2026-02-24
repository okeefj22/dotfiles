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
