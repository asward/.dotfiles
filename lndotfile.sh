#!/bin/sh
show_help() {
    cat << EOF
Usage: lndotfile <target_folder> <destination_directory>

Moves a target folder to a destination directory (relative to this script's
location) and creates a symlink in its place.

Arguments:
  target_folder          Path to the folder to move
  destination_directory  Directory name relative to script location

Options:
  -h, --help            Show this help message

Example:
  lndotfile ./qutebrowser/ .config

  If script is at ~/.dotfiles/dotfile, this moves ./qutebrowser/ to
  ~/.dotfiles/.config/qutebrowser/ and creates a symlink at ./qutebrowser/
EOF
}

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_help
    exit 0
fi

if [ $# -ne 2 ]; then
    echo "Error: Wrong number of arguments"
    show_help
    exit 1
fi

target="$1"
dest_dir="$2"

# Remove trailing slashes
target="${target%/}"
dest_dir="${dest_dir%/}"

# Check if target exists and is a directory
if [ ! -d "$target" ]; then
    echo "Error: $target is not a directory"
    exit 1
fi

# Get script's directory
script_dir=$(dirname "$(readlink -f "$0")")

# Get absolute paths
target_abs=$(cd "$target" && pwd)
target_name=$(basename "$target_abs")
dest_abs="$script_dir/$dest_dir"
dest_full="$dest_abs/$target_name"

# Create destination directory if it doesn't exist
mkdir -p "$dest_abs" || exit 1

# Check if destination already exists
if [ -e "$dest_full" ]; then
    echo "Error: $dest_full already exists"
    exit 1
fi

# Move the directory
mv "$target_abs" "$dest_full" || exit 1

# Create symlink
ln -s "$dest_full" "$target_abs" || exit 1

echo "Moved $target_abs to $dest_full and created symlink"
