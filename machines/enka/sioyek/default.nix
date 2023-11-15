{
  homeConfiguration,
  enabled,
  ...
}:
homeConfiguration "nixos" {
  programs.sioyek = enabled {
    config = {
      # STARTUP LOAD CUSTOM THEME "GRUVBOX"
      "startup_commands" = "toggle_custom_color;toggle_statusbar";

      "custom_color_contrast" = "0.3";
      "custom_color_mode_empty_background_color" = "#1d2021";
      "page_separator_color" = "#1d2021";
      "page_separator_width" = "10";
      "custom_background_color" = "#282828";
      "custom_text_color" = "#fbf1c7";
      "search_highlight_color" = "#7ec16e";
      "status_bar_color" = "#427b58";
      "status_bar_text_color" = "#fbf1c7";
    };
  };
}
