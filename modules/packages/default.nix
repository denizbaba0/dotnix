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
  gh
  # github-copilot-cli # using `gh copilot`

  wine

  clang_16
  clang-tools_16
  go
  jdk
  lld
  maven
  vlang
  zig
  nodejs
]))

(graphicalPackages (with pkgs; [
  # qbittorrent
  # thunderbird
  # whatsapp-for-linux
  xfce.thunar        # File Manager
  vieb               # Vim Browser
  # nvi              # Text Editor
  ranger

  krita
  obs-studio
  # surf
  mpv                # Media Player

  libreoffice
  hunspellDicts.en_US
  hunspellDicts.en_GB-ize
]))

# [1]: Used with some nushell scripts (See modules/nushell/scripts/*)
