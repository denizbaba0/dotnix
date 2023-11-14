{ config, home, lib, pkgs, homeConfiguration, homePackages, enabled, ... }: lib.recursiveUpdate

(homeConfiguration "nixos" {
  home = {
    # file.".config/nvim".source = ./config;
    file.".config/nvim".source = ./config;
    # activation.installNvimConfig = ''
    #   if [ ! -d "~/.config/nvim/" ]; 
    #   then
    #     ln -s "~/.config/nixos/machines/enka/nvim/custom" "~/.config/nvim/lua/"
    #   	chmod -R +w "~/.config/nvim/lua/custom"
    #   fi
    # '';
  };

  programs.neovim = enabled {
    # package = pkgs.callPackage (import ./vimacs.nix) {};
    ## alias vim=nvim
    vimAlias = true;
    viAlias  = true;
    # extraLuaConfig = lib.fileContents ./config/init.lua;
    defaultEditor = true;
  };
})

(with pkgs; homePackages "nixos" [
  # Clipboard Manager for X
  xclip

  # # Fancy Neovide Nvim Client
  # neovide

  # General
  codespell

  # CMAKE
  cmake-language-server

  # # GO
  # gopls

  # # KOTLIN
  # kotlin-language-server

  # # LATEX
  # texlab

  # LUA
  stylua

  # MARKDOWN
  marksman

  # NIX
  nil       # LSP
  deadnix   # linter
  statix    # linter
  alejandra # formatter (written in rust)

  # RUST
  rust-analyzer

  # # ZIG
  # zls
])
