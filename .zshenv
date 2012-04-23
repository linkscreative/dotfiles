export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"

export PATH=~/bin:$PATH
export PATH=~/.gem/ruby/1.9.1/bin:$PATH
export KC=$(which keychain)

[[ -n "$DISPLAY" ]] && export BROWSER=chromium
[[ -x $KC ]] && eval $(keychain --eval --agents gpg,ssh --nogui -Q -q ~/.ssh/id_rsa --noask) && alias 'u=eval $(keychain --eval --agents gpg,ssh --nogui -Q -q ~/.ssh/id_rsa)'
