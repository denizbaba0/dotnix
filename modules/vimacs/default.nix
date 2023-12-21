{
  ulib,
  lib,
  pkgs,
  upkgs,
  ...
}: with ulib; merge

(homeConfiguration {
  #   programs.neovim = enabled {
  #     vimAlias = true;
  #     viAlias  = true;
  #   };
  xdg.configFile."nvim".source = ./config;
})
  (homePackages (with pkgs; [
    upkgs.neovim

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
