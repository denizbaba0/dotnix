{ lib, pkgs, hyprland, theme, systemConfiguration, homeConfiguration, homePackages, enabled, ... }: lib.recursiveUpdate3

(systemConfiguration {
  hardware.opengl = enabled {
    # On 64-bit systems, if you want OpenGL for 32-bit programs 
    # such as in Wine, you should also set the following:
    driSupport32Bit = true;  
  };

  services.xserver = enabled {
    layout = "tr";
    videoDrivers = [ "nvidiaLegacy390" ]; # nvidia GT630
    windowManager.xmonad = enabled {
      # package = pkgs.i3-gaps;
      # extraPackages = with pkgs; [ i3status i3lock polybar ];
    };

    displayManager = { 
      gdm = enabled {};
      defaultSession = "none+xmonad"; # nodesktopenv + xmonad
      autoLogin = enabled {
        user = "alice";
      };
    };
  };
})

(homeConfiguration "nixos" {
  home.file.".config/chadwm".source = pkgs.callPackage (import ./recompile.nix) {};
})

(with pkgs; homePackages "nixos" [
  # Dash TODO: rewrite these in nushell
  # Needed for small scripts like dwmbar, startup etc.
  dash

  # chadwm: imlib2
  imlib2

  # chadwm: X compositor: TODO: maybe look for a better option
  picom-jonaburg

  # chadwm: Image viewer + wallpaper setter: NOTE: Minimalist + Solid
  feh

  # chadwm: Selection Menu: TODO: switch to dmenu (<3 suckless)
  rofi

  # chadwm: acpi
  acpi

  # chadwm: build tool: TODO: move these buildInputs to `compile.nix`
  gnumake
])
