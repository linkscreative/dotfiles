#!/bin/zsh
export LANG=en_GB.UTF-8
xsetroot -cursor_name left_ptr
setxkbmap -layout gb
export BROWSER=chromium

xrdb -merge ~/.Xresources
[[ -x /usr/bin/nitrogen ]] && nitrogen --set-zoom-fill ~/.wallpaper &
[[ -x /usr/bin/start-pulseaudio-x11 ]] && start-pulseaudio-x11 &
[[ -x /usr/bin/urxvtd ]] && urxvtd -o -f -q
[[ -x /opt/dropbox/dropboxd ]] && /opt/dropbox/dropboxd &

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

xset +fp /usr/share/fonts/local
case $1 in
    xmonad)
        [[ -x /usr/bin/xmobar ]] && xmobar &
        xcompmgr -c -C -r 10 -l -15 -t -15 -o .5 &
        xmonad
        ;;
    *)
        exec i3
        ;;
esac


