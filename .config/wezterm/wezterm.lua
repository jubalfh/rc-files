local wezterm = require 'wezterm'
local act = wezterm.action

local leader = { key="a", mods="CTRL" }
local key_bindings = {
    {mods="CTRL|SHIFT", key="LeftArrow", action=act{ActivatePaneDirection="Left"}},
    {mods="CTRL|SHIFT", key="RightArrow", action=act{ActivatePaneDirection="Right"}},
    {mods="CTRL|SHIFT", key="UpArrow", action=act{ActivatePaneDirection="Up"}},
    {mods="CTRL|SHIFT", key="DownArrow", action=act{ActivatePaneDirection="Down"}},

    {mods="CTRL|SHIFT", key="r", action="ReloadConfiguration"},
    {mods="CTRL|SHIFT", key="l", action=act{ClearScrollback = "ScrollbackAndViewport"}},
    {mods="CTRL|SHIFT", key="d", action="ShowDebugOverlay"},
    {mods="SHIFT", key="Insert", action=act{PasteFrom="PrimarySelection"}},

    {mods="LEADER", key="|", action=act{SplitHorizontal={domain="CurrentPaneDomain"}}},
    {mods="LEADER", key="-", action=act{SplitVertical={domain="CurrentPaneDomain"}}},
    {mods="LEADER", key="z", action="TogglePaneZoomState"},
    {mods="LEADER|CTRL", key="a", action=act{SendString="\x01"}},
}

local mouse_bindings = {
    -- copy to clipboard on ctrl-right-click
    { event={Down={streak=1, button="Right"}},
        mods="CTRL",
        action={CopyTo="ClipboardAndPrimarySelection"}
    },
    -- paste from clipboard on right-click
    { event={Down={streak=1, button="Right"}},
        mods="NONE",
        action={PasteFrom="Clipboard"}
    },
    -- open url on ctrl-left-click
    { event={Up={streak=1, button="Left"}},
        mods="CTRL",
        action="OpenLinkAtMouseCursor"
    },
    { event={Down={streak=1, button="Left"}}, mods="CTRL", action="Nop" },
}

return {
    -- basic window settings
    window_close_confirmation="NeverPrompt",
    exit_behavior = "Close",
    window_padding = {4, 4, 4, 4},
    window_decorations = "RESIZE",
    enable_tab_bar = false,
    -- color scheme
    color_scheme = "Gruvbox Dark",
    -- fonts & input handling
    font = wezterm.font_with_fallback({
        {family="Iosevka Term SS07", weight="Medium"},
        {family="Iosevka Term", weight="Medium"},
    }),
    font_size = 12.0,
    allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace",
    adjust_window_size_when_changing_font_size = false,
    warn_about_missing_glyphs = false,
    freetype_load_target = "Light",
    freetype_render_target = "HorizontalLcd",
    freetype_interpreter_version = 40,
    use_ime = true,
    -- key mappings and leader kery
    leader = leader,
    keys = key_bindings,
    -- mouse mappings; simplified (again)
    mouse_bindings = mouse_bindings,
    -- no update checks, please
    check_for_updates = false,
}
