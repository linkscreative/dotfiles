#!/bin/zsh
#syndaemon -t -k -i 1 -d &
xsetroot -cursor_name left_ptr
nitrogen --set-zoom-fill ~/.wallpaper
setxkbmap -layout gb
export BROWSER=google-chrome
xmobar &
#!/bin/bash
xrdb -merge .Xresources

if [ -x /opt/dropbox/dropboxd ] ; then
    /opt/dropbox/dropboxd &
fi

xmonad

