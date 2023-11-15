{
  systemPackages,
  pkgs,
  ...
}: let
  doom-emacs =
    pkgs.callPackage (builtins.fetchTarball {
      url = "https://github.com/nix-community/nix-doom-emacs/archive/master.tar.gz";
    }) {
      doomPrivateDir = ./config; # Directory containing your config.el, init.el
      # and packages.el files
    };
in
  # home.packages = [doom-emacs];
  (with pkgs;
    systemPackages [
      doom-emacs
    ])
