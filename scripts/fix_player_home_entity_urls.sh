#!/usr/bin/env bash
set -e

ROOT="docs/outputs/players"

echo "Fixing HOME_URL and ENTITY_MENU_URL in player files under:"
echo "  $ROOT"
echo

shopt -s nullglob
for f in "$ROOT"/*_player.html; do
  echo "→ Updating $(basename "$f")"

  # HOME_URL
  sed -i \
    -e 's|const HOME_URL *= *".*";|const HOME_URL = "/SOP_Stage/";|g' \
    -e "s|const HOME_URL *= *'.*';|const HOME_URL = \"/SOP_Stage/\";|g" \
    "$f"

  # ENTITY_MENU_URL
  sed -i \
    -e 's|const ENTITY_MENU_URL *= *".*";|const ENTITY_MENU_URL = "/SOP_Stage/";|g' \
    -e "s|const ENTITY_MENU_URL *= *'.*';|const ENTITY_MENU_URL = \"/SOP_Stage/\";|g" \
    "$f"
done

echo
echo "Done. Review with:"
echo "  git diff"
