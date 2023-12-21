{ ulib, ... }: with ulib; merge3

(systemConfiguration {
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.05";

  users.users.SnakeCase = graphicalUser {
    description = "Usable Hyprland rice. If you don't use nVidia like me";
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
  "fuzzel"
  "ghostty"
  "git"
  "gtk"
  "helix"
  "hyprland"
  "jetbrains"
  "kitty"
  # "kmscon"
  "localisation"
  "logind"
  # "networkmanager"
  "nix"
  "nushell"
  "nvidia"
  # "openttd"
  "packages"
  "pipewire"
  "pueue"
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
