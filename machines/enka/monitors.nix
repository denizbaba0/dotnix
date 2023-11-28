{
  lib,
  pkgs,
  theme,
  systemConfiguration,
  homeConfiguration,
  homePackages,
  enabled,
  ...
}: (homeConfiguration "nixos" {
  services.autorandr = enabled {}; # automatically set up displays
})
