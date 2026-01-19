#!/usr/bin/env bash
# park_old_zips.sh
# Version: v1a_subi_20251227 (America/New_York)
# Owner: Subi
# Purpose: Park old import bundles (zip files) from rep_new/ into rep_new/Prev_import/<timestamp>/

set -euo pipefail

TZ_NAME="America/New_York"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REP_NEW="$ROOT/rep_new"
STAMP="$(TZ="$TZ_NAME" date +%Y%m%d_%H%M)"
DEST="$REP_NEW/Prev_import/$STAMP"

mkdir -p "$REP_NEW"
mkdir -p "$DEST"

shopt -s nullglob
zips=( "$REP_NEW"/*.zip )
shopt -u nullglob

if [ "${#zips[@]}" -eq 0 ]; then
  echo "No zip files found in: $REP_NEW"
  echo "Nothing to park."
  exit 0
fi

echo "Parking ${#zips[@]} zip file(s) into:"
echo "  $DEST"
echo

for z in "${zips[@]}"; do
  echo "  mv $(basename "$z")"
  mv -v "$z" "$DEST/"
done

echo
echo "Done."
echo "Current rep_new contents:"
ls -lh "$REP_NEW" || true
