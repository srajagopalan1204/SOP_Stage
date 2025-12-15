#!/usr/bin/env bash
set -euo pipefail

# import_outputs_bundle_from_build_v1_0.sh
# Version: SOP_STAGE_IMPORT_OUTPUTS_v1.0
# Built: 2025-12-13 America/New_York
# Owner: Subi
#
# Wipes docs/outputs then unzips a bundle created by SOP_Build export script.

if [ $# -lt 1 ]; then
  echo "USAGE: bash import_outputs_bundle_from_build_v1_0.sh /path/to/SOPB_outputs_for_SOP_Stage_YYYYMMDD_HHMM.zip"
  exit 2
fi

BUNDLE="$1"

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
DESTDOCS="$ROOT/docs"
DESTOUT="$DESTDOCS/outputs"

if [ ! -f "$BUNDLE" ]; then
  echo "ERROR: bundle not found: $BUNDLE"
  exit 2
fi

mkdir -p "$DESTDOCS"

echo "Wiping: $DESTOUT"
rm -rf "$DESTOUT"
mkdir -p "$DESTOUT"

echo "Importing bundle into: $DESTDOCS"
unzip -q "$BUNDLE" -d "$DESTDOCS"

echo "Done. Top of outputs:"
ls -l "$DESTOUT" | head
