{
  ulib,
  lib,
  pkgs,
  upkgs,
  ...
}:
with ulib;
  merge
  (homeConfiguration {
    programs.neovim = enabled {
      package = pkgs.neovim-unwrapped;
      vimAlias = true;
      viAlias  = true;
    };
    # xdg.configFile."nvim".source = ./config; # FIXME: conflicting with flake
    xdg.configFile."nvim".source = (pkgs.callPackage ./vimacs.nix {}).nvchad; # FIXME: conflicting with flake
  })
  (homePackages (with pkgs; [
    # upkgs.vimacs
    # (pkgs.callPackage ./vimacs.nix {})
    # Fancy.
    neovide

    # CMAKE
    cmake-language-server

    # GO
    gopls

    # HTML
    vscode-langservers-extracted

    # KOTLIN
    kotlin-language-server

    # LATEX
    texlab

    # LUA
    lua-language-server

    # MARKDOWN
    marksman

    # NIX
    alejandra
    nixd

    # PYTHON
    python311Packages.python-lsp-server

    # RUST
    rust-analyzer

    # ZIG
    upkgs.zls
  ]))
