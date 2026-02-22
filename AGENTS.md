# AGENTS.md - Development Environment Reference

> **Purpose**: This file serves as a living source of truth for my development environment. It documents the CLI tools, configurations, and workflows I actively use (not just what's installed). Use this to understand my setup and preferences.

**Last Updated**: 2026-02-20

---

## Table of Contents
- [Modern CLI Tool Substitutions](#modern-cli-tool-substitutions)
- [Core CLI Tools](#core-cli-tools)
- [Development Environment](#development-environment)
- [Editors & Terminal](#editors--terminal)
- [Key Workflows](#key-workflows)
- [Configuration Files](#configuration-files)
- [Shell Configuration](#shell-configuration)
- [Dotfile Management](#dotfile-management)
- [How to Discover My Setup](#how-to-discover-my-setup)

---

## Modern CLI Tool Substitutions

**I use modern alternatives to traditional Unix tools. Always prefer these:**

| Traditional Tool | Modern Alternative | My Alias | Notes |
|-----------------|-------------------|----------|-------|
| `ls` | `eza` | `ls='eza --icons=auto'` | Better colors, icons, git integration |
| `cat` | `bat` | `cat='bat'` | Syntax highlighting, line numbers |
| `grep` | `rg` (ripgrep) | - | Much faster, respects .gitignore |
| `find` | `fd` | - | Simpler syntax, faster |
| `cd` | `zoxide` | `z` command | Smart directory jumping |

**When writing scripts or commands for me, use the modern alternatives by default.**

---

## Core CLI Tools

### File & Navigation
- **eza** - Modern ls replacement with icons and git status (aliased as `ls`, see ~/.aliases.zsh)
- **bat** - Cat with syntax highlighting (aliased as `cat`, see ~/.aliases.zsh)
- **fzf** - Fuzzy finder (heavily integrated in my shell)
- **fd** - Modern find alternative (used with fzf, replaces `find`)
- **rg/ripgrep** - Fast grep replacement (replaces `grep`)
- **zoxide** - Smarter cd command (use `z` command)

### Git & GitHub
- **lazygit** - Terminal UI for git (alias: `lzg`)
- **gh** - GitHub CLI with extensions:
  - `gh dash` (alias: `ghd`) - Dashboard
  - `gh copilot suggest` (alias: `ghcs`) - AI suggestions
  - `gh pr create` (alias: `ghpr`)
  - `gh auth switch` (alias: `ghas`) - Multi-account switching

### Docker & Kubernetes
- **lazydocker** - Terminal UI for Docker (alias: `lzd`)
- **kubectl** - Kubernetes CLI
- **k9s** - Kubernetes TUI
- **colima** - Container/VM runtime
- **helm** - Kubernetes package manager

### Shell & History
- **atuin** - Shell history search and sync
- **powerlevel10k** - Zsh theme (config: `~/.p10k.zsh`)

---

## Development Environment

### Languages & Runtimes
- **Node.js** - Installed via Homebrew (v25.6.1), not using nvm
  - Have nvm with v20.15.1 installed but inactive
  - Using Bun for fast runtime/package management (not Deno)
- **Python** - System Python with uv for package management
- **Go** - Installed via Homebrew
- **Rust** - Managed via rustup

### Package Managers
- **Homebrew** - macOS package manager
  - Brewfile location: `~/Brewfile`
  - Organized into sections: Personal Tools, Work Tools, Dependencies
  - Check tracked packages: `grep -c "^brew\|^cask\|^tap" ~/Brewfile`
  - Check installed: `brew list --formula | wc -l` (formulas), `brew list --cask | wc -l` (casks)
  - Run `brew bundle --file=~/Brewfile` to install all tracked packages
- **uv** - Fast Python package manager
  - Check installed tools: `uv tool list`
- **npm** - JavaScript packages
  - Check global packages: `npm list -g --depth=0`
- **cargo** - Rust packages
  - Check installed: `cargo install --list`

---

## Editors & Terminal

### Editors (Active Use)
- **Neovim** - Primary terminal editor
  - Config: `~/.config/nvim/`
  - Init file: `~/.config/nvim/init.lua`
- **VS Code** - GUI editor

### Terminal
- **WezTerm** - Primary terminal emulator
  - Config: `~/.config/wezterm/wezterm.lua`
  - Font size: 16
  - Theme: Catppuccin Frappe
  - Custom key mappings for € and # symbols

---

## Key Workflows

### 1. Kubernetes Development
- Use `k9s` for cluster navigation
- `kubectl` for direct cluster operations
- `helm` for package management

### 2. Docker/Container Workflows
- **colima** as container runtime
- **lazydocker** for container management TUI
- Docker CLI for advanced operations

### 3. Dotfile Management (chezmoi)
- Source directory: `~/.local/share/chezmoi`
- Auto-commit enabled
- Auto-apply on edit enabled
- Git remote: HTTPS (uses GitHub CLI auth)
- See [Dotfile Management](#dotfile-management) section below

### 4. Custom Keyboard Mappings
- **Karabiner-Elements** for keyboard remapping
- Config: `~/.config/karabiner/karabiner.json`

---

## Configuration Files

### Shell Configuration
```
~/.config/zsh/.zshrc           # Main zsh config (131 lines)
~/.aliases.zsh                 # Custom aliases (28 lines)
~/.zshenv                      # Zsh environment variables
~/.zprofile                    # Zsh profile
~/.p10k.zsh                    # Powerlevel10k theme (1712 lines)
```

### Git Configuration
```
~/.gitconfig                   # Main git config with conditional includes
~/.gitconfig-personal          # Personal git identity
~/.gitconfig-work             # Work git identity
~/.ssh/config                  # SSH config with github.com-personal alias
```

**Note**: Git configs use conditional includes based on directory:
- `~/source-code/work/` → uses work identity
- `~/source-code/personal/` → uses personal identity
- `~/.local/` and `~/.config/` → uses personal identity

### Editor Configurations
```
~/.config/nvim/                # Neovim config directory
~/.config/nvim/init.lua        # Neovim init file
```

### Tool Configurations
```
~/.config/wezterm/wezterm.lua  # WezTerm terminal config
~/.config/karabiner/           # Keyboard remapping
~/.config/lazygit/             # Lazygit config
~/.config/lazydocker/          # Lazydocker config
~/.config/k9s/                 # Kubernetes TUI config
~/.config/atuin/               # Shell history config
~/.config/gh/                  # GitHub CLI config
~/Brewfile                     # Homebrew packages
```

---

## Shell Configuration

### Aliases
**Location**: `~/.aliases.zsh`

Key aliases:
```bash
# File navigation
ls='eza --icons=auto'
cat='bat'

# Git
gcmsg='git commit -m'
gcm='git checkout master'

# GitHub
ghd='gh dash'
ghpr='gh pr create'
ghas='gh auth switch'
ghcs='gh copilot suggest -s'

# Docker/Git UIs
lzd='lazydocker'
lzg='lazygit'

# Navigation
..='cd ..'
...='cd ../..'
....='cd ../../..'
```

### Shell Features
- **Vi mode** enabled with quick mode switching (KEYTIMEOUT=1)
- **fzf** integrated with fd for file/directory search
- **zoxide** for smart directory jumping
- **atuin** for shell history search
- **Completions** from Homebrew and custom plugins
- **Syntax highlighting** via zsh-syntax-highlighting
- **Auto-suggestions** via zsh-autosuggestions

---

## Dotfile Management

### chezmoi Setup
- **Source directory**: `~/.local/share/chezmoi`
- **Destination**: `~` (home directory)
- **Git remote**: `https://github.com/okeefj22/dotfiles.git`
- **Auto-commit**: ✅ Enabled
- **Auto-push**: ❌ Disabled (manual push required)
- **Edit auto-apply**: ✅ Enabled

### Currently Managed Files
```
~/.aliases.zsh                      → dot_aliases.zsh
~/Brewfile                          → private_executable_Brewfile
~/.config/wezterm/wezterm.lua       → dot_config/wezterm/wezterm.lua
~/.config/zsh/.zshrc                → dot_config/zsh/dot_zshrc
~/.zshenv                           → dot_zshenv
~/.zprofile                         → dot_zprofile
~/.p10k.zsh                         → dot_p10k.zsh
~/AGENTS.md                         → AGENTS.md
```

### chezmoi Workflows
```bash
# Edit and auto-apply
chezmoi edit ~/.zshrc

# Add/update a file (auto-commits)
chezmoi add ~/.aliases.zsh

# Check differences
chezmoi diff

# See status
chezmoi status

# Jump to source directory
chezmoi cd

# Push changes to remote
chezmoi cd && git push

# Pull and apply from remote
chezmoi update
```

---

## How to Discover My Setup

**For AI agents and assistants working with my environment:**

### Finding Configuration Files
```bash
# Main shell config
cat ~/.config/zsh/.zshrc

# Aliases
cat ~/.aliases.zsh

# Git setup
cat ~/.gitconfig

# Powerlevel10k theme
cat ~/.p10k.zsh

# Neovim config
cat ~/.config/nvim/init.lua

# WezTerm config
cat ~/.config/wezterm/wezterm.lua

# Managed dotfiles
chezmoi managed

# List all config directories
ls -la ~/.config/
```

### Understanding My Tool Usage
```bash
# Check installed Homebrew packages
cat ~/Brewfile

# Count tracked brew packages
grep -c "^brew\|^cask\|^tap" ~/Brewfile

# Count installed packages
brew list --formula | wc -l  # formulas
brew list --cask | wc -l     # casks

# Check global uv tools
uv tool list

# Check global npm packages
npm list -g --depth=0

# Check cargo installed tools
cargo install --list

# See command history patterns
history | awk '{print $2}' | sort | uniq -c | sort -rn | head -20

# Check active GitHub account
gh auth status

# List available shells and plugins
ls ~/.config/zsh/plugins/

# See fzf configuration
env | grep FZF
```

### File Operations
- **Always use `rg`** instead of `grep` for content search
- **Always use `fd`** instead of `find` for file search
- **Use `bat`** for file preview (but `cat` alias points to it anyway)
- **Use `eza`** for directory listing (but `ls` alias points to it anyway)

### Git Operations
- I use **multiple GitHub accounts** (personal and work)
- Check current account: `gh auth status`
- Switch accounts: `gh auth switch` or `ghas` alias
- My git config uses conditional includes based on directory

---

## Notes

- This is a **living document** - update it as tools/workflows change
- Not everything installed is actively used - this tracks **actual usage**
- Config files referenced here are the source of truth for "how to do X"
- When in doubt, check the actual config files listed above

---

**For updates or questions about this setup, refer to the actual configuration files listed in each section.**
