#!/bin/zsh
export BASE=$(dirname $0)

manifest=(
    .gitconfig
    .tmux.conf
    .zshenv
    .zshrc
    .vimrc
    .zsh_ssh_aliases
    .ncmpcpp/config
    .ssh/config
)

relink () {
    new=$BASE/../$1
    newdir=${new:h}
    [[ -d $newdir ]] || mkdir -p $newdir
    unlink $new || rm $new
    ln -s $BASE/$1 $new && echo "linked $1 to $new"
}
[[ -f $BASE/../.tmux.hotkey ]] || cp $BASE/.tmux.hotkey.sample $BASE/../.tmux.hotkey
for x in $manifest
do
    relink $x
done
