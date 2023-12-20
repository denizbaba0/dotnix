{
  lib,
  pkgs,
  systemPackages,
  homeConfiguration,
  enabled,
  ...
}:
homeConfiguration "nixos" {
  # xdg.configFile."eww".source = ./config;
  programs.eww = enabled {
    configDir = ./config;
  };
}
