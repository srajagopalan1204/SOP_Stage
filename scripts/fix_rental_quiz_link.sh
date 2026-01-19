#!/usr/bin/env bash
set -euo pipefail

F="docs/outputs/players/Rental_player.html"

if [[ ! -f "$F" ]]; then
  echo "ERROR: not found: $F"
  exit 1
fi

echo "Fixing Rental quiz link in: $F"

# Only fix the bad case: Quiz_Loc contains the quiz html filename.
# Change:
#   "Quiz_Loc": "quiz/PPS_Rental_quiz.html"
# to:
#   "Quiz_Loc": "quiz"
sed -i 's/"Quiz_Loc": "quiz\/PPS_Rental_quiz\.html"/"Quiz_Loc": "quiz"/g' "$F"

echo "After change, showing the S999 quiz fields:"
grep -n 'S999' -n "$F" | head -3 || true
grep -n '"Quiz_Loc":' "$F" | tail -5 || true
echo "Done. Now run: git diff"
