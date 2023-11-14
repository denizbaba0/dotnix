{ lib, pkgs, systemPackages, homePackages, ... }: lib.recursiveUpdate

(with pkgs; systemPackages [
  neofetch
  ripgrep
  tree

  clang_16
  clang-tools_16
  go
  jdk
  lld # linker
  vlang
  zig

  (fenix.complete.withComponents [
    "cargo"
    "clippy"
    "rust-src"
    "rustc"
    "rustfmt"
  ])
])

(with pkgs; homePackages "nixos" [
  thunderbird
  pantheon.elementary-files # file browser
  simplescreenrecorder # Screen Recorder
  telegram-desktop     # Telegram Client
  gimp                 # Image Editor
  whatsapp-for-linux   # WhatsApp

  obs-studio

  libreoffice
  hunspellDicts.en_US
  # hunspellDicts.tr_TR # TODO: find the appropriate name
  hunspellDicts.en_GB-ize
])
