{ homeConfiguration, enabled, ... }:

homeConfiguration "nixos" {
  programs.librewolf = enabled {};
}
