{
  lib,
  pkgs,
  systemPackages,
  homeConfiguration,
  ...
}:
lib.recursiveUpdate
(with pkgs;
  systemPackages [
    (python311.withPackages (pkgs:
      with pkgs; [
        pip
        requests
      ]))
    virtualenv
    poetry
  ])
(homeConfiguration "nixos" {
  # pkgs.python37Packages.opencv2.package = pkgs.callPackage (import ./opencv.nix) {};
  programs.nushell.shellAliases = {
    venv = "virtualenv venv";
  };
})
