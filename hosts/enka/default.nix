{ ulib, ... }: with ulib; merge3

(systemConfiguration {
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.05";

  users.users.nixos = graphicalUser {
    description = "DWM based daily driver";
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
  "networkmanager"
  "nix"
  "nushell"
  "nvidia"
  "packages"
  "picom"
  "pipewire"
  "pueue"
  "python"
  "qt"
  "ripgrep"
  "rust"
  "sioyek"
  "ssh"
  "steck"
  "sudo"
  "vimacs"
  "vscode"
])
