{
  lib,
  pkgs,
  homeConfiguration,
  homePackages,
  enabled,
  ...
}:
homeConfiguration "nixos" {
  programs.vscode = enabled {
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      rust-lang.rust-analyzer
    ];
  };
}
