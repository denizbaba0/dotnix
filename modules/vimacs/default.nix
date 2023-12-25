{
  ulib,
  lib,
  pkgs,
  upkgs,
  theme,
  ...
}:
with ulib;
  merge
  (
    let
      vimacs = ./config;
      # FIXME: doesn't hot reload themes because Neovim caches them.
      vimacs-theme = (
        with theme.withHashtag; ''
                    local M = {}

          -- Credits to original https://github.com/morhetz/gruvbox
          -- Customised to swamp.nvim by masroof-maindak.

          local M = {}

          M.base_30 = {
            white = "${base07}",
            darker_black = "${base00}",
            black = "${base01}", --  nvim bg
            black2 = "${base02}",
            one_bg = "${base00}",
            one_bg2 = "${base01}",
            one_bg3 = "${base02}",
            grey = "${base03}",
            grey_fg = "${base04}",
            grey_fg2 = "${base05}",
            light_grey = "${base06}",

            statusline_bg = "${base02}",
            lightbg = "${base06}",

            red           = "${base08}",
            baby_pink     = "${base0E}",
            pink          = "${base0E}",
            line          = "${base03}", -- for lines like vertsplit
            green         = "${base0B}",
            vibrant_green = "${base0B}",
            nord_blue     = "${base0D}",
            blue          = "${base0D}",
            yellow        = "${base0A}",
            sun           = "${base0A}",
            purple        = "${base0E}",
            dark_purple   = "${base0E}",
            teal          = "${base0C}",
            orange        = "${base09}",
            cyan          = "${base0C}",
            pmenu_bg      = "${base03}",
            folder_bg     = "${base03}",
          }

          M.base_16 = {
            base00 = "${base00}",
            base01 = "${base00}",
            base02 = "${base02}",
            base03 = "${base03}",
            base04 = "${base04}",
            base05 = "${base05}",
            base06 = "${base06}",
            base07 = "${base07}",
            base08 = "${base08}",
            base09 = "${base09}",
            base0A = "${base0A}",
            base0B = "${base0B}",
            base0C = "${base0C}",
            base0D = "${base0D}",
            base0E = "${base0E}",
            base0F = "${base0F}",
          }

          M.type = "dark"

          return M
        ''
      );
    in (graphicalConfiguration {
      programs.neovim = enabled {
        package = pkgs.neovim-unwrapped;
        vimAlias = true;
        viAlias = true;
      };
      # xdg.configFile."nvim".source = ./config; # FIXME: conflicting with flake
      # home.file."nvim/lua".source = (pkgs.callPackage ./vimacs.nix { custom = ./config/lua/custom;}).nvchad; # FIXME: conflicting with flake
      # home.file."nvim/init.lua".source = ./config/init.lua;

      # Workaround for mutibility
      # xdg.configFile."nvim/lua/custom/".source = "${vimacs}/lua/custom/";
      # xdg.configFile."nvim/lua/custom/utils.lua".source = "${vimacs}/lua/custom/utils.lua";
      # xdg.configFile."nvim/lua/custom/plugins.lua".source = "${vimacs}/lua/custom/plugins.lua";
      # xdg.configFile."nvim/lua/custom/mappings.lua".source = "${vimacs}/lua/custom/mappings.lua";
      # xdg.configFile."nvim/lua/custom/init.lua".source = "${vimacs}/lua/custom/init.lua";
      # xdg.configFile."nvim/lua/custom/info.lua".source = "${vimacs}/lua/custom/info.lua";
      # xdg.configFile."nvim/lua/custom/highlights.lua".source = "${vimacs}/lua/custom/highlights.lua";
      # xdg.configFile."nvim/lua/custom/chadrc.lua".source = "${vimacs}/lua/custom/chadrc.lua";
      # xdg.configFile."nvim/lua/custom/configs".source = "${vimacs}/lua/custom/configs";
      # xdg.configFile."nvim/lua/custom/themes/dynamic.lua".text = vimacs-theme;
      # xdg.configFile."nvim/lua/custom/snippets".source = "${vimacs}/lua/custom/snippets";
      # xdg.configFile."nvim/lua/core".source = "${vimacs}/lua/core";
      # xdg.configFile."nvim/lua/plugins".source = "${vimacs}/lua/plugins";

      # xdg.configFile."nvim/lua".source = "${vimacs}/lua";
      # xdg.configFile."nvim/init.lua".source = "${vimacs}/init.lua";
      # xdg.configFile."nvim/lua/custom/themes/dynamic.lua".text = vimacs-theme;
      xdg.configFile."nvim".source = pkgs.symlinkJoin {
        name = "vimacs";
        paths = [
          (pkgs.writeTextDir "lua/custom/themes/dynamic.lua" vimacs-theme)
          vimacs
        ];
      };
    })
  )
  (homePackages (with pkgs; [
    # upkgs.vimacs
    # (pkgs.callPackage ./vimacs.nix {})
    # Fancy.
    neovide

    # Languages
    codespell

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
    # nixd
    nil
    deadnix

    # PYTHON
    python311Packages.python-lsp-server

    # RUST
    rust-analyzer

    # ZIG
    upkgs.zls
  ]))
