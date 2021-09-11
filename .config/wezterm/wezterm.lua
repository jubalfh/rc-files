local term = require 'wezterm';
local keys = {};

return {
    window_padding = {2, 2, 2, 2},
    window_decorations = "RESIZE",
    enable_tab_bar = false,
    use_ime = true,
    color_scheme = "Gruvbox Dark",
    font = term.font_with_fallback({
        "Iosevka Term SS07 Light",
        "Iosevka Term Light"
    }),
    font_size = 12,
    freetype_load_target = "Light",
    freetype_render_target = "HorizontalLcd",
    freetype_interpreter_version = 40,
}
