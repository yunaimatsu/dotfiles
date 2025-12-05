#!/bin/bash

# Usage: ./get_video_ids.sh <YouTube_URL>
# Output: tmp_pl.txt with video IDs

if [ $# -eq 0 ]; then
    echo "Usage: $0 <YouTube_URL>"
    echo "Examples:"
    echo "  $0 'https://www.youtube.com/playlist?list=PLxxx'"
    echo "  $0 'https://www.youtube.com/@ChannelName'"
    echo "  $0 'https://music.youtube.com/channel/UCxxx'"
    exit 1
fi

URL="$1"
OUTPUT_FILE="tmp_pl.txt"

echo "Fetching video IDs from: $URL"

# Use yt-dlp to get video IDs
# --flat-playlist: Don't download, just extract info
# --get-id: Extract video IDs only
yt-dlp --flat-playlist --get-id "$URL" > "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
    COUNT=$(wc -l < "$OUTPUT_FILE")
    echo "Successfully extracted $COUNT video IDs to $OUTPUT_FILE"
    echo ""
    echo "Preview (first 10 lines):"
    head -10 "$OUTPUT_FILE"
    if [ $COUNT -gt 10 ]; then
        echo "..."
        echo "(Total: $COUNT videos)"
    fi
else
    echo "Error: Failed to extract video IDs"
    exit 1
fi
