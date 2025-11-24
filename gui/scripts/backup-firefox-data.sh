#!/bin/bash
# Backup Firefox Data (Bookmarks, Permissions, etc.)
# Usage: ./scripts/backup-firefox-data.sh

set -euo pipefail

# Configuration
FIREFOX_PROFILE="$HOME/.mozilla/firefox/a2v38d27.default-release"
BACKUP_DIR="$HOME/musea/firefox-backups/$(date +%Y%m%d-%H%M%S)"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "Firefox Data Backup Script"
echo "=========================="
echo ""

# Check if profile exists
if [ ! -d "$FIREFOX_PROFILE" ]; then
    echo "Error: Firefox profile not found at $FIREFOX_PROFILE"
    exit 1
fi

# Create backup directory
mkdir -p "$BACKUP_DIR"
echo -e "${YELLOW}Backup directory: $BACKUP_DIR${NC}"
echo ""

# Function to export SQLite table
export_sqlite() {
    local db="$1"
    local output="$2"
    local query="$3"

    if [ ! -f "$db" ]; then
        echo "Warning: Database not found: $db"
        return 1
    fi

    sqlite3 "$db" <<EOF
.mode json
.output $output
$query
.quit
EOF

    if [ -f "$output" ]; then
        echo -e "${GREEN}✓ Exported: $(basename $output)${NC}"
    else
        echo "✗ Failed to export: $(basename $output)"
        return 1
    fi
}

# 1. Bookmarks
echo "Exporting bookmarks..."
export_sqlite \
    "$FIREFOX_PROFILE/places.sqlite" \
    "$BACKUP_DIR/bookmarks.json" \
    "SELECT b.id, b.title, p.url, b.dateAdded, b.lastModified, b.parent,
            (SELECT title FROM moz_bookmarks WHERE id = b.parent) as parent_folder
     FROM moz_bookmarks b
     JOIN moz_places p ON b.fk = p.id
     WHERE b.type = 1
     ORDER BY b.dateAdded;"

# 2. Bookmark folders structure
echo "Exporting bookmark folders..."
export_sqlite \
    "$FIREFOX_PROFILE/places.sqlite" \
    "$BACKUP_DIR/bookmark-folders.json" \
    "SELECT id, title, parent, position, dateAdded
     FROM moz_bookmarks
     WHERE type = 2
     ORDER BY parent, position;"

# 3. History (last 1000 entries)
echo "Exporting browsing history..."
export_sqlite \
    "$FIREFOX_PROFILE/places.sqlite" \
    "$BACKUP_DIR/history.json" \
    "SELECT p.url, p.title, datetime(v.visit_date/1000000, 'unixepoch') as visit_time,
            v.visit_type, p.visit_count
     FROM moz_historyvisits v
     JOIN moz_places p ON v.place_id = p.id
     ORDER BY v.visit_date DESC
     LIMIT 1000;"

# 4. Permissions
echo "Exporting permissions..."
export_sqlite \
    "$FIREFOX_PROFILE/permissions.sqlite" \
    "$BACKUP_DIR/permissions.json" \
    "SELECT origin, type,
            CASE permission
                WHEN 1 THEN 'allow'
                WHEN 2 THEN 'deny'
                ELSE 'unknown'
            END as permission,
            expireType, expireTime, modificationTime
     FROM moz_perms
     ORDER BY origin, type;"

# 5. Content preferences (zoom, etc.)
echo "Exporting content preferences..."
export_sqlite \
    "$FIREFOX_PROFILE/content-prefs.sqlite" \
    "$BACKUP_DIR/content-prefs.json" \
    "SELECT g.name as domain, p.setting, v.value
     FROM prefs_values v
     LEFT JOIN groups g ON v.groupID = g.id
     JOIN prefs p ON v.settingID = p.id
     ORDER BY g.name, p.setting;"

