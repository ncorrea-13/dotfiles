#!/usr/bin/env bash
set -uo pipefail

NVIM="$HOME/.local/share/mise/shims/nvim"
MASON_PACKAGES="$HOME/.local/share/nvim/mason/packages"
REGISTRY_JSON="$HOME/.local/share/nvim/mason/registries/github/mason-org/mason-registry/registry.json"

REGISTRY_TIMEOUT=30
INSTALL_TIMEOUT=120
KILL_GRACE=10
run_with_timeout() {
  local secs=$1
  shift

  setsid "$@" &
  local pid=$!

  (
    sleep "$secs"
    kill -TERM -- -"$pid" 2>/dev/null
    sleep "$KILL_GRACE"
    kill -KILL -- -"$pid" 2>/dev/null
  ) &
  local watcher=$!

  wait "$pid" 2>/dev/null
  local status=$?

  # el proceso ya terminó, no hace falta el watcher: lo matamos en silencio
  kill "$watcher" 2>/dev/null
  wait "$watcher" 2>/dev/null

  return "$status"
}

echo "Updating Mason registry..."
run_with_timeout "$REGISTRY_TIMEOUT" \
  "$NVIM" --headless -c "lua require('mason-registry').update(function() vim.cmd('qall!') end)" \
  2>/dev/null
status=$?

if [ "$status" -eq 124 ] || [ "$status" -eq 137 ]; then
  echo "Registry update timed out, aborting."
  exit 1
elif [ "$status" -ne 0 ]; then
  echo "Registry update failed (exit $status), aborting."
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

failed=()

for pkg_name in "${to_update[@]}"; do
  echo ""
  echo "-> $pkg_name"

  run_with_timeout "$INSTALL_TIMEOUT" \
    "$NVIM" --headless -c "lua local pkg = require('mason-registry').get_package('$pkg_name'); local ok, handle = pcall(function() return pkg:install() end); if not ok then print('install() error'); vim.cmd('qall!'); return end; handle:on('stdout', vim.schedule_wrap(function(chunk) io.write(chunk) end)); handle:on('stderr', vim.schedule_wrap(function(chunk) io.write(chunk) end)); handle:once('closed', vim.schedule_wrap(function() vim.cmd('qall!') end))"
  status=$?

  if [ "$status" -eq 124 ] || [ "$status" -eq 137 ]; then
    echo "   timeout updating $pkg_name, skipped"
    failed+=("$pkg_name")
  elif [ "$status" -ne 0 ]; then
    echo "   error updating $pkg_name (exit $status)"
    failed+=("$pkg_name")
  fi
done

echo ""
if [ ${#failed[@]} -gt 0 ]; then
  echo "Mason: update complete with issues in: ${failed[*]}"
  exit 1
fi

echo "Mason: update complete."
