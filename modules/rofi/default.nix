{ lib, pkgs, systemPackages, homeConfiguration, enabled, ... }:

(homeConfiguration "nixos" {
  home.file.".config/rofi".source = ./config;
  programs.rofi = enabled {
    font = "JetBrainsMono 14";
  };
})
