#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
THEME_NAME="eink"
THEME_FILE="$SCRIPT_DIR/ghostty/$THEME_NAME"

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

# Install Zed theme
if [[ "$(uname)" == "Darwin" ]]; then
    ZED_THEMES_DIR="$HOME/.config/zed/themes"
else
    ZED_THEMES_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zed/themes"
fi

mkdir -p "$ZED_THEMES_DIR"
cp "$SCRIPT_DIR/zed/eink.json" "$ZED_THEMES_DIR/eink.json"
echo "✓ Installed Zed theme to $ZED_THEMES_DIR/eink.json"

# Install Obsidian snippet
echo ""
echo "To install the Obsidian snippet:"
echo "  1. Copy obsidian/eink.css to your vault's .obsidian/snippets/ directory"
echo "  2. In Obsidian, go to Settings > Appearance > CSS snippets"
echo "  3. Enable 'eink'"
echo ""
echo "Done!"
echo ""
echo "Ghostty: reload with Cmd+Shift+, (macOS) or restart Ghostty"
echo "Zed: open command palette > 'theme selector: toggle' and select 'Eink'"
echo "Obsidian: enable the snippet in Settings > Appearance > CSS snippets"
