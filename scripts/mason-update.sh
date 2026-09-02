#!/usr/bin/env bash
set -euo pipefail

NVIM="$HOME/.local/share/mise/shims/nvim"
MASON_PACKAGES="$HOME/.local/share/nvim/mason/packages"
REGISTRY_JSON="$HOME/.local/share/nvim/mason/registries/github/mason-org/mason-registry/registry.json"

echo "Updating Mason registry..."
timeout 30 "$NVIM" --headless -c "lua require('mason-registry').update(function() vim.cmd('qall') end)" 2>/dev/null
if [ $? -eq 124 ]; then
  echo "Registry update timed out, aborting."
  exit 1
fi

to_update=()

for pkg_dir in "$MASON_PACKAGES"/*/; do
  pkg_name=$(basename "$pkg_dir")
  receipt="$pkg_dir/mason-receipt.json"
  [ -f "$receipt" ] || continue

  installed_id=$(jq -r '.source.id // empty' "$receipt")
  [ -n "$installed_id" ] || continue

  latest_id=$(jq -r --arg name "$pkg_name" '.[] | select(.name == $name) | .source.id // empty' "$REGISTRY_JSON")
  [ -n "$latest_id" ] || continue

  installed_version="${installed_id##*@}"
  latest_version="${latest_id##*@}"

  if [ "$installed_version" != "$latest_version" ]; then
    echo "  outdated: $pkg_name ($installed_version -> $latest_version)"
    to_update+=("$pkg_name")
  fi
done

if [ ${#to_update[@]} -eq 0 ]; then
  echo "Everything is up to date."
  exit 0
fi

echo ""
echo "Updating ${#to_update[@]} package(s): ${to_update[*]}"

for pkg_name in "${to_update[@]}"; do
  echo ""
  echo "-> $pkg_name"
  timeout 120 "$NVIM" --headless -c "lua local pkg = require('mason-registry').get_package('$pkg_name'); local handle = pkg:install(); handle:on('stdout', vim.schedule_wrap(function(chunk) io.write(chunk) end)); handle:on('stderr', vim.schedule_wrap(function(chunk) io.write(chunk) end)); handle:once('closed', function() vim.cmd('qall') end)"
  if [ $? -eq 124 ]; then
    echo "   timeout updating $pkg_name, skipped"
  fi
done

echo ""
echo "Mason: update complete."
