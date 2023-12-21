{
  ulib,
  pkgs,
  upkgs,
  theme,
  ...
}:
with ulib;
  merge3
  (let
    startup_copyq = true;
    logdir = "/dev/null";
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
    theme_patch = "
      
    "
  in
    systemConfiguration {
      hardware.opengl = enabled {
        # On 64-bit systems, if you want OpenGL for 32-bit programs
        # such as in Wine, you should also set the following:
        driSupport32Bit = true;
      };

      services.xserver = enabled {
        layout = "tr";
        videoDrivers = ["nvidiaLegacy390"]; # nvidia GT630
        windowManager.dwm = enabled {
          package = pkgs.callPackage (import ./recompile.nix) {};
        };


        displayManager = {
          gdm = enabled {};
          defaultSession = "none+chadwm"; # desktop+wm
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
               ${
                 if startup_copyq
                 then "copyq &"
                 else ""
               }
               ${xrandr}

               # NOTE: picom autostarts in the way It's declared in `default.nix`

               while type dwm ; do dwm &> ${logdir} && continue || break; done
             '';
           }
         ];
         autoLogin = enabled {
           user = "nixos";
         };
        };
      };
    })
  (homeConfiguration {
    home.file.".Xresources".source = ./dotXresources;
    xdg.configFile."chadwm".source = ./config;
    # using `services` instead of `packages` triggers picom on every boot
  })
  (homePackages (with pkgs; [
    # chadwm: screenshot tool (used with xclip)
    maim
    xclip # also mentioned in nvim config
    copyq # clipboard manager

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
