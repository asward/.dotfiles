#!/bin/bash

# Symlink Manager - Creates symlinks from source directory to various locations
# Usage: ./symlink.sh [config_file]

show_help() {
    cat << 'EOF'
Symlink Manager - Installs from source directory to various locations

USAGE:
    ./install.sh [config_file]
    ./install.sh -h|--help

ARGUMENTS:
    config_file    Configuration file (default: unix.conf)

CONFIG FILE FORMAT:
    source_file:destination_path
    
    Lines starting with # are comments
    Empty lines are ignored
    
EXAMPLES:
    .vimrc:~/.vimrc
    .bashrc:~/.bashrc
    config/i3:~/.config/i3
    scripts/backup.sh:~/bin/backup.sh

BEHAVIOR:
    - Existing files/folders are moved to .orig versions
    - Missing destination directories are created
    - Symlinks are created with absolute paths
    - Duplicate .orig files get numbered suffixes

EOF
}

# Show help if no arguments or help requested
if [[ $# -eq 0 ]] || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    show_help
    exit 0
fi

CONFIG_FILE="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if config file exists
if [[ ! -f "$CONFIG_FILE" ]]; then
    log_error "Config file '$CONFIG_FILE' not found!"
    echo "Creating example config file..."
    cat > "$CONFIG_FILE" << EOF
# Symlink configuration file
# Format: source_file:destination_path
# Lines starting with # are comments
# Empty lines are ignored

# Example entries:
# .vimrc:~/.vimrc
# .bashrc:~/.bashrc
# config/i3:~/.config/i3
# scripts/backup.sh:~/bin/backup.sh

EOF
    log_info "Example config created at '$CONFIG_FILE'. Edit it and run again."
    exit 1
fi

# Read config file and process each line
while IFS= read -r line || [[ -n "$line" ]]; do
    # Skip comments and empty lines
    [[ "$line" =~ ^[[:space:]]*# ]] && continue
    [[ -z "${line// }" ]] && continue
    
    # Parse source:destination
    if [[ ! "$line" =~ ^[^:]+:[^:]+$ ]]; then
        log_warn "Invalid format in line: $line"
        continue
    fi
    
    source_file="${line%%:*}"
    dest_path="${line##*:}"
    
    # Expand tilde in destination path
    dest_path="${dest_path/#\~/$HOME}"
    
    # Full source path relative to script location
    full_source="$SCRIPT_DIR/$source_file"
    
    # Check if source exists
    if [[ ! -e "$full_source" ]]; then
        log_error "Source does not exist: $full_source"
        continue
    fi
    
    # Create destination directory if needed
    dest_dir="$(dirname "$dest_path")"
    if [[ ! -d "$dest_dir" ]]; then
        log_info "Creating directory: $dest_dir"
        mkdir -p "$dest_dir"
    fi
    
    # Handle existing destination
    if [[ -e "$dest_path" || -L "$dest_path" ]]; then
        if [[ -L "$dest_path" ]]; then
            current_target="$(readlink "$dest_path")"
            if [[ "$current_target" == "$full_source" ]]; then
                log_info "Symlink already exists: $dest_path -> $full_source"
                continue
            fi
        fi
        
        orig_path="${dest_path}.orig"
        counter=1
        while [[ -e "$orig_path" ]]; do
            orig_path="${dest_path}.orig.$counter"
            ((counter++))
        done
        
        log_info "Moving existing file: $dest_path -> $orig_path"
        mv "$dest_path" "$orig_path"
    fi
    
    # Create symlink
    log_info "Creating symlink: $dest_path -> $full_source"
    ln -s "$full_source" "$dest_path"
    
done < "$CONFIG_FILE"

log_info "Symlink processing complete!"
