#!/usr/bin/env bash
set -euo pipefail

# import_outputs_bundle_into_stage.sh
# Built: 2025-12-13 America/New_York
# Usage: bash scripts/import_outputs_bundle_into_stage.sh /path/to/SOPB_outputs_for_SOP_Stage_*.zip

if [ $# -lt 1 ]; then
  echo "Usage: $0 /path/to/SOPB_outputs_for_SOP_Stage_*.zip"
  exit 2
fi

ZIP="$1"
if [ ! -f "$ZIP" ]; then
  echo "ERROR: zip not found: $ZIP"
  exit 2
fi

TZ=${TZ:-America/New_York}
STAMP=$(TZ="$TZ" date +%Y%m%d_%H%M)

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
PUB="$ROOT/site/BUILD"
BACK="$ROOT/Prev_import/$STAMP"

mkdir -p "$PUB" "$BACK"

# Backup existing outputs (if any)
if [ -d "$PUB/outputs" ]; then
  mkdir -p "$BACK/site/BUILD"
  cp -a "$PUB/outputs" "$BACK/site/BUILD/outputs"
  echo "Backed up existing outputs to: $BACK"
fi

# Unzip into publish root (so it creates/overwrites site/BUILD/outputs/...)
unzip -o "$ZIP" -d "$PUB" >/dev/null

if [ ! -d "$PUB/outputs" ]; then
  echo "ERROR: After unzip, expected $PUB/outputs but it was not found."
  exit 2
fi

echo "OK: Imported outputs into: $PUB/outputs"
