{
  lib,
  systemConfiguration,
  homeConfiguration,
  imports,
  ...
}:
lib.recursiveUpdate3
(systemConfiguration {
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
    systemd-boot.editor = false;
  };

  system.stateVersion = "23.05";
})
(homeConfiguration "nixos" {
  home.stateVersion = "23.05";
})
(imports [
  ./bat
  ./cursor
  ./discord
  ./docker
  ./dunst
  ./dwm
  ./emacs
  ./firefox
  ./git
  ./github
  ./gtk
  ./helix
  ./kitty
  ./networkmanager
  ./nvim
  ./nushell
  ./picom
  ./pipewire
  ./python
  ./rofi
  ./st
  ./sioyek

  ./fonts.nix
  ./localisation.nix
  ./packages.nix
  ./users.nix

  /etc/nixos/hardware-configuration.nix
])
