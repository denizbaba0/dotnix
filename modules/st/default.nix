{
  ulib,
  pkgs,
  ...
}:
with ulib;
  homePackages (with pkgs; [
    (siduck76-st.overrideAttrs (oldAttrs: {
      src = pkgs.callPackage (import ./st.nix) {};
    }))
  ])
