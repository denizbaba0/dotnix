{
  ulib,
  theme,
  pkgs,
  lib,
  fetchurl,
  ...
}:
with ulib; let
  clion-package = pkgs.jetbrains.clion.overrideAttrs (old: rec {
    src = pkgs.fetchurl {
      url = "https://download.jetbrains.com/clion/CLion-233.11799.284.tar.gz";
      sha256 = "sha256-B1JMBE3kVly/BS+ZgARKpsbigGTu+zAzWHr6Hgn/ab8=";
    };
  });
in (let
  rust-rover-package = pkgs.jetbrains.rust-rover.overrideAttrs (old: rec {
    src = pkgs.fetchurl {
      url = "https://download.jetbrains.com/rustrover/RustRover-233.11799.284.tar.gz";
      sha256 = "sha256-B1JMBE3kVly/BS+ZgARKpsbigGTu+zAzWHr6Hgn/ab8=";
    };
  });
in (
  graphicalPackages (
    with pkgs; [
      jetbrains-toolbox # may crash due to outdated nixpkgs version
      # linuxKernel.packages.linux_latest_libre.perf # perf tool
      # (jetbrains.plugins.addPlugins
      #   clion-package
      #   [
      #     "github-copilot"
      #     "ideavim"
      #     "rust"
      #     "nixidea"
      #   ])

      (jetbrains.plugins.addPlugins rust-rover-package
        [
          "github-copilot"
          "ideavim"
          "rust"
        ])
    ]
  )
))
# JetBrains products are not-compatiple smoothly with NixOS
# You need to patch your build according to the plugins you use !!!
# Some helpful links that will get you there:
# https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/jetbrains/plugins/plugins.json    # <- Check "name" as the name of your plugin you want to patch
# https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/jetbrains/plugins/default.nix#L11C36-L11C44
# https://nixos.wiki/wiki/Jetbrains_Tools

