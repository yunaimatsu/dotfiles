#!/bin/bash

# 1. 設定
# 1.1. 引数解析
VERBOSE=false
TARGET_USER=""

while [[ $# -gt 0 ]]; do
  case $1 in
    -v|--verbose)
      VERBOSE=true
      shift 1
      ;;
    -u|--user)
      TARGET_USER="$2"
      shift 2
      ;;
    -l|--limit)
      LIMIT="$2"
      shift 2
      ;;
    *)
      echo "Usage: $0 [-v] [-u @username]"
      echo "  -v: Verbose mode"
      echo "  -u: Username"
      echo "  -l: Limitation of tweets fetched"
      exit 1
      ;;
  esac
done

# 1.2. 設定ファイル解析
REQUIRED_FILES=(".env" "following_users.json")
for file in "${REQUIRED_FILES[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Error: $file not found. Please create it."
    exit 1
  fi
done
source .env
set -e

if [ "$VERBOSE" = true ]; then
  set -x
fi

if [ -n "$TARGET_USER" ]; then
  USER_ID=$(jq -r --arg user "$TARGET_USER" '.[$user] // empty' following_users.json)
  if [ -z "$USER_ID" ]; then
    echo "Error: User $TARGET_USER not found in following_users.json"
    echo "Available users:"
    jq -r 'keys[]' following_users.json
    exit 1
  fi
  USER_ID_ARRAY=("$USER_ID")
