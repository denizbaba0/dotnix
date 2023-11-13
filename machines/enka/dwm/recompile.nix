# allow our nixpkgs import to be overridden if desired
{ imlib2, libXinerama, libXft, libX11, gnumake, pkgs ? import <nixpkgs> {} }:

# let's write an actual basic derivation
# this uses the standard nixpkgs mkDerivation function
pkgs.stdenv.mkDerivation {

  # name of our derivation
  name = "dwm";

  # sources that will be used for our derivation.
  src = ./config;

  buildInputs = [ imlib2 libX11 libXft libXinerama gnumake ];

  # see https://nixos.org/nixpkgs/manual/#ssec-install-phase
  # $src is defined as the location of our `src` attribute above
  installPhase = ''
    # $out is an automatically generated filepath by nix,
    # but it's up to you to make it what you need. We'll create a directory at
    # that filepath, then copy our sources into it.
    mkdir $out
    cp -rv $src/chadwm/* $out
    rm $out/config.h -rf

    cd $out
    make dwm

    mkdir bin
    mv dwm bin/dwm

    cp bin/dwm $out

    # mkdir -p /usr/local/bin/
    # ln -s bin/dwm $out/dwm

    # ln -s bin/dwm /usr/local/bin/dwm
    # install -D $src $out/bin/dwm
    
    # cd $out
    # make install
  '';
}
