{
  lib,
  stdenv,
  pkgs,
  src,
  emacs,
}: let
  config = ./config;
in
  stdenv.mkDerivation {
    pname = "doom-emacs";
    version = "1.0.0";

    src = pkgs.fetchFromGitHub {
      owner = "doomemacs";
      repo = "doomemacs";
      rev = "986398504d09e585c7d1a8d73a6394024fe6f164";
      sha256 = "sha256-vrdwIu6F11OOSaS5SfgT/jx0Kvu7KaigthVGBENKR5k=";
    };

    buildInputs = [ emacs ];

    installPhase = ''
      mkdir $out
      cd $src
      bash ./bin/doom install
      # cp -rv $src/* $out/
      # $out/bin/doom install
      # $out/bin/doom sync
    '';
  }
