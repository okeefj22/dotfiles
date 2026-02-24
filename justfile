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
