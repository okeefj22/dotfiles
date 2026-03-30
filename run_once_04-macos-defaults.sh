#!/bin/bash
# Apply macOS system preferences
# This runs once per machine via chezmoi run_once_
# Review and adjust these settings to your preferences

set -euo pipefail

echo "Applying macOS system preferences..."

# Close System Preferences to prevent it from overriding changes
osascript -e 'tell application "System Preferences" to quit' 2>/dev/null || true
osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true

# =============================================================================
# Dock
# =============================================================================
defaults write com.apple.dock autohide -bool true
# Hot corner: bottom-right -> Quick Note (action 14)
defaults write com.apple.dock wvous-br-corner -int 14
defaults write com.apple.dock wvous-br-modifier -int 0
# App Expose gesture
defaults write com.apple.dock showAppExposeGestureEnabled -bool true

# =============================================================================
# Finder
# =============================================================================
# Default to List view
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Search the current folder by default
defaults write com.apple.finder FXLastSearchScope -string "SCcf"
# Show external drives on desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
# Don't show internal drives on desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
# Show removable media on desktop
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
# Disable iCloud Drive integration
defaults write com.apple.finder FXICloudDriveEnabled -bool false
defaults write com.apple.finder FXICloudDriveDesktop -bool false
defaults write com.apple.finder FXICloudDriveDocuments -bool false

# =============================================================================
# Keyboard & Input
# =============================================================================
# Enable key repeat (disable press-and-hold for accented characters)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# Show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Full keyboard access (Tab through all UI controls)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 2
# Don't minimize on double-click title bar
defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool false

# =============================================================================
# Screenshots
# =============================================================================
# Save screenshots to clipboard instead of Desktop
defaults write com.apple.screencapture target -string "clipboard"

# =============================================================================
# Menu Bar Clock
# =============================================================================
defaults write com.apple.menuextra.clock ShowAMPM -bool true
defaults write com.apple.menuextra.clock ShowDate -int 0
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true

# =============================================================================
# Text Input
# =============================================================================
# Don't show input source in menu bar
defaults write com.apple.TextInputMenu visible -bool false

# =============================================================================
# Restart affected services
# =============================================================================
echo "Restarting Dock and Finder to apply changes..."
killall Dock 2>/dev/null || true
killall Finder 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

echo "macOS defaults applied successfully."
echo "Note: Some changes may require a logout/restart to take full effect."
