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
  ./discord
  ./docker
  ./dunst
  ./dwm
  ./emacs
  ./eww
  ./firefox
  ./git
  ./github
  ./gtk
  ./helix
  ./jetbrains
  ./kitty
  ./networkmanager
  ./nushell
  ./nvim
  ./picom
  ./pipewire
  ./python
  ./rofi
  ./sioyek
  ./st
  ./theme
  ./vscode

  ./fonts.nix
  ./localisation.nix
  ./mount.nix
  ./packages.nix
  ./users.nix

  /etc/nixos/hardware-configuration.nix
])
