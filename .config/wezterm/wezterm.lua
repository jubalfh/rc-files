local wezterm = require("wezterm")
local _a = wezterm.action

local leader = { mods = "CTRL", key = "mapped:`", timeout_milliseconds = 1000 }
local key_bindings = {
    { mods = "CTRL", key = "LeftArrow", action = _a.ActivateTabRelative(-1) },
    { mods = "CTRL", key = "RightArrow", action = _a.ActivateTabRelative(1) },
    { mods = "CTRL|SHIFT", key = "LeftArrow", action = _a.ActivatePaneDirection("Left") },
    { mods = "CTRL|SHIFT", key = "RightArrow", action = _a.ActivatePaneDirection("Right") },
    { mods = "CTRL|SHIFT", key = "UpArrow", action = _a.ActivatePaneDirection("Up") },
    { mods = "CTRL|SHIFT", key = "DownArrow", action = _a.ActivatePaneDirection("Down") },

    { mods = "CTRL|SHIFT", key = "l", action = _a.ClearScrollback("ScrollbackAndViewport") },
    { mods = "SHIFT", key = "Insert", action = _a.PasteFrom("PrimarySelection") },

    { mods = "LEADER", key = "h", action = _a.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { mods = "LEADER", key = "v", action = _a.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { mods = "LEADER", key = "d", action = _a.ShowDebugOverlay },
    { mods = "LEADER", key = "z", action = _a.TogglePaneZoomState },
    { mods = "LEADER", key = "r", action = _a.ReloadConfiguration },
}

local mouse_bindings = {
    -- copy to clipboard on ctrl-right-click
    {
        event = { Down = { streak = 1, button = "Right" } },
        mods = "CTRL",
        action = _a.CopyTo("ClipboardAndPrimarySelection"),
    },
    -- paste from clipboard on right-click
    { event = { Down = { streak = 1, button = "Right" } }, mods = "NONE", action = _a.PasteFrom("Clipboard") },
    -- open url on ctrl-left-click
    { event = { Up = { streak = 1, button = "Left" } }, mods = "CTRL", action = _a.OpenLinkAtMouseCursor },
    { event = { Down = { streak = 1, button = "Left" } }, mods = "CTRL", action = _a.Nop },
}

return {
    -- basic window settings
    window_close_confirmation = "NeverPrompt",
    exit_behavior = "Close",
    window_padding = {
        left = "4px",
        right = "4px",
        top = "4px",
        bottom = "4px",
    },
    window_decorations = "RESIZE",
    enable_tab_bar = false,
    -- color scheme
    color_scheme = "GruvboxDark",
    -- fonts & input handling
    font = wezterm.font_with_fallback({
        { family = "Iosevka Term SS07", weight = "Medium" },
        { family = "Iosevka Term", weight = "Medium" },
        { family = "Nerd Font Symbol Mono"},
    }),
    font_size = 12.0,
    allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace",
    adjust_window_size_when_changing_font_size = false,
    warn_about_missing_glyphs = false,
    freetype_load_target = "Light",
    freetype_render_target = "Normal",
    freetype_interpreter_version = 40,
    use_ime = true,
    -- key mappings and leader key
    leader = leader,
    keys = key_bindings,
    -- mouse mappings; simplified (again)
    mouse_bindings = mouse_bindings,
    -- no update checks, please
    check_for_updates = false,
    -- remaining options
    scrollback_lines = 25000,
    -- front_end = "WebGpu",
    -- webgpu_power_preference = "HighPerformance",
    animation_fps = 15,
}
