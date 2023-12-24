{
  ulib,
  theme,
  ...
}: with ulib;
homeConfiguration {
  programs.sioyek = with theme; enabled {
    config = {
      "startup_commands" = "toggle_custom_color;toggle_statusbar";

      # GRUVBOX TODO: use theme
      "custom_color_contrast" = "0.3";
      "custom_color_mode_empty_background_color" = "#1d2021";
      "page_separator_color" = "#1d2021";
      "page_separator_width" = "10";
      "custom_background_color" = "#${base00}";
      "custom_text_color" = "#${base07}";
      "search_highlight_color" = "#7ec16e";
      "status_bar_color" = "#427b58";
      "status_bar_text_color" = "#${base07}";
    };
  };
}
