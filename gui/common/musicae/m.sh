#!/bin/bash

PLAYLIST_DIR="$HOME/musicae/playlists"
EDITOR_CMD="${EDITOR:-vim}"
RESET="\033[0m"
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"

error() {
  echo -e "${RED}❌ $1${RESET}"
}

info() {
  echo -e "${GREEN}$1${RESET}"
}

warn() {
  echo -e "${YELLOW}⚠️ $1${RESET}"
}

case "$1" in
  ls)
    echo ""
    info "AVAILABLE PLAYLISTS:"
    find "$PLAYLIST_DIR" -type f -name "*.json" -exec basename {} .json \;
    ;;

  edit)
    if [ -z "$2" ]; then
      error "Please specify a playlist name to edit."
      exit 1
    fi
    EDIT_FILE="$PLAYLIST_DIR/$2.json"
    if [ ! -f "$EDIT_FILE" ]; then
      error "JSON file '$EDIT_FILE' not found."
      exit 1
    fi
    "$EDITOR_CMD" "$EDIT_FILE"
    ;;

  *)
    if [ -z "$1" ]; then
      error "Please specify a playlist name or command (ls, edit)."
      exit 1
    fi

    JSON_FILE="$PLAYLIST_DIR/$1.json"
    if [ ! -f "$JSON_FILE" ]; then
      error "JSON file '$JSON_FILE' not found."
      exit 1
    fi

    # もとのJSON形式（object）前提
    jq -r 'to_entries | map("https://youtube.com/watch?v=\(.value)")[]' "$JSON_FILE" | shuf > .tmp_playlist.txt

    info "▶️  Playing playlist: $1"

    mpv \
      --no-video \
      --terminal \
      --msg-level=ffmpeg=fatal \
      --term-playing-msg="Playing: \${media-title}" \
      --cache=yes \
      --cache-secs=20 \
      --demuxer-max-bytes=100MiB \
      --demuxer-readahead-secs=30 \
      --audio-pitch-correction=yes \
      --audio-buffer=1 \
      --vd-lavc-threads=2 \
      --playlist=.tmp_playlist.txt
    ;;
esac
