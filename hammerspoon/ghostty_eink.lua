-- Ghostty E-ink auto theme switcher
-- Add to your ~/.hammerspoon/init.lua:
--   require("ghostty_eink")
-- Then reload Hammerspoon.

-- Set this to your E-ink display name.
-- Run `hs.screen.allScreens()` in the Hammerspoon console to find it.
local EINK_SCREEN_NAME = "Mira133"

local EINK_THEME = "eink"
local NORMAL_THEME = "One Half Dark"

local function getGhosttyConfigPath()
    local home = os.getenv("HOME")
    local macPath = home .. "/Library/Application Support/com.mitchellh.ghostty/config"
    local f = io.open(macPath, "r")
    if f then
        f:close()
        return macPath
    end
    return home .. "/.config/ghostty/config"
end

local currentTheme = nil

local function setGhosttyTheme(theme)
    if theme == currentTheme then return end
    currentTheme = theme

    local configPath = getGhosttyConfigPath()
    local f = io.open(configPath, "r")
    if not f then return end
    local content = f:read("*a")
    f:close()

    local newContent, count = content:gsub("theme%s*=%s*[^\n]*", "theme = " .. theme)
    if count == 0 then
        newContent = content .. "\ntheme = " .. theme
    end

    f = io.open(configPath, "w")
    if not f then return end
    f:write(newContent)
    f:close()

    -- Reload Ghostty config via Cmd+Shift+,
    local app = hs.application.find("Ghostty")
    if app then
        hs.eventtap.keyStroke({"cmd", "shift"}, ",", 0, app)
    end

    hs.printf("Ghostty theme switched to: %s", theme)
end

local function checkGhosttyScreen(win)
    if not win then return end
    local screen = win:screen()
    if not screen then return end
    local name = screen:name()
    if name and name:find(EINK_SCREEN_NAME) then
        setGhosttyTheme(EINK_THEME)
    else
        setGhosttyTheme(NORMAL_THEME)
    end
end

local wf = hs.window.filter.new("Ghostty")
wf:subscribe(hs.window.filter.windowMoved, function(win) checkGhosttyScreen(win) end)
wf:subscribe(hs.window.filter.windowFocused, function(win) checkGhosttyScreen(win) end)
wf:subscribe(hs.window.filter.windowOnScreen, function(win) checkGhosttyScreen(win) end)
