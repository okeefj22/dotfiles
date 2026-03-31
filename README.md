# dotfiles

macOS dotfiles managed with [chezmoi](https://www.chezmoi.io/). Includes shell configuration, editor setups, modern CLI tool replacements, and automated bootstrap scripts for getting a new machine up and running quickly.

## Quick Start

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply okeefj22
```

You'll be prompted for:

- **Personal git name** and **email** (used for `~/.gitconfig-personal`)
- **Work git email** (used for `~/.gitconfig-work`)

After init, bootstrap scripts run automatically to install Homebrew, run `brew bundle`, set up symlinks, and apply macOS defaults.

## What's Included

| Category | Configs | Description |
|----------|---------|-------------|
| **Shell** | `.zshrc`, `aliases.zsh`, `functions.zsh`, `p10k.zsh`, `.zshenv`, `.zprofile` | Zsh with Powerlevel10k, custom aliases, vi mode, fzf integration |
| **Git** | `.gitconfig`, `.gitconfig-personal`, `.gitconfig-work` | Multi-identity setup with conditional includes per directory |
| **Editors** | Neovim (`init.lua`, `options.lua`), Zed (`settings.json`) | Neovim as primary editor, Zed as secondary |
| **Terminals** | WezTerm (`wezterm.lua`), Ghostty (`config`) | WezTerm primary (Catppuccin Frappe theme), Ghostty config |
| **Tools** | lazygit, k9s, Karabiner, gh, gh-dash | Git TUI, Kubernetes TUI, keyboard remapping, GitHub CLI + dashboard |
| **Packages** | `Brewfile` | Homebrew formulas, casks, and taps -- auto-installed on bootstrap |
| **Utilities** | `justfile`, `alias-insert` | Task runner recipes, alias management script |

### Git Multi-Identity

Git config uses [conditional includes](https://git-scm.com/docs/git-config#_conditional_includes) based on directory:

- `~/source-code/work/` -- work identity
- `~/source-code/personal/` -- personal identity
- `~/.local/`, `~/.config/` -- personal identity

## Modern CLI Tools

Traditional tools are replaced with faster, more ergonomic alternatives:

| Traditional | Replacement | Alias | Notes |
|-------------|-------------|-------|-------|
| `ls` | [eza](https://github.com/eza-community/eza) | `ls='eza --icons=auto'` | Icons, git status, better colours |
| `cat` | [bat](https://github.com/sharkdp/bat) | `cat='bat'` | Syntax highlighting, line numbers |
| `grep` | [ripgrep](https://github.com/BurntSushi/ripgrep) | `rg` | Fast, respects `.gitignore` |
| `find` | [fd](https://github.com/sharkdp/fd) | `fd` | Simpler syntax, faster |
| `cd` | [zoxide](https://github.com/ajeetdsouza/zoxide) | `z` | Frecency-based directory jumping |

## Shell Setup

### Features

- **Vi mode** with fast mode switching (`KEYTIMEOUT=1`)
- **fzf** fuzzy finder integrated with fd for file/directory search
- **fzf-tab** for completion menu fuzzy matching (pulled via `.chezmoiexternal.toml`)
- **zoxide** for smart directory jumping
- **atuin** for shell history search and sync
- **zsh-syntax-highlighting** and **zsh-autosuggestions**
- **Powerlevel10k** prompt theme

### Key Aliases

```bash
# Navigation
..='cd ..'
...='cd ../..'

# Git
gcmsg='git commit -m'
gcm='git checkout master'

# GitHub CLI
ghd='gh dash'              # GitHub dashboard
ghpr='gh pr create'        # Create pull request
ghas='gh auth switch'      # Switch GitHub account
ghcs='gh copilot suggest'  # AI suggestions

# TUIs
lzg='lazygit'
lzd='lazydocker'
```

See [`aliases.zsh`](dot_config/zsh/aliases.zsh) for the full list.

## Bootstrap Scripts

These run automatically during `chezmoi apply`:

| Script | Runs | What it does |
|--------|------|-------------|
| `01-install-homebrew.sh` | Once | Installs Homebrew if missing (supports Apple Silicon and Intel) |
| `02-brew-bundle.sh` | On Brewfile change | Runs `brew bundle` to install all packages from `~/Brewfile` |
| `03-setup-symlinks.sh` | Once | Creates symlinks in `~/.local/bin/` for GUI apps (e.g. Vivaldi) |
| `04-macos-defaults.sh` | Once | Applies macOS system preferences (see below) |

## macOS Defaults

The `04-macos-defaults.sh` script configures:

- **Dock** -- autohide enabled, Quick Note hot corner (bottom-right), App Expose gesture
- **Finder** -- list view by default, search scoped to current folder, show external/removable drives, hide internal drives
- **Keyboard** -- key repeat enabled (press-and-hold disabled), full keyboard access, show all file extensions
- **Screenshots** -- save to clipboard instead of Desktop
- **Menu Bar** -- clock shows AM/PM and day of week, input source hidden
- **Windows** -- no minimize on double-click

Restarts Dock, Finder, and SystemUIServer to apply changes.

## Post-Install Steps

A few things still require manual setup after bootstrap:

```bash
# SSH keys -- generate or restore from backup
ssh-keygen -t ed25519 -C "your-email@example.com"

# Authenticate GitHub CLI
gh auth login

# Install Rust (not in Brewfile)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## External Dependencies

Managed via [`.chezmoiexternal.toml`](.chezmoiexternal.toml):

| Dependency | Source | Purpose |
|------------|--------|---------|
| [fzf-tab](https://github.com/Aloxaf/fzf-tab) | Git repo (refreshed weekly) | Fuzzy completion for zsh tab completion |
