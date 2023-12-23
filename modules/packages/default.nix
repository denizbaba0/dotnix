{ ulib, pkgs, ... }: with ulib; merge

(systemPackages (with pkgs; [
  asciinema
  fastfetch
  hyperfine
  moreutils
  nix-index
  nix-output-monitor
  p7zip
  pstree
  strace
  timg
  tree
  usbutils
  yt-dlp
  ffmpeg              # cli image manupilation 
  timer               # 
  notify-desktop      # cli desktop nofifier [1]
  translate-shell     # cli translator

  wine

  clang_16
  clang-tools_16
  gh
  go
  jdk
  lld
  maven
  vlang
  zig
]))

(graphicalPackages (with pkgs; [
  # qbittorrent
  # thunderbird
  # whatsapp-for-linux
  xfce.thunar        # File Manager
  vieb               # Vim Browser
  # nvi              # Text Editor

  krita
  obs-studio
  # surf
  mpv                # Media Player

  libreoffice
  hunspellDicts.en_US
  hunspellDicts.en_GB-ize
]))

# [1]: Used with some nushell scripts (See modules/nushell/scripts/*)
