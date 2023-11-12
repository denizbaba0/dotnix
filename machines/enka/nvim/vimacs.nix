{ lib, stdenv, pkgs, src }:

let
  custom = ./custom;
in
stdenv.mkDerivation {
  pname = "nvchad";
  version = "1.0.0";

  src = pkgs.fetchFromGitHub {
    owner = "NvChad";
    repo = "NvChad";
    rev = "refs/heads/v2.0";
    sha256 = "sha256-1gSXfZvu0MR8QwLBzzNDoZGWSpCrD3wWxGFBG7hOU5E=";
  };

  installPhase = ''
    mkdir $out
    cp -r $src "$out/"
    cp -r $src/init.lua $out/
    mkdir -p "$out/lua"
    cp -r $src/lua/core $out/lua/
    cp -r $src/lua/plugins $out/lua/
    cp -r ${custom} "$out/lua/custom"
  	# chmod -R +w $out/lua/custom
  '';

  meta = with lib; {
    description = "NvChad";
    homepage = "https://github.com/NvChad/NvChad";
    platforms = platforms.all;
    license = licenses.gpl3;
  };
}

# # allow our nixpkgs import to be overridden if desired
# { pkgs ? import <nixpkgs> {} }:

# # let's write an actual basic derivation
# # this uses the standard nixpkgs mkDerivation function
# pkgs.stdenv.mkDerivation {

#   # name of our derivation
#   name = "vimacs";

#   # sources that will be used for our derivation.
#   src = ./config/lua;

#   # see https://nixos.org/nixpkgs/manual/#ssec-install-phase
#   # $src is defined as the location of our `src` attribute above
#   installPhase = ''
#     # $out is an automatically generated filepath by nix,
#     # but it's up to you to make it what you need. We'll create a directory at
#     # that filepath, then copy our sources into it.
#     mkdir $out
#     cp -rv $src/* $out
#   '';
# }
