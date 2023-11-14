{ fetchFromGitHub, programs, lib, pkgs, systemPackages, homeConfiguration, enabled, ... }:

# (with pkgs; systemPackages [
#   picom
# ])

{
  services.picom = enabled {};
  environment.systemPackages = with pkgs; [
    (picom.overrideAttrs (prev: {
        version = "git";
        src = pkgs.fetchFromGitHub {
          owner = "pijulius";
          repo = "picom";
          rev = "982bb43e5d4116f1a37a0bde01c9bda0b88705b9";
          sha256 = "sha256-VBnIzisg/7Xetd/AWVHlnaWXlxX+wqeYTpstO6+T5cE=";
        };
    }))
  ];
}

# {
#   environment.systemPackages = with pkgs; [
#     (picom.overrideAttrs (oldAttrs: {
#       src = pkgs.fetchFromGitHub {
#         owner = "pijulius";
#         repo = "picom";
#         rev = "982bb43e5d4116f1a37a0bde01c9bda0b88705b9";
#         sha256 = "sha256-YiuLScDV9UfgI1MiYRtjgRkJ0VuA1TExATA2nJSJMhM=";
#       };

#       installPhase = ''
#         mkdir $out

#         cd $src
#         meson --buildtype=release . build
#         ninja -C build

#         mv picom $out
#       '';
#     }))
#   ];
# }
