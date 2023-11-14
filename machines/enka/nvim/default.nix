{ config, home, lib, pkgs, homeConfiguration, homePackages, enabled, ... }: lib.recursiveUpdate

(homeConfiguration "nixos" {
  home = {
    file.".config/nvim".source = pkgs.callPackage (import ./config) {};
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
  # Fancy Neovide Nvim Client
  neovide

  # CMAKE
  cmake-language-server

  # GO
  gopls

  # KOTLIN
  kotlin-language-server

  # LATEX
  texlab

  # LUA
  lua-language-server

  # MARKDOWN
  marksman

  # NIX
  nil

  # RUST
  rust-analyzer

  # ZIG
  zls
])
