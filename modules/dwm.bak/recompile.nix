# allow our nixpkgs import to be overridden if desired
{
  acpi,
  imlib2,
  libXinerama,
  libXft,
  libX11,
  gnumake,
  theme ? "",
  pkgs ? import <nixpkgs> {},
}:
# let's write an actual basic derivation
# this uses the standard nixpkgs mkDerivation function
pkgs.stdenv.mkDerivation {
  # name of our derivation
  name = "dwm (chad)";

  # sources that will be used for our derivation.
  src = ./config/chadwm;

  buildInputs = [imlib2 libX11 libXft libXinerama gnumake acpi];

  # see https://nixos.org/nixpkgs/manual/#ssec-install-phase
  # $src is defined as the location of our `src` attribute above
  installPhase = ''
    # $out is an automatically generated filepath by nix,
    # but it's up to you to make it what you need. We'll create a directory at
    # that filepath, then copy our sources into it.
    mkdir $out

    rm config.h -rf
    echo "${theme}" > themes/dynamic.h

    make dwm

    mkdir bin
    cp dwm bin/

    mv dwm $out
  '';
}
