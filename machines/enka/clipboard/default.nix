{
  lib,
  systemConfiguration,
  homeConfiguration,
  imports,
  enabled, pkgs,
  ...
}: (homeConfiguration "nixos" {
  services.copyq = enabled {
    package = pkgs.copyq;
  };
})
