{ homeConfiguration, enabled, ... }:

homeConfiguration "nixos" {
  programs.gh = enabled {};
}
