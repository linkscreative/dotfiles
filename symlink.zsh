#!/bin/zsh
export BASE=$(dirname $0)

manifest=(
    .gitconfig
    .tmux.conf
    .zshenv
    .zshrc
    .vimrc
    .ncmpcpp/config
    .zsh
)

relink () {
    real=$BASE/$1
    real=${real:a}
    new=$BASE/../$1
    new=${new:a}
    newdir=${new:h}
    [[ -d $newdir ]] || mkdir -p $newdir
    [[ -f $new ]] && ( unlink $new || rm $new )
    ln -s $real $new && echo "linked $new -> $real"
}
[[ -f $BASE/../.tmux.hotkey ]] || cp $BASE/.tmux.hotkey.sample $BASE/../.tmux.hotkey
for x in $manifest
do
    relink $x
done
