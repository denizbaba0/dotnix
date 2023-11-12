{ config, home, lib, pkgs, homeConfiguration, homePackages, enabled, ... }: lib.recursiveUpdate

(homeConfiguration "nixos" {
  home = {
    file.".config/nvim".source = pkgs.callPackage (import ./vimacs.nix) {};
    # activation.installNvimConfig = ''
    #   if [ ! -d "~/.config/nvim/" ]; 
    #   then
    #     ln -s "~/.config/nixos/machines/enka/nvim/custom" "~/.config/nvim/lua/"
    #   	chmod -R +w "~/.config/nvim/lua/custom"
    #   fi
    # '';
  };

  programs = {
    # nushell.environmentVariables.EDITOR = "nvim";
    neovim = enabled {
      ## alias vim=nvim
      vimAlias = true;
      # extraLuaConfig = lib.fileContents ./config/init.lua;
      defaultEditor = true;
    };
  };
})

(with pkgs; homePackages "nixos" [
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
