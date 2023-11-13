{ lib, pkgs, systemConfiguration, homeConfiguration, enabled, ... }: lib.recursiveUpdate

(systemConfiguration {
  programs.dconf = enabled {};
})

(homeConfiguration "nixos" {
  gtk = enabled {
    font = {
      name    = "JetBrainsMono";
      package = pkgs.jetbrains-mono;
      size    = 10;
    };

    iconTheme = {
      name    = "Gruvbox-Dark";
      package = pkgs.gruvbox-dark-icons-gtk;
    };

    theme = {
      name    = "Gruvbox-Dark-BL";
      package = pkgs.gruvbox-gtk-theme;
    };
  };
})

