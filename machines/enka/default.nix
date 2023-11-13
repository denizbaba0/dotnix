{ lib, systemConfiguration, homeConfiguration, imports, ... }: lib.recursiveUpdate3

(systemConfiguration {
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable      = true;
    systemd-boot.editor      = false;
  };

  system.stateVersion = "23.05";
})

(homeConfiguration "nixos" {
  home.stateVersion = "23.05";
})

(imports [
  ./bat
  ./blueman
  ./discord
  ./docker
  ./dunst
  ./dwm
  ./firefox
  ./fuzzel
  ./git
  ./github
  ./gtk
  ./helix
  ./hyprland
  ./kitty
  ./networkmanager
  ./nvim
  ./nushell
  ./openttd
  ./pipewire
  ./python
  ./st
  ./steam
  ./steck

  ./fonts.nix
  ./localisation.nix
  ./packages.nix
  ./users.nix

  /etc/nixos/hardware-configuration.nix
])
