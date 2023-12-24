{ ulib, ... }: with ulib; merge3

(systemConfiguration {
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.05";

  users.users.nixos = graphicalUser {
    description = "orhnk";
    extraGroups = [ "wheel" ];
  };
})

(homeConfiguration {
  home.stateVersion = "23.05";
})

(importModules [
  ./hardware.nix

  "bat"
  "blueman"
  "boot"
  "btop"
  "discord"
  "dunst"
  "dwm"
  # "emacs" # BROKEN
  "eww"
  "firefox"
  "fonts"
  # "ghostty"
  "git"
  "gtk"
  "helix"
  "jetbrains"
  "kitty"
  "kmscon"
  "localisation"
  "logind"
  "matrix"
  "networkmanager"
  "nix"
  "nushell"
  "nvidia"
  "packages"
  "picom"
  # "pipewire"
  "pueue"
  "python"
  "qt"
  "ripgrep"
  "rust"
  "rofi"
  "sioyek"
  "ssh"
  "st"
  "steck"
  "sudo"
  "vimacs"
  "vscode"
])
