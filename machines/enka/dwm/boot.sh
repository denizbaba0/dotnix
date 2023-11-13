#!/bin/bash

wallpaper = "~/Pictures/wallpapers/stairs.jpg"

xrdb merge ~/.Xresources &
# xbacklight -set 10 & # TODO: not working (idk if essential)
xset r rate 200 50 &
~/.config/chadwm/scripts/bar.sh &
feh --bg-fill $wallpaper

# NOTE: picom autostarts in the way It's declared in `default.nix`

while type dwm >/dev/null; do dwm && continue || break; done
