#!/bin/zsh

export BASE=$(dirname $0)
BASE=${BASE:a}
cd $BASE && git pull origin master

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
    new=$HOME/$1
    newdir=${new:h}
    [[ -d $newdir ]] || mkdir -p $newdir
    [[ -h $new ]] && unlink $new
    [[ -f $new ]] && rm $new
    ln -s $real $new && echo "linked $new -> $real"
}

[[ -f $BASE/../.tmux.hotkey ]] || cp $BASE/.tmux.hotkey.sample $BASE/../.tmux.hotkey

git clone git://github.com/zsh-users/zsh-history-substring-search.git $BASE/.zsh/history-substring-search 1&>/dev/null || (cd $BASE/.zsh/history-substring-search && git pull origin master)

git clone git://github.com/zsh-users/zsh-syntax-highlighting.git $BASE/.zsh/syntax-highlighting 1&>/dev/null || (cd $BASE/.zsh/syntax-highlighting && git pull origin master)

for x in $manifest
do
    relink $x
done

source ~/.zshrc
