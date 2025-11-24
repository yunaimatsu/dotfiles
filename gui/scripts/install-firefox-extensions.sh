#!/bin/bash
# Install Firefox Extensions
# Usage: ./scripts/install-firefox-extensions.sh

set -euo pipefail

# Configuration
FIREFOX_PROFILE="$HOME/.mozilla/firefox/a2v38d27.default-release"
EXTENSIONS_DIR="$FIREFOX_PROFILE/extensions"
TEMP_DIR="/tmp/firefox-extensions"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if Firefox profile exists
if [ ! -d "$FIREFOX_PROFILE" ]; then
    echo -e "${RED}Error: Firefox profile not found at $FIREFOX_PROFILE${NC}"
    echo "Please update FIREFOX_PROFILE in this script"
    exit 1
fi

# Create directories
mkdir -p "$EXTENSIONS_DIR"
mkdir -p "$TEMP_DIR"

# Extension list (ID => Download URL)
declare -A EXTENSIONS=(
    # uBlock Origin
    ["uBlock0@raymondhill.net"]="https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"

    # Tree Style Tab
    ["treestyletab@piro.sakura.ne.jp"]="https://addons.mozilla.org/firefox/downloads/latest/tree-style-tab/latest.xpi"

    # Bitwarden
    ["{446900e4-71c2-419f-a6a7-df9c091e268b}"]="https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi"

    # Dark Reader
    ["addon@darkreader.org"]="https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi"

    # Vim Vixen
    ["vim-vixen@i-beam.org"]="https://addons.mozilla.org/firefox/downloads/latest/vim-vixen/latest.xpi"

    # Multi-Account Containers
    ["@testpilot-containers"]="https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi"

    # Privacy Badger
    ["jid1-MnnxcxisBPnSXQ@jetpack"]="https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi"
)

# Function to install extension
install_extension() {
    local id="$1"
    local url="$2"
    local filename="$TEMP_DIR/$id.xpi"
    local target="$EXTENSIONS_DIR/$id.xpi"

    echo -e "${YELLOW}Installing: $id${NC}"

    # Download extension
    if wget -q --show-progress -O "$filename" "$url"; then
        # Copy to extensions directory
        cp "$filename" "$target"
        echo -e "${GREEN}✓ Installed: $id${NC}"
    else
        echo -e "${RED}✗ Failed to download: $id${NC}"
        return 1
    fi
}

# Main installation loop
echo "Starting Firefox extension installation..."
echo "Target: $EXTENSIONS_DIR"
echo ""

SUCCESS_COUNT=0
FAIL_COUNT=0

for id in "${!EXTENSIONS[@]}"; do
    url="${EXTENSIONS[$id]}"
    if install_extension "$id" "$url"; then
        ((SUCCESS_COUNT++))
    else
        ((FAIL_COUNT++))
    fi
    echo ""
done

# Summary
echo "======================================"
echo "Installation Summary:"
echo -e "${GREEN}Successful: $SUCCESS_COUNT${NC}"
echo -e "${RED}Failed: $FAIL_COUNT${NC}"
echo "======================================"

# Cleanup
rm -rf "$TEMP_DIR"

# Instructions
echo ""
echo "Next steps:"
echo "1. Restart Firefox"
echo "2. Extensions should be installed automatically"
echo "3. Configure each extension as needed"

if [ $FAIL_COUNT -gt 0 ]; then
    exit 1
fi
