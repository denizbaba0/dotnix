{
  ulib,
  pkgs,
  theme,
  ...
}:
with ulib; (homeConfiguration {
  xdg.configFile."rofi".source = ./config;
  programs.rofi = enabled {
    # font = theme.font.sans.name;
    # plugins = with pkgs; [
    #   rofi-calc
    # ];
    # theme = ''
    #   * {
    #       bg-col:  #1e2122;
    #       bg-col-light: #26292a;
    #       border-col: #282b2c;
    #       selected-col: #242728;
    #       blue: #8dae88;
    #       fg-col: #d4be98;
    #       fg-col2: #df736d;
    #       grey: #5b5e5f;
    #       width: 600;
    #   }
    # '';

    # extraConfig = {
    #   modi = "run,drun,window";
    #   lines = 5;
    #   show-icons = true;
    #   icon-theme = "Paper Mono";
    #   terminal = "st";
    #   drun-display-format = "{icon} {name}";
    #   location = 0;
    #   disable-history = false;
    #   hide-scrollbar = true;
    #   display-drun = "   Apps ";
    # };
  };
})
