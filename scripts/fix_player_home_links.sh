#!/usr/bin/env bash
set -e

ROOT="/workspaces/SOP_Stage/docs/outputs/players"

echo "Fixing Home / Entity links in player files under:"
echo "  $ROOT"
echo

shopt -s nullglob
for f in "$ROOT"/*_player.html; do
  echo "→ Updating $(basename "$f")"

  # Replace common broken relative patterns with absolute site root
  sed -i \
    -e 's|href="\(\.\./\)*index\.html"|href="/SOP_Stage/"|g' \
    -e 's|href="index\.html"|href="/SOP_Stage/"|g' \
    "$f"
done

echo
echo "Done. Review changes with:"
echo "  git diff"
