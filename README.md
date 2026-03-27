# einkeink

Color schemes optimized for E-ink displays. High contrast, grayscale-only, designed for readability on low-refresh panels.

## Supported apps

- Ghostty terminal
- Zed editor
- Obsidian (CSS snippet)

## Install

    ./install.sh

This installs themes for both Ghostty and Zed.

### Ghostty

The installer copies the theme and adds the following to your Ghostty config:

    theme = eink
    cursor-style = block
    cursor-style-blink = false
    shell-integration-features = no-cursor

Reload with Cmd+Shift+, (macOS) or restart Ghostty to apply.

Manual install: copy `ghostty/eink` to `~/.config/ghostty/themes/eink`, then add `theme = eink` to your Ghostty config.

Config file locations:

- macOS: `~/Library/Application Support/com.mitchellh.ghostty/config`
- Linux: `~/.config/ghostty/config`

### Zed

The installer copies `zed/eink.json` to `~/.config/zed/themes/eink.json`.

Open the command palette, run "theme selector: toggle", and select "Eink".

### Obsidian

1. Copy `obsidian/eink.css` to your vault's `.obsidian/snippets/` directory
2. In Obsidian, go to Settings > Appearance > CSS snippets
3. Enable "eink"

Make sure Obsidian is set to light mode (Settings > Appearance > Base color scheme > Light).

## Auto-switch with Hammerspoon

If you use a secondary E-ink display alongside a regular monitor, you can automatically switch Ghostty to the eink theme when its window moves to the E-ink screen.

1. Copy `hammerspoon/ghostty_eink.lua` to `~/.hammerspoon/`
2. Edit `EINK_SCREEN_NAME` at the top of the file to match your display name. Run `hs.screen.allScreens()` in the Hammerspoon console to find it.
3. Edit `NORMAL_THEME` to your preferred regular theme.
4. Add `require("ghostty_eink")` to your `~/.hammerspoon/init.lua`
5. Reload Hammerspoon.

The script watches Ghostty windows and rewrites the theme config + triggers a reload whenever a window moves between screens.

## Design

16 ANSI colors mapped to distinct grayscale values. Normal colors (0-6) are dark for text on white backgrounds. White (7) and bright white (15) are light so they remain visible when used as text on colored backgrounds. Background is pure white, foreground is pure black.
