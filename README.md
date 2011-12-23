# .files

These are my dot files, you are welcome to use them.

I have made a handly little installer/updater script that handles the symlinking, and has a manifest so you can specify which files you wish to use (I will later refactor this into a different file so you can have MANIFEST.local and override the defaults).

Included are tmux, zsh, vim and ncmpcpp and some screenshot scripts.

Some things might have personal customisations, but I'm working to move these out into overridable files.

For instance, the tmux hotkey may be different due to preference or nesting, so it will read from or create a file called ~/.tmux.hotkey that simply contains the binding for your hotkey, and won't be overwritten on updates.

Screenshot, with my Dogs colour theme:

![Screenshot with Dogs colour theme](http://files.0xf.nl/screenshots/screenshot-2011-12-23.15:36:24.png)
