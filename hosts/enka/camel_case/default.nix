{ ulib, ... }: with ulib; merge3

(systemConfiguration {
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.05";

  users.users.nixos = graphicalUser {
    description = "camel_case's, daily driver";
    extraGroups = [ "wheel" ];
  };
})

(homeConfiguration {
  home.stateVersion = "23.05";
})

(importModules [
  ./hardware.nix

  "bat"
  # "blueman"
  "boot"
  "btop"
  # "discord"
  "dunst"
  # "emacs"
  "firefox"
  "fonts"
  "ghostty"
  "git"
  "gtk"
  "helix"
  "jetbrains"
  "kitty"
  # "kmscon"
  "localisation"
  "logind"
  # "networkmanager"
  "nix"
  "nushell"
  "nvidia"
  "packages"
  "pipewire"
  # "pueue"
  "python"
  "qt"
  "ripgrep"
  "rust"
  "ssh"
  # "steam"
  "steck"
  "sudo"
  "vimacs"
  "vscode"
  "waybar"
])
