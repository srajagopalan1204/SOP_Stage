#!/usr/bin/env bash
set -euo pipefail

# import_one_sop_bundle_v1_0.sh
# Version: SOP_STAGE_IMPORT_ONE_SOP_v1.0
# Built: 2025-12-14 America/New_York
# Owner: Subi

if [ $# -lt 1 ]; then
  echo "USAGE: bash import_one_sop_bundle_v1_0.sh /path/to/SOPB_<SOP>_for_STAGE_YYYYMMDD_HHMM.zip"
  exit 2
fi

BUNDLE="$1"
ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
DESTDOCS="$ROOT/docs"

[ -f "$BUNDLE" ] || { echo "Bundle not found: $BUNDLE"; exit 2; }

mkdir -p "$DESTDOCS"

# Unzip into docs/ so bundle's "outputs/..." lands at docs/outputs/...
unzip -q -o "$BUNDLE" -d "$DESTDOCS"

echo "Imported bundle into: $DESTDOCS"
echo "Updated players:"
ls -l "$DESTDOCS/outputs/players" | tail -n +1 | head
