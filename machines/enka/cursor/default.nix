{
  pkgs,
  homeConfiguration,
  ...
}:
homeConfiguration "nixos" {
  home.file.".icons/default".source = ./src/material_cursors;
  # home.pointerCursor = ./src/material_cursors;
}
