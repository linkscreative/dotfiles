upgrade: pull submodules linkfiles

pull:
	git pull origin master

linkfiles:
	zsh relink

submodules:
	git submodule init; git submodule update
	git submodule foreach git pull origin master;
