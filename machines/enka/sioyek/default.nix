{ homeConfiguration, enabled, ... }:

homeConfiguration "nixos" {
  programs.sioyek = enabled {
    # config = {
    #     # "background_color" = "1.0 1.0 1.0";
    #     # "text_highlight_color" = "1.0 0.0 0.0";
    # };
  };
}
