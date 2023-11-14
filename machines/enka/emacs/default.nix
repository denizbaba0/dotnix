{
  xdg,
  programs,
  pkgs,
  enabled,
  homeConfiguration,
  ...
}:
homeConfiguration "nixos" {
  # For doom emacs to work, you'll need to clone the repo as per the instructions in the doomemacs/doomemacs repo
  programs.emacs = enabled {
    package = pkgs.emacs29-pgtk;
    extraPackages = epkgs: [
      epkgs.vterm
    ];
  };

  # xdg.configFile.".doom.d" = {
  #   target = "../.doom.d";
  #   source = ./config;
  #   recursive = true;
  #   #onChange = "${pkgs.libnotify}/bin/notify-send -u critical 'DOOM EMACS' 'Changed detected when rebuilding system. Please make sure to run `doom sync`!'";
  # };
}
# home.packages = with pkgs; [
#   rust-analyzer #rust lsp
#   nodePackages.bash-language-server #sh and bash
#   zls #zig lsp
#   rnix-lsp #nix lsp
#   ccls # c and c++ lsp
#   texlive.combined.scheme-medium #latex
#   pandoc #document conversion
#   graphviz #org roam graph generation
# ];
