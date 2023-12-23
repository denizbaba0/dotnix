#!/bin/bash
# IMPORTANT!!! NOTE: this file is no longer a startup hook! (migrated to `default.nix`)
xrdb merge ~/.Xresources &
# xbacklight -set 10 & # TODO: not working (idk if essential)
xset r rate 200 50 &
~/.config/chadwm/scripts/bar.sh &
feh --bg-fill "~/Pictures/wallpapers/stairs.jpg" &
# picom

# NOTE: picom autostarts in the way It's declared in `default.nix`

while type dwm >/dev/null; do dwm && continue || break; done
