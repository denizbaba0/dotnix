{ homePackages, lib, pkgs, theme, homeConfiguration, enabled, ... }:

{
  environment.systemPackages = with pkgs; [
    (siduck76-st.overrideAttrs (oldAttrs: {
      src = pkgs.callPackage (import ./st.nix) {};
    }))
  ];
}
