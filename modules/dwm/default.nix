{
  ulib,
  pkgs,
  theme,
  config,
  ...
}:
with ulib; with theme;
  merge3
  (
    let
      clipboard_daemon = "greenclip daemon";
      startup_copyq = true;
      wallpaper = "~/Pictures/wallpapers/stairs.jpg";
      xrandr = ''
        xrandr --output VGA-1     \
               --mode 1024x768    \
               --pos 0x0          \
               --rotate normal    \
               --right-of HDMI-1  \
                                  \
               --output HDMI-1    \
               --mode 1920x1080   \
               --rotate normal    \
               --primary          \
      '';
      # passed using echo "${theme}" > theme.h
      dynamic-theme = ''
        static const char black[]         = \"#${theme.base00}\";
        static const char blue[]          = \"#${theme.base0D}\"; // focused window border
        static const char gray2[]         = \"#${theme.base00}\"; // unfocused window border
        static const char gray3[]         = \"#${theme.base01}\";
        static const char gray4[]         = \"#${theme.base00}\";
        static const char green[]         = \"#${theme.base0C}\";
        static const char orange[]        = \"#${theme.base09}\";
        static const char pink[]          = \"#${theme.base0E}\";
        static const char red[]           = \"#${theme.base08}\";
        static const char white[]         = \"#${theme.base06}\";
        static const char yellow[]        = \"#${theme.base0B}\";
        static const char col_borderbar[] = \"#${theme.base00}\";
      '';
      patch = pkgs.writeTextFile {
        name = "dynamic-theming";
        text = import ./patches/dynamic-theme.nix.diff {inherit theme;};
        destination = "dynamic-theming.diff";
      };
    in
      systemConfiguration {
        hardware.opengl = enabled {
          # On 64-bit systems, if you want OpenGL for 32-bit programs
          # such as in Wine, you should also set the following:
          driSupport32Bit = true;
        };

        services.xserver = enabled {
          # xrandrHeads = [ # NOTE: No effect
          #   # do `xrandr --query` to get the names of your screens
          #   # "HDMI-0" # TODO: uncomment this
          #   "VGA-1"
          # ];
          layout = "tr";
          videoDrivers = ["nvidiaLegacy390"]; # nvidia GT630

          # Enables Desktop Manager
          # Don't forget to set displayManager.defaultSession = "xfce";
          desktopManager = {
            xfce = enabled {};
          };

          windowManager.dwm = enabled {
            package = pkgs.callPackage (import ./recompile.nix) {
              theme = dynamic-theme;
              # patches = [patch];
            };
          };

          displayManager = {
            gdm = enabled {};
            defaultSession = "none+chadwm"; # nodesktopenv + wm ("none+i3")
            session = [
              # https://mynixos.com/nixpkgs/option/services.xserver.displayManager.session
              {
                manage = "window"; # desktop or window
                name = "chadwm";
                # start = lib.fileContents ./boot.sh;
                start = ''
                  xrdb merge ~/.Xresources &
                  # xbacklight -set 10 & # TODO: not working (idk if essential)
                  xset r rate 200 50 &
                  dash ~/.config/chadwm/scripts/bar.sh &
                  # draw our wallpaper only if xinit is not set
                  if [ ! -f $XDG_CONFIG_HOME/sxmo/xinit ]; then
                    ${pkgs.feh}/bin/feh --bg-fill -z ${wallpaper} &
                  fi
                  eww daemon & # start eww daemon for faster widget startup
                  ${clipboard_daemon} &
                  ${xrandr} &

                  # NOTE: picom autostarts in the way It's declared in `default.nix`

                  while type dwm ; do ${config.services.xserver.windowManager.dwm.package}/bin/dwm && continue || break; done
                '';
              }
            ];
            autoLogin = enabled {
              user = "nixos";
            };
          };
        };
      }
  )
  (let

      bar-theme = ''
        black=#${base00}
        black_dark=#1d2021
        blue=#${base0D}
        blue_dark=#458588
        aqua=#${base0C}
        aqua_dark=#689d6a
        green=#${base0B}
        green_dark=#98971a
        grey=#${base01}
        # grey_dark=#3c3836
        magenta=#${base0E}
        magenta_dark=#b16286
        orange=#${base09}
        orange_dark=#d65d0e
        red=#${base08}
        red_dark=#cc241d
        white=#${base0F}
        white_dark=#${base0F}
      '';
in
   (homeConfiguration {
    home.file.".Xresources".source = ./dotXresources; # NOTE
    xdg.configFile."chadwm".source = ./config;
    xdg.configFile."nix/chadwm/bar/theme".text = bar-theme;
  }))
  (homePackages
    (with pkgs; [
      # chadwm: screenshot tool (used with xclip)
      maim
      xclip # also mentioned in nvim config
      # copyq                   # featureful clipboard manager
      haskellPackages.greenclip #            clipboard manager

      # Dash TODO: rewrite these in nushell
      # Needed for small scripts like dwmbar, startup etc.
      dash

      # chadwm: imlib2
      imlib2

      # chadwm: Image viewer + wallpaper setter: NOTE: Minimalist + Solid
      feh

      # chadwm: Selection Menu: TODO: switch to dmenu (<3 suckless)
      rofi

      # chadwm: acpi
      acpi

      # chadwm: build tool: TODO: move these buildInputs to `compile.nix`
      gnumake
    ]))
