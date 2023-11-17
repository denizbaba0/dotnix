# NOTE found from reddit:
# You can pass the path to lib.mkOutOfStoreSymlink. If you're using flakes, make sure to pass an absolute path string.
{
  config,
  home,
  lib,
  pkgs,
  homeConfiguration,
  homePackages,
  systemPackages,
  enabled,
  ...
}:
lib.recursiveUpdate
(homeConfiguration "nixos" {
  xdg.configFile."doom".source = ./config;
  home.file.".doom.d" = {
    source = ./config;
    recursive = true;
    onChange = builtins.readFile ./reload.sh;
  };
  # NOTE: didn't work
  # xdg.configFile."doom".source = ./config; # doom modifies here while `doom sync`
  # xdg.configFile."emacs".source = pkgs.callPackage (import ./doom.nix) {};
  # home.file.".emacs.d".source = pkgs.callPackage (import ./doom.nix) {};

  # use programs.emacs if you don't want to use emacs daemon
  # emacs daemon allows emacs to start up faster
  services.emacs = enabled {};
  programs.emacs = enabled {
    # package = pkgs.emacs29-pgtk;
  };
})
(with pkgs;
  homePackages "nixos" [
    # texlive.combined.scheme-tetex # for org-mode export, (e.g pdflatex"")
    # pandoc # for org-mode export
    # graphviz
  ])
# (
#   with pkgs;
#     systemPackages [
#       # emacsPackages.vterm
#       # #(pkgs.emacs.override {withGTK3 = false; nativeComp = true;})
#       # emacsPackages.adwaita-dark-theme
#     ]
# )
