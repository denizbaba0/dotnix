	{
	  lib,
	  pkgs,
	  theme,
	  systemConfiguration,
	  homeConfiguration,
	  homePackages,
	  enabled,
	  ...
	}:
	lib.recursiveUpdate3
(
  let
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

        # # Enables Desktop Manager
        # # Don't forget to set displayManager.defaultSession = "xfce";
        # desktopManager = {
        #   xfce = enabled {};
        # };

        windowManager.dwm = enabled {
          package = pkgs.callPackage (import ./recompile.nix) {};
          # extraPackages = with pkgs; [ i3status i3lock polybar ];
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
                ${if startup_copyq then "copyq &" else ""}
                ${xrandr}

                # NOTE: picom autostarts in the way It's declared in `default.nix`

                while type dwm >/dev/null; do dwm && continue || break; done
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
(homeConfiguration "nixos" {
  home.file.".Xresources".source = ./dotXresources;
  home.file.".config/chadwm".source = ./config;
  # using `services` instead of `packages` triggers picom on every boot
})
(with pkgs;
  homePackages "nixos" [
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
  ])
