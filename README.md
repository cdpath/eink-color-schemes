# einkeink

Color schemes optimized for E-ink displays. High contrast, grayscale-only, designed for readability on low-refresh panels.

## Supported apps

- Ghostty terminal

## Install

### Ghostty

    ./install.sh

This copies the theme file and adds the following to your Ghostty config:

    theme = eink
    cursor-style = block
    cursor-style-blink = false
    shell-integration-features = no-cursor

Reload with Cmd+Shift+, (macOS) or restart Ghostty to apply.

### Manual install

Copy the `eink` file to `~/.config/ghostty/themes/eink`, then add `theme = eink` to your Ghostty config.

Config file locations:

- macOS: `~/Library/Application Support/com.mitchellh.ghostty/config`
- Linux: `~/.config/ghostty/config`

## Design

16 ANSI colors mapped to distinct grayscale values. Normal colors (0-6) are dark for text on white backgrounds. White (7) and bright white (15) are light so they remain visible when used as text on colored backgrounds. Background is pure white, foreground is pure black.
