# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

**westerOS** is a Nix Flakes-based NixOS configuration managing multiple machines named after Game of Thrones houses: **targaryen** (desktop), **stark** (Framework laptop), **lannister**, and **hightower** (SSH alias, no host directory).

## Rebuild commands

```bash
# Full rebuild (interactive — opens nvim for confirmation, then switches)
westerOS_rebuild_full

# Test rebuild (temporary activation, creates a git commit)
westerOS_rebuild_test

# Manual equivalent
sudo nixos-rebuild switch --flake .#<hostname>

# Garbage collect old generations
westerOS_garbage_collect
```

Both `westerOS_rebuild_*` scripts auto-detect hostname, preview a git diff, and send a desktop notification on completion.

## Repo layout

```
flake.nix                     # Defines all 4 NixOS system configurations
modules/                      # Shared NixOS modules (settings, users, networking, devices)
  settings.nix                # Nix settings, boot, SSD, memory tuning
  users.nix                   # User "cameron", groups, session vars
  networking-{host}.nix       # Per-host network config
  devices-stark.nix           # Laptop-specific hardware (fingerprint, fan, battery)
  fan-control.nix             # Stark fan curve management
hosts/{targaryen,stark,lannister}/
  configuration.nix           # Host-specific NixOS config
  hardware-configuration.nix  # Generated hardware config
  home-configuration.nix      # Home-manager entrypoint for this host
pkgs/                         # Package lists (imported into configurations)
  gui-pkgs.nix                # GUI apps (discord, obs, calibre, transmission, etc.)
  term-pkgs.nix               # CLI tools (btop, fzf, lazygit, claude-code, etc.)
  wm-pkgs.nix                 # Hyprland, SDDM, waybar, rofi, screenshot tools
  fonts.nix                   # System fonts (Noto, Fira Code Nerd Font, etc.)
home-manager/configs/         # Per-app home-manager modules
  hypr/{targaryen,stark,lannister}.nix  # Host-specific Hyprland configs
  zsh/{targaryen}.nix         # Host-specific shell config
  emacs/doom/                 # Doom Emacs config (config.el, init.el, packages.el)
  {kitty,nvim,tmux,waybar,rofi,starship,swaync,walker}/
bin/                          # Custom scripts with westerOS_ prefix (36+)
```

## Architecture patterns

**Flake inputs of note:**
- `nixpkgs_tx` — pinned to a specific commit solely for Transmission 4.0.0 (used only in `gui-pkgs.nix`)
- `stylix` — system-wide theming framework (Catppuccin Mocha throughout)
- `walker` + `elephant` — app launcher with background service

**Host-specific splitting:** When a config differs per machine (Hyprland keybindings, zsh aliases, networking), it lives in `home-manager/configs/<app>/<hostname>.nix` and is imported in the host's `home-configuration.nix`. Shared config stays in the main module.

**Package organisation:** Packages are split by category in `pkgs/` and imported into host `configuration.nix`. Don't add packages directly to host configs — add to the appropriate `pkgs/*.nix` file.

**Nix formatter:** Use `alejandra` (available in the environment) to format `.nix` files.

## Key host differences

| Host | Notable specifics |
|------|-------------------|
| targaryen | YubiKey sudo auth, static IP 192.168.0.114, Tailscale, SSH open |
| stark | Fingerprint sudo auth (fprintd), AMD GPU, MT7925 WiFi, battery saver scripts, Logitech wireless |
| lannister | Dvorak keyboard layout |

## Theming

All theming flows through **stylix** with Catppuccin Mocha. Plymouth boot theme, SDDM, and application-level theming are all coordinated here. Wallpapers live in the theme directory; `westerOS_bg_next` picks one randomly.
