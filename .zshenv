export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"

export PATH=~/bin:$PATH
export KC=$(which keychain)
[[ -x $KC ]] && eval `keychain --eval --agents gpg,ssh --nogui -Q -q ~/.ssh/id_rsa`
