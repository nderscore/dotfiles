These are my files with dots. They are probably not very portable.

# Features

* Use dark mode or dark themes everywhere where its supported
* Use Monokai color scheme for all the things
* (Nearly) Identical i3/sway configurations built from [shared configs](./.config/tiling/config.d/)
* [Random tiled wallpapers](./.scripts/random-wallpaper.sh)
* Custom keyboard layout: Mac-style keyboard layout with right control key is rebound to Mod3 for extra keybinds
* While mouse-and-keyboard games are running (via [gamemode script trigger](./.scripts/gamemode-start.sh))...
  * [Swaps meta and alt keys](./.scripts/swap-win-alt.sh) back to non-mac layout (frees up meta key position for binding to game controls)
  * [Adjust screen layout](./.screenlayout/gaming.sh) to prevent accidentally mousing into the secondary monitor
  * If a Dualshock4 game controller is connected over bluetooth when the game starts, skip all adjustments
* Custom status bar elements:
  * [Mouse battery/charging status](./.scripts/mouse-battery.mjs)
  * [Weather indicator](./.scripts/weather.mjs)
  * [GPU utilization](./.scripts/gpu-stats.sh)

# Dependencies

This list is probably missing something...

## Software

### Shared

* zsh - shell
* dunst - notifications
* kitty - terminal emu
* rofi - dmenu + window switching
* rofimoji - emoji picker
* gamemode - gaming optimizations, launch/exit scripting

### Sway

* Sway - tiling wayland compositor / window manager
* waybar - status bar
* grim / slurp - screenshots

### i3

* i3-gaps - tiling window manager
* picom - compositor
* polybar - status bar
* scrot - screenshots
* feh - image viewer / wallpaper

## Fonts

* Dank Mono
* noto-fonts-emoji-blob
