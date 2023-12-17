{
  lib,
  pkgs,
  systemPackages,
  homePackages,
  ...
}:
lib.recursiveUpdate
(with pkgs;
  systemPackages [
    # Libs #
    libtool # for some cmake error (emacs/vterm module compilation)

    # Command Line Tools #
    neofetch # system info
    ripgrep  # grep search
    tree     # tree view
    ps_mem   # memory usage
    gotop    # system monitor
    unzip
    wakatime # time tracking

    # Development Tools #
    clang_16
    clang-tools_16
    cmake
    go
    jdk
    lld # linker
    vlang
    zig
    nodejs_20
    openssl

    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
  ])
(with pkgs;
  homePackages "nixos" [
    # System Applications #
    thunderbird
    pantheon.elementary-files # file browser
    simplescreenrecorder      # Screen Recorder
    telegram-desktop          # Telegram Client
    gimp                      # Image Editor
    whatsapp-for-linux        # WhatsApp
    mpv                       # Video Player
    inkscape                  # Vector Graphics Editor
    kazam                     # ScreenShot
    vieb                      # Vim Browser

    obs-studio

    libreoffice
    hunspellDicts.en_US
    # hunspellDicts.tr_TR # TODO: find the appropriate name
    hunspellDicts.en_GB-ize
  ])