else
  mapfile -t USER_ID_ARRAY < <(jq -r '.[]' following_users.json)
  if [ ${#USER_ID_ARRAY[@]} -eq 0 ]; then
    echo "Error: No users found in following_users.json"
    exit 1
  fi
fi

if [ -z "$COOKIE" ] || [ -z "$BEARER_TOKEN" ] || [ -z "$X_CSRF_TOKEN" ]; then
  echo "Error: Please edit the .env file and fill in the COOKIE, BEARER_TOKEN, and X_CSRF_TOKEN variables."
  exit 1
fi

# 1.3. 依存解析
if ! command -v jq &> /dev/null
then
    echo "Error: jq is not installed. Please install it to parse the JSON response."
    echo "Debian/Ubuntu: sudo apt-get install jq"
    echo "RedHat/CentOS: sudo yum install jq"
    echo "macOS: brew install jq"
    exit 1
fi

# 2. Tweet取得層
RESPONSE_FILES=()
for USER_ID in "${USER_ID_ARRAY[@]}"; do
  # Get username for this ID
  USERNAME=$(jq -r --arg id "$USER_ID" 'to_entries[] | select(.value == $id) | .key' following_users.json)

  if [ "$VERBOSE" = true ]; then
    echo "Fetching tweets for $USERNAME (ID: $USER_ID)..."
  fi

  # Update VARIABLES with current USER_ID
  CURRENT_VARIABLES=$(echo "$VARIABLES" | jq -c --arg uid "$USER_ID" '. + {userId: $uid}')

  # URL-encode the variables and features (compact JSON first, then encode)
  ENCODED_VARIABLES=$(echo "$CURRENT_VARIABLES" | jq -sRr @uri)
  ENCODED_FEATURES=$(echo "$FEATURES" | jq -c . | jq -sRr @uri)

  # Construct the final API URL
  API_URL="https://twitter.com/i/api/graphql/${GRAPHQL_API_ID}/UserTweets?variables=${ENCODED_VARIABLES}&features=${ENCODED_FEATURES}"

  # Use curl to make the request and save the output to a file
  if [ "$VERBOSE" = true ]; then
    CURL_OPTS="-v"
  else
    CURL_OPTS="-s"
  fi

  curl $CURL_OPTS "$API_URL" \
    -H "authorization: $BEARER_TOKEN" \
    -H "cookie: $COOKIE" \
    -H "x-csrf-token: $X_CSRF_TOKEN" \
    -o "response_${USER_ID}.json"

  if [ "$VERBOSE" = true ]; then
    echo "API response saved to response_${USER_ID}.json"
  fi

  RESPONSE_FILES+=("response_${USER_ID}.json")
done

# 3. 表示層
# 3.1. ヘッダ
# Parse and display tweets with detailed formatting
LIMIT=${LIMIT:-10}  # Default to 10 tweets if not set

# Combine all response files and parse
COMBINED_JQ_INPUT=""
for RESPONSE_FILE in "${RESPONSE_FILES[@]}"; do
  if [ -n "$COMBINED_JQ_INPUT" ]; then
    COMBINED_JQ_INPUT="$COMBINED_JQ_INPUT,"
  fi
  COMBINED_JQ_INPUT="${COMBINED_JQ_INPUT}$(cat "$RESPONSE_FILE")"
done

display_image() {
    local url="$1"
    local tmpfile=$(mktemp /tmp/tweet-img-XXXXXX)
    curl -s "$url" -o "$tmpfile" 2>/dev/null
    viu -w 60 "$tmpfile" 2>/dev/null
    rm -f "$tmpfile"
}

get_youtube_id() {
    local url="$1"
    local id=""
    if [[ "$url" =~ youtube\.com/watch\?v=([a-zA-Z0-9_-]+) ]]; then
        id="${BASH_REMATCH[1]}"
    elif [[ "$url" =~ youtu\.be/([a-zA-Z0-9_-]+) ]]; then
        id="${BASH_REMATCH[1]}"
    elif [[ "$url" =~ youtube\.com/embed/([a-zA-Z0-9_-]+) ]]; then
        id="${BASH_REMATCH[1]}"
    fi
    echo "$id"
}

get_og_image() {
    local url="$1"
    local tmpfile=$(mktemp /tmp/tweet-html-XXXXXX)
    if curl -sL -A "Mozilla/5.0" "$url" -o "$tmpfile" 2>/dev/null; then
        local og_image=$(
            grep -oP '(?<=<meta property="og:image" content=")[^"]+' "$tmpfile" 2>/dev/null | head -1 ||
            grep -oP '(?<=<meta name="twitter:image" content=")[^"]+' "$tmpfile" 2>/dev/null | head -1 ||
            grep -oP '(?<=<meta property="twitter:image" content=")[^"]+' "$tmpfile" 2>/dev/null | head -1
        )
        rm -f "$tmpfile"
        echo "$og_image"
    else
        rm -f "$tmpfile"
        echo ""
    fi
}

# Export functions for use in subshell
export -f display_image
export -f get_youtube_id
export -f get_og_image

# Parse tweets and extract media URLs
while IFS= read -r line; do
    if [[ "$line" =~ ^LINK:(.*) ]]; then
        url="${BASH_REMATCH[1]}"
        echo "  🔗 $url"

        # Check if it's a YouTube URL
        if [[ "$url" =~ youtube\.com|youtu\.be ]]; then
            if [ -n "viu" ]; then
                video_id=$(get_youtube_id "$url")
                if [ -n "$video_id" ]; then
                    echo "  📺 YouTube thumbnail:"
                    # Try maxresdefault first, fall back to hqdefault if it fails
                    thumb_url="https://img.youtube.com/vi/${video_id}/maxresdefault.jpg"
                    if ! curl -sf "$thumb_url" -o /dev/null 2>/dev/null; then
                        thumb_url="https://img.youtube.com/vi/${video_id}/hqdefault.jpg"
                    fi
                    display_image "$thumb_url"
                fi
            fi
        # Check if it's a general website URL (not a twitter/x link)
        elif [[ ! "$url" =~ (twitter\.com|x\.com) ]] && [ -n "viu" ]; then
            og_img=$(get_og_image "$url")
            if [ -n "$og_img" ]; then
                echo "  🌐 Website thumbnail:"
                display_image "$og_img"
            fi
        fi
    elif [[ "$line" =~ ^IMAGE:(.*) ]]; then
        if [ -n "viu" ]; then
            echo "  🖼️  ${BASH_REMATCH[1]}"
            display_image "${BASH_REMATCH[1]}"
        else
            echo "  🖼️  ${BASH_REMATCH[1]}"
        fi
    elif [[ "$line" =~ ^VIDEO:(.*) ]]; then
        echo "  🎥 ${BASH_REMATCH[1]}"
    elif [[ "$line" =~ ^MEDIA:(.*) ]]; then
        echo "  📎 ${BASH_REMATCH[1]}"
    else
        echo "$line"
    fi
done < <(echo "$COMBINED_JQ_INPUT" | jq -r --argjson limit "$LIMIT" '
  [.. | objects | select(has("tweet_results")) |
  .tweet_results.result |
  {
    user: .core.user_results.result.core.name,
    screen_name: .core.user_results.result.core.screen_name,
    text: .legacy.full_text,
    created_at: .legacy.created_at,
    timestamp: .legacy.created_at,
    media: (.legacy.extended_entities.media // []),
    urls: (.legacy.entities.urls // [])
  }
  | select(.text != null)]
  | sort_by(.timestamp | strptime("%a %b %d %H:%M:%S %z %Y") | mktime) | reverse
  | .[:$limit]
  | .[]
  | "\(.user) (@\(.screen_name))\nDATE \(.created_at)\n\(.text)\n" +
    if (.urls | length) > 0 then
      "🔗 Links:\n" + (
        .urls | map("LINK:" + .expanded_url) | join("\n")
      ) + "\n"
    else
      ""
    end +
    if (.media | length) > 0 then
      "📎 Media:\n" + (
        .media | map(
          if .type == "photo" then
            "IMAGE:" + .media_url_https
          elif .type == "video" or .type == "animated_gif" then
            "VIDEO:" + (.video_info.variants | map(select(.content_type == "video/mp4")) | sort_by(.bitrate) | reverse | .[0].url)
          else
            "MEDIA:" + .media_url_https
          end
        ) | join("\n")
      ) + "\n" + ("─" * 80) + "\n\n"
    else
      ("─" * 80) + "\n\n"
    end
')
