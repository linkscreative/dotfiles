#!/bin/zsh
#syndaemon -t -k -i 1 -d &
xsetroot -cursor_name left_ptr
setxkbmap -layout gb
export BROWSER=google-chrome

[[ -x /usr/bin/nitrogen ]] && nitrogen --set-zoom-fill ~/.wallpaper &
[[ -x /usr/bin/xmobar ]] && xmobar &
[[ -x /usr/bin/start-pulseaudio-x11 ]] && start-pulseaudio-x11 &
[[ -x /opt/dropbox/dropboxd ]] && /opt/dropbox/dropboxd &
xcompmgr -c &
xmonad

