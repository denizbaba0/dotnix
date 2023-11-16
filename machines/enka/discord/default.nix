{ pkgs, homePackages, ... }:

with pkgs; homePackages "nixos" [
  betterdiscordctl
  (discord.override {
    withOpenASAR = true;
    withVencord  = true;
  })
]
