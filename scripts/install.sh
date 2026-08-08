#!/usr/bin/env bash
# Symlinks these dotfiles into $HOME. Doesn't touch packages -- install your
# own deps first (see docs/PERSONALPROGRAMS.md), this only wires up configs.

set -uo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
YES=0
[[ "${1:-}" == "-y" || "${1:-}" == "--yes" ]] && YES=1

confirm() {
    ((YES)) && return 0
    read -rp "$1 [y/N] " reply
    [[ "$reply" =~ ^[Yy]$ ]]
}

backup_if_needed() {
    local target="$1"
    if [[ -L "$target" ]]; then
        rm "$target"
    elif [[ -e "$target" ]]; then
        mv "$target" "$target.bak-$(date +%s)"
        echo "Backed up existing $target"
    fi
}

link_configs() {
    mkdir -p "$HOME/.config"
    for item in "$REPO_DIR"/.config/*/; do
        name="$(basename "$item")"
        backup_if_needed "$HOME/.config/$name"
        ln -sfn "$REPO_DIR/.config/$name" "$HOME/.config/$name"
    done
    for f in .zshrc .alias .eget.toml .start-sway.sh; do
        backup_if_needed "$HOME/$f"
        ln -sf "$REPO_DIR/$f" "$HOME/$f"
    done
    echo "Configs symlinked."
}

main() {
    confirm "Symlink configs from repo into \$HOME (existing files get backed up)?" || exit 0
    link_configs
    echo -e "\nDone. Install deps from docs/PERSONALPROGRAMS.md, then restart your session."
}

main
