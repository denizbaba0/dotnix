{ fetchFromGitHub, programs, lib, pkgs, systemPackages, homeConfiguration, enabled, ... }:

# (with pkgs; systemPackages [
#   picom
# ])

{
  environment.systemPackages = with pkgs; [
    (picom.overrideAttrs (oldAttrs: {
      src = pkgs.fetchFromGitHub {
        owner = "pijulius";
        repo = "picom";
        rev = "refs/heads/implement-window-animations";
        sha256 = "sha256-1gSXfZvu0MR8QwLBzzNDoZGWSpCrD3wWxGFBG7hOU5E=";
      };

      installPhase = ''
        mkdir $out

        cd $src
        meson --buildtype=release . build
        ninja -C build

        mv picom $out
      '';
    }))
  ];
}
