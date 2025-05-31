#!/bin/bash

# Fixed match file path
MATCH_FILE="$HOME/dotfiles/ESPANSO_MATCH.yml"

# Create file with YAML comment if it doesn't exist
if [ ! -f "$MATCH_FILE" ]; then
  echo "# Espanso Matches" > "$MATCH_FILE"
fi

echo "=== Add new Espanso Match ==="

# Prompt user for trigger
read -p "Enter trigger (e.g. :brb): " TRIGGER
if [[ -z "$TRIGGER" ]]; then
  echo "❌ Trigger cannot be empty."
  exit 1
fi

# Prompt user for replacement
read -p "Enter replacement text: " REPLACEMENT
if [[ -z "$REPLACEMENT" ]]; then
  echo "❌ Replacement text cannot be empty."
  exit 1
fi

# Append the match with 2-space indentation
cat <<EOF >> "$MATCH_FILE"

  - trigger: "$TRIGGER"
    replace: "$REPLACEMENT"
EOF

echo "✅ Match added to $MATCH_FILE with indentation."

espanso restart
