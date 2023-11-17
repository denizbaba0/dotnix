{
  pkgs,
  lib,
  homeConfiguration,
  homePackages,
  ...
}:
lib.recursiveUpdate
(homeConfiguration "nixos" {
  # Manual Way (reproducible)
  # home.file.".icons/default".source = ./src/material_cursors;
  # home.pointerCursor = ./src/material_cursors;

  gtk = {
    iconTheme = {
      name = "Gruvbox";
      package = pkgs.callPackage (import ./gruvbox-icons.nix) {};
    };
  };

  home.pointerCursor = {
    size = 40;
    package = pkgs.bibata-cursors;
    name = "Bibata_Ice";
    # package = pkgs.nur.repos.ambroisie.vimix-cursors;
    # name = "Vimix-white-cursors";
    # name = "Vimix-cursors";

    # package = pkgs.capitaine-cursors;
    # name = "capitaine-cursors";

    # package = pkgs.nur.repos.ambroisie.volantes-cursors;
    # name = "volantes_light_cursors";
    # name = "volantes_cursors";

    # package = pkgs.nur.repos.dan4ik605743.lyra-cursors;
    # name = "LyraF-cursors";
  };
})
(with pkgs;
  homePackages "nixos" [
    lxappearance # GUI for theme settings
    # gruvbox-dark-gtk # GTK theme
    # gruvbox-gtk-theme # GTK theme
  ])
