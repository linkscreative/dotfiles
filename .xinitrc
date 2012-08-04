#!/bin/zsh
#syndaemon -t -k -i 1 -d &
export LANG=en_GB.UTF-8
xsetroot -cursor_name left_ptr
setxkbmap -layout gb
export BROWSER=google-chrome

xrdb -merge ~/.Xresources
[[ -x /usr/bin/nitrogen ]] && nitrogen --set-zoom-fill ~/.wallpaper &
[[ -x /usr/bin/start-pulseaudio-x11 ]] && start-pulseaudio-x11 &
[[ -x /usr/bin/urxvtd ]] && urxvtd -o -f -q
[[ -x /usr/bin/xmobar ]] && xmobar &
[[ -x /opt/dropbox/dropboxd ]] && /opt/dropbox/dropboxd &
xcompmgr -c -C -r 10 -l -15 -t -15 -o .5 &
xmonad

