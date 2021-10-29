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

    {mods="LEADER", key="h", action=act{SplitHorizontal={domain="CurrentPaneDomain"}}},
    {mods="LEADER", key="v", action=act{SplitVertical={domain="CurrentPaneDomain"}}},
    {mods="LEADER", key="z", action="TogglePaneZoomState"},
    {mods="LEADER|CTRL", key="a", action=act{SendString="\x01"}},
}

local mouse_bindings = {
    -- paste on right-click
    { event={Up={streak=1, button="Right"}}, mods="NONE", action="Nop" },
    { event={Down={streak=1, button="Right"}},
        mods="NONE",
        action={PasteFrom="Clipboard"}
    },
    -- select on pressing down left button
    { event={Down={streak=1, button="Left"}},
        mods="NONE",
        action={SelectTextAtMouseCursor="Cell"}
    },
    -- extend on dragging the pointer…
    { event={Drag={streak=1, button="Left"}},
        mods="NONE",
        action={ExtendSelectionToMouseCursor="Cell"}
    },
    -- …or pressign shift and left button,
    { event={Down={streak=1, button="Left"}},
        mods="SHIFT",
        action={ExtendSelectionToMouseCursor={}}
    },
    -- complete the selection on releasing the left button.
    { event={Up={streak=1, button="Left"}},
        mods="NONE",
        action={CompleteSelection="PrimarySelection"}
    },
    -- select word on double-click,
    { event={Down={streak=2, button="Left"}},
        mods="NONE",
        action={SelectTextAtMouseCursor="Word"}
    },
    -- extend the selection by dragging the pointer…
    { event={Drag={streak=2, button="Left"}},
        mods="NONE",
        action={ExtendSelectionToMouseCursor="Word"}
    },
    -- …or pressign shift and left button,
    { event={Down={streak=2, button="Left"}},
        mods="SHIFT",
        action={ExtendSelectionToMouseCursor="Word"}
    },
    -- complete the selection on releasing the left button.
    { event={Up={streak=2, button="Left"}},
        mods="NONE",
        action={CompleteSelection="PrimarySelection"}
    },
    -- select line on triple-click,
    { event={Down={streak=3, button="Left"}},
        mods="NONE",
        action={SelectTextAtMouseCursor="Line"}
    },
    -- extend the selection by dragging the pointer…
    { event={Drag={streak=3, button="Left"}},
        mods="NONE",
        action={ExtendSelectionToMouseCursor="Line"}
    },
    -- …or pressign shift and left button,
    { event={Down={streak=3, button="Left"}},
        mods="SHIFT",
        action={ExtendSelectionToMouseCursor="Line"}
    },
    -- complete the selection on releasing the left button.
    { event={Up={streak=3, button="Left"}},
        mods="NONE",
        action={CompleteSelection="PrimarySelection"}
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
    window_padding = {2, 2, 2, 2},
    window_decorations = "RESIZE",
    enable_tab_bar = false,
    -- color scheme
    color_scheme = "Gruvbox Dark",
    -- fonts & input handling
    font = wezterm.font_with_fallback({
        {family="Iosevka Term SS07 Light", weight="Regular", stretch="Expanded"},
        {family="Iosevka Term Light", weight="Regular", stretch="Expanded"},
    }),
    font_size = 12.0,
    allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace",
    adjust_window_size_when_changing_font_size = false,
    warn_about_missing_glyphs = false,
    freetype_load_target = "Light",
    freetype_render_target = "HorizontalLcd",
    freetype_interpreter_version = 40,
    use_ime = true,
    -- key mappings
    -- disable_default_key_bindings = true,
    leader = leader,
    keys = key_bindings,
    -- mouse mappings; these are almost (but not entirely) like the
    -- original ones, so let's make sure we're working with clean slate
    -- here
    disable_default_mouse_bindings = true,
    mouse_bindings = mouse_bindings,
}
