#!/bin/bash

# Default values
DEFAULT_REGEX=".*\.png$"
DEFAULT_OUTPUT="current.png"

# Parse arguments
SOURCE_DIR=""
REGEX="$DEFAULT_REGEX"
OUTPUT="$DEFAULT_OUTPUT"

while [[ $# -gt 0 ]]; do
    case $1 in
        -d|--dir)
            SOURCE_DIR="$2"
            shift 2
            ;;
        -r|--regex)
            REGEX="$2"
            shift 2
            ;;
        -o|--output)
            OUTPUT="$2"
            shift 2
            ;;
        *)
            if [ -z "$SOURCE_DIR" ]; then
                SOURCE_DIR="$1"
            fi
            shift
            ;;
    esac
done

# Use script directory if no source directory provided
if [ -z "$SOURCE_DIR" ]; then
    SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

# Find files matching regex
FILES=()
while IFS= read -r -d '' file; do
    if [[ $(basename "$file") =~ $REGEX ]]; then
        FILES+=("$file")
    fi
done < <(find "$SOURCE_DIR" -maxdepth 1 -type f -print0)

# Check if any files exist
if [ ${#FILES[@]} -eq 0 ]; then
    # echo "No files matching regex '$REGEX' found in $SOURCE_DIR"
    exit 1
fi

# Select random file
RANDOM_FILE="${FILES[$RANDOM % ${#FILES[@]}]}"

# Copy to output file
cp -f "$RANDOM_FILE" "$SOURCE_DIR/$OUTPUT" > /dev/null 2>&1

# echo "Copied $(basename "$RANDOM_FILE") to $OUTPUT"
