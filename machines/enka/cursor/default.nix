{
  pkgs,
  homeConfiguration,
  ...
}:
homeConfiguration "nixos" {
  # Bad Way
  # home.file.".icons/default".source = ./src/material_cursors;
  # home.pointerCursor = ./src/material_cursors;
  gtk.cursorTheme.package = pkgs.vanilla-dmz;
  gtk.cursorTheme.name = "Vanilla-DMZ";
  # home.pointerCursor = {
  #   size = 40;
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
  # };
}
