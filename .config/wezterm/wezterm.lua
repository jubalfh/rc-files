local wezterm = require("wezterm")
local _a = wezterm.action

-- initialize config
local config = wezterm.config_builder()

-- key mappings and leader key
config.leader = { key = "mapped:`", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
    { key = "LeftArrow", mods = "CTRL", action = _a.ActivateTabRelative(-1) },
    { key = "RightArrow", mods = "CTRL", action = _a.ActivateTabRelative(1) },
    { key = "LeftArrow", mods = "CTRL|SHIFT", action = _a.ActivatePaneDirection("Left") },
    { key = "RightArrow", mods = "CTRL|SHIFT", action = _a.ActivatePaneDirection("Right") },
    { key = "UpArrow", mods = "CTRL|SHIFT", action = _a.ActivatePaneDirection("Up") },
    { key = "DownArrow", mods = "CTRL|SHIFT", action = _a.ActivatePaneDirection("Down") },

    { key = "l", mods = "CTRL|SHIFT", action = _a.ClearScrollback("ScrollbackAndViewport") },
    { key = "Insert", mods = "SHIFT", action = _a.PasteFrom("PrimarySelection") },

    { key = "h", mods = "LEADER", action = _a.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "v", mods = "LEADER", action = _a.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "d", mods = "LEADER", action = _a.ShowDebugOverlay },
    { key = "z", mods = "LEADER", action = _a.TogglePaneZoomState },
    { key = "r", mods = "LEADER", action = _a.ReloadConfiguration },
}

-- mouse mappings; simplified (again)
config.mouse_bindings = {
    -- copy & paste on right-click as seen in windows terminal
    -- cf. https://github.com/wez/wezterm/discussions/3541
    {
        event = { Down = { streak = 1, button = "Right" } }, mods = "NONE",
        action = wezterm.action_callback(function(window, pane)
            local has_selection = window:get_selection_text_for_pane(pane) ~= ""
            if has_selection then
                window:perform_action(_a.CopyTo("ClipboardAndPrimarySelection"), pane)
                window:perform_action(_a.ClearSelection, pane)
            else
                window:perform_action(_a.PasteFrom("Clipboard"), pane)
            end
        end),
    },

    -- open url on ctrl-left-click
    { event = { Up = { streak = 1, button = "Left" } }, mods = "CTRL", action = _a.OpenLinkAtMouseCursor },
    { event = { Down = { streak = 1, button = "Left" } }, mods = "CTRL", action = _a.Nop },
    { event = { Down = { streak = 1, button = { WheelUp = 1 } } }, mods = "NONE", action = _a.ScrollByLine(-1) },
    { event = { Down = { streak = 1, button = { WheelDown = 1 } } }, mods = "NONE", action = _a.ScrollByLine(1) },
}

-- general config data follows
config.window_close_confirmation = "NeverPrompt"
config.exit_behavior = "Close"
config.window_padding = { left = "4px", right = "4px", top = "4px", bottom = "4px" }
config.window_decorations = "NONE | RESIZE"
config.enable_tab_bar = false

-- color scheme
config.color_scheme = "GruvboxDark"

-- fonts & input handling
config.font = wezterm.font_with_fallback({
    {
        family = "Iosevka Term",
        weight = "Regular",
        harfbuzz_features = { "dlig=1", "ss07=1" },
    },
    {
        family = "PragmataPro Liga",
    },
    -- {
    --     family = "Fantasque Sans Mono", weight = "Regular",
    -- },
    -- {
    --     family = "Victor Mono", weight = "Regular",
    -- },
    -- {
    --     family = "Monaspace Argon", weight = "Light",
    --     harfbuzz_features = {
    --         "calt=1", "dlig=1", "liga=1", "ss05=1",
    --     }
    -- },
    {
        family = "Symbols Nerd Font Mono",
    },
})
config.font_rules = {
    {
        intensity = "Bold",
        italic = true,
        font = wezterm.font({
            -- family = Monaspace Radon",
            family = "Fantasque Sans Mono",
            weight = "Bold",
            style = "Italic",
        }),
    },
    {
        intensity = "Half",
        italic = true,
        font = wezterm.font({
            -- family = Monaspace Radon",
            family = "Fantasque Sans Mono",
            weight = "Medium",
            style = "Italic",
        }),
    },
    {
        intensity = "Normal",
        italic = true,
        font = wezterm.font({
            -- family = Monaspace Radon",
            family = "Fantasque Sans Mono",
            weight = "Regular",
            style = "Italic",
        }),
    },
}
config.font_size = 12.5
config.freetype_load_target = "Light"
config.freetype_render_target = "Normal"
config.freetype_interpreter_version = 40
config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"
config.adjust_window_size_when_changing_font_size = false
config.warn_about_missing_glyphs = false
config.use_ime = true

-- no update checks, please
config.check_for_updates = false

-- remaining options
config.scrollback_lines = 25000
config.front_end = "WebGpu"
-- config.webgpu_power_preference = "HighPerformance"
config.animation_fps = 15
config.enable_scroll_bar = true

return config
