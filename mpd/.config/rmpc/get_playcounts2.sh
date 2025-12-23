#!/usr/bin/env sh

# Directory containing your music files
MUSIC_DIR="$HOME/beets/music"

# Output file to store play counts
OUTPUT_FILE="$HOME/.config/rmpc/flac_playcounts.txt"

# Clear the output file if it exists
> "$OUTPUT_FILE"

# Use a temporary file to store play counts for sorting
TEMPFILE=$(mktemp)

# Use find to locate all .flac files and process each one
find "$MUSIC_DIR" -type f -name "*.flac" | while read -r FILE; do
    # Format the file path for rmpc
    FORMATTED_PATH=$(echo "$FILE" | sed "s|^$HOME/beets/music/||")
    
    # Get the playcount from the rmpc sticker
    PLAYCOUNT=$(rmpc sticker get "$FORMATTED_PATH" "playCount" | jq -r '.value')

    # Debugging output
    if [ -z "$PLAYCOUNT" ]; then
        echo "Warning: Could not retrieve play count for $(basename "$FILE")" >&2
        PLAYCOUNT=0
    elif [ "$PLAYCOUNT" = "null" ]; then
        PLAYCOUNT=0
    fi

    # Output the play count and file to the temporary file
    echo "$PLAYCOUNT $(basename "$FILE")" >> "$TEMPFILE"
done

# Sort the temporary file and output to OUTPUT_FILE
echo "Play Count | Track" > "$OUTPUT_FILE"
echo "--------------------" >> "$OUTPUT_FILE"
sort -nr "$TEMPFILE" >> "$OUTPUT_FILE"

# Clean up the temporary file
rm "$TEMPFILE"

echo "✅ Play counts retrieved and saved to $OUTPUT_FILE"

