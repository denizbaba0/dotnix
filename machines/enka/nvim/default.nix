# NOTE found from reddit:
# You can pass the path to lib.mkOutOfStoreSymlink. If you're using flakes, make sure to pass an absolute path string.
{
  config,
  home,
  lib,
  pkgs,
  homeConfiguration,
  homePackages,
  enabled,
  systemConfiguration,
  ...
}:
lib.recursiveUpdate3
(homeConfiguration "nixos" {
  home = {
    # file.".config/nvim".source = ./config; # NOTE: migrated to manual git clone
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
    package = pkgs.neovim-nightly;
    ## alias vim=nvim
    vimAlias = true;
    viAlias = true;
    # extraLuaConfig = lib.fileContents ./config/init.lua;
    # defaultEditor = true; # FIX: Didn't work for some reason <24-11-23>
  };
})
(
  systemConfiguration {
    environment.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  }
)
(with pkgs;
  homePackages "nixos" [
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
    proselint
    deno # for marksman fmt

    # NIX
    nil # LSP
    deadnix # linter
    statix # linter
    alejandra # formatter (written in rust)

    # RUST
    rust-analyzer

    # # ZIG
    # zls

    # Shell
    shellcheck
    shfmt

    # Python
    ruff

    # GitCommit
    gitlint

    # TOML
    taplo
  ])
