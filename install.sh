#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
THEME_NAME="eink"
THEME_FILE="$SCRIPT_DIR/$THEME_NAME"

# Determine Ghostty config directory
if [[ "$(uname)" == "Darwin" ]]; then
    CONFIG_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"
else
    CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty"
fi

THEMES_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/themes"
CONFIG_FILE="$CONFIG_DIR/config"

# Install theme
mkdir -p "$THEMES_DIR"
cp "$THEME_FILE" "$THEMES_DIR/$THEME_NAME"
echo "✓ Installed theme to $THEMES_DIR/$THEME_NAME"

# Add config entries if not already present
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "⚠ Ghostty config not found at $CONFIG_FILE"
    echo "  Create it and add the following lines:"
    echo ""
    echo "  theme = eink"
    echo "  cursor-style = block"
    echo "  cursor-style-blink = false"
    echo "  shell-integration-features = no-cursor"
    exit 0
fi

append_if_missing() {
    local key="$1"
    local line="$2"
    if ! grep -q "^${key}" "$CONFIG_FILE"; then
        echo "$line" >> "$CONFIG_FILE"
        echo "✓ Added '$line' to config"
    else
        echo "· '$key' already set in config, skipping"
    fi
}

append_if_missing "theme" "theme = eink"
append_if_missing "cursor-style =" "cursor-style = block"
append_if_missing "cursor-style-blink" "cursor-style-blink = false"
append_if_missing "shell-integration-features" "shell-integration-features = no-cursor"

echo ""
echo "Done! Reload Ghostty config to apply:"
echo "  • macOS: Cmd+Shift+,"
echo "  • or restart Ghostty"
