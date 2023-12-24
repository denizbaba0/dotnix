{
  ulib,
  lib,
  pkgs,
  upkgs,
  ...
}:
with ulib;
  merge
  (
    let
      vimacs = ./config;
    in (graphicalConfiguration {
      programs.neovim = enabled {
        package = pkgs.neovim-unwrapped;
        vimAlias = true;
        viAlias = true;
      };
      # xdg.configFile."nvim".source = ./config; # FIXME: conflicting with flake
      # home.file."nvim/lua".source = (pkgs.callPackage ./vimacs.nix { custom = ./config/lua/custom;}).nvchad; # FIXME: conflicting with flake
      # home.file."nvim/init.lua".source = ./config/init.lua;
      xdg.configFile."nvim/lua".source = "${vimacs}/lua";
      xdg.configFile."nvim/init.lua".source = "${vimacs}/init.lua";
    })
  )
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
