{
  ulib,
  pkgs,
  ...
}:
with ulib;
  merge
  (graphicalPackages (with pkgs; [
    # fluffychat
    # matrixcli
    # cinny-desktop
    iamb
  ]))
  (graphicalConfiguration {
    # TODO: use nix2json
    # xdg.configFile."iamb".source = ./config/iamb;
  })
