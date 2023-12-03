{
  lib,
  pkgs,
  homeConfiguration,
  homePackages,
  enabled,
  ...
}:
(let
  clion = pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.clion [
    "github-copilot"
    "ideavim"
    "rust"
    "nixidea"
  ];

  rust-rover = pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.rust-rover [
    "github-copilot"
    "ideavim"
    "rust"
  ];
in (
  with pkgs;
  homePackages "nixos" [
    jetbrains-toolbox # may crash due to outdated nixpkgs version
    clion
    rust-rover
    linuxKernel.packages.linux_latest_libre.perf
  ]
))
# JetBrains products are not-compatiple smoothly with NixOS
# You need to patch your build according to the plugins you use !!!
# Some helpful links that will get you there:
# https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/jetbrains/plugins/plugins.json    # <- Check "name" as the name of your plugin you want to patch
# https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/jetbrains/plugins/default.nix#L11C36-L11C44
# https://nixos.wiki/wiki/Jetbrains_Tools