# 6. Form history
echo "Exporting form history..."
export_sqlite \
    "$FIREFOX_PROFILE/formhistory.sqlite" \
    "$BACKUP_DIR/formhistory.json" \
    "SELECT fieldname, value, timesUsed, firstUsed, lastUsed
     FROM moz_formhistory
     ORDER BY lastUsed DESC
     LIMIT 500;"

# 7. Copy JSON configuration files
echo ""
echo "Copying configuration files..."

copy_if_exists() {
    local src="$1"
    local dest="$2"

    if [ -f "$src" ]; then
        cp "$src" "$dest"
        echo -e "${GREEN}✓ Copied: $(basename $src)${NC}"
    else
        echo "Warning: File not found: $(basename $src)"
    fi
}

copy_if_exists "$FIREFOX_PROFILE/containers.json" "$BACKUP_DIR/containers.json"
copy_if_exists "$FIREFOX_PROFILE/handlers.json" "$BACKUP_DIR/handlers.json"
copy_if_exists "$FIREFOX_PROFILE/extensions.json" "$BACKUP_DIR/extensions.json"
copy_if_exists "$FIREFOX_PROFILE/addons.json" "$BACKUP_DIR/addons.json"
copy_if_exists "$FIREFOX_PROFILE/extension-preferences.json" "$BACKUP_DIR/extension-preferences.json"
copy_if_exists "$FIREFOX_PROFILE/xulstore.json" "$BACKUP_DIR/xulstore.json"
copy_if_exists "$FIREFOX_PROFILE/prefs.js" "$BACKUP_DIR/prefs.js"

# 8. Copy userChrome/userContent if exists
if [ -d "$FIREFOX_PROFILE/chrome" ]; then
    mkdir -p "$BACKUP_DIR/chrome"
    copy_if_exists "$FIREFOX_PROFILE/chrome/userChrome.css" "$BACKUP_DIR/chrome/userChrome.css"
    copy_if_exists "$FIREFOX_PROFILE/chrome/userContent.css" "$BACKUP_DIR/chrome/userContent.css"
fi

# 9. Backup certificate database
echo ""
echo "Copying certificate database..."
copy_if_exists "$FIREFOX_PROFILE/cert9.db" "$BACKUP_DIR/cert9.db"
copy_if_exists "$FIREFOX_PROFILE/key4.db" "$BACKUP_DIR/key4.db"

# 10. Create backup manifest
echo ""
echo "Creating backup manifest..."
cat > "$BACKUP_DIR/MANIFEST.txt" <<EOF
Firefox Data Backup
===================
Date: $(date)
Profile: $FIREFOX_PROFILE

Files backed up:
- bookmarks.json: Bookmarks with URLs
- bookmark-folders.json: Folder structure
- history.json: Last 1000 history entries
- permissions.json: Site permissions
- content-prefs.json: Content preferences (zoom, etc.)
- formhistory.json: Form autofill history
- containers.json: Container configuration
- handlers.json: File/protocol handlers
- extensions.json: Extension list
- addons.json: Addon metadata
- prefs.js: All Firefox preferences
- chrome/: UI customization files
- cert9.db: Certificate database
- key4.db: Encryption key database

To restore:
1. Copy JSON files back to Firefox profile
2. For SQLite data, use import scripts
3. Restart Firefox

Note: Passwords (logins.json) are NOT backed up for security.
EOF

echo -e "${GREEN}✓ Created: MANIFEST.txt${NC}"

# Summary
echo ""
echo "======================================"
echo "Backup completed successfully!"
echo "Location: $BACKUP_DIR"
echo "======================================"
echo ""
echo "Backup size:"
du -sh "$BACKUP_DIR"

# Create symlink to latest backup
LATEST_LINK="$HOME/musea/firefox-backups/latest"
rm -f "$LATEST_LINK"
ln -s "$BACKUP_DIR" "$LATEST_LINK"
echo ""
echo "Latest backup symlink: $LATEST_LINK"
