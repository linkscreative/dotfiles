if [[ -z $DISPLAY ]] && ! [[ -e /tmp/.X11-unix/X0 ]] && (( EUID )) && [ "$(terminal)" = "/dev/tty1" ]; then
  if [[ -x /usr/bin/vlock ]]; then
    exec nohup startx > .xlog & vlock
  else
    [[ -x /usr/bin/startx ]] && exec startx
  fi
fi

# Skip all this for non-interactive shells
[[ -z "$PS1" ]] && return


PS1=$'%{\e[0;32m%}%T %f%n%{\e[1;35m%}@%{\e[0;31m%}%m%{\e[1;37m%}:%{\e[1;32m%}%~ %{\e[1;30m%}%# %{\e[00m%}'
# Set less options
if [[ -x $(which less) ]]
then
    export PAGER="less"
    export LESS="--ignore-case --LONG-PROMPT --QUIET --chop-long-lines -Sm --RAW-CONTROL-CHARS --quit-if-one-screen --no-init"
    if [[ -x $(which lesspipe.sh) ]]
    then
	LESSOPEN="| lesspipe.sh %s"
	export LESSOPEN
    fi
fi

export EDITOR="vim"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR

# Zsh settings for history
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd.."
export HISTSIZE=25000
export HISTFILE=~/.zsh_history
export SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

setopt nobeep
setopt pushdminus
setopt autopushd
setopt extendedglob
setopt PUSHD_IGNORE_DUPS

# Say how long a command took, if it took more than 30 seconds
export REPORTTIME=30

# Zsh spelling correction options
setopt CORRECT
#setopt DVORAK

# Background processes aren't killed on exit of shell
setopt AUTO_CONTINUE


# Don’t nice background processes
setopt NO_BG_NICE

# Watch other user login/out
watch=notme
export LOGCHECK=60

# Enable color support of ls
if [[ "$TERM" != "dumb" ]]; then
    if [[ -x `which dircolors` ]]; then
	eval `dircolors -b`
	alias 'ls=ls --color=auto'
    fi
fi

# Short command aliases
alias 'ls=ls --group-directories-first --color'
alias 'l=ls -dF'
alias 'la=ls -Alh'
alias 'll=ls -lh'
alias 'lq=ls -Q'
alias 'lr=ls -R'
alias 'lrs=ls -lrS'
alias 'lrt=ls -lrt'
alias 'lrta=ls -lrtA'
alias 'j=jobs -l'
alias 'kw=kwrite'
alias 'tf=tail -f'
alias 'grep=grep --colour'
alias 'e=emacs -nw --quick'
alias 'vnice=nice -n 20 ionice -c 3'
alias 'get_iplayer=get_iplayer --nopurge'
alias "tree=tree -A -I 'CVS|*~'"


alias 'tm=tmux att -t0'
alias 'packer=packer --noedit'
# For convenience
alias 'mkdir=mkdir -p'
alias 'dus=du -ms * | sort -n'

# Typing errors...
alias 'cd..=cd ..'

# Running 'b.ps' runs 'q b.ps'
alias -s ps=q
alias -s html=q

# PDF viewer (just type 'file.pdf')
if [[ -x `which kpdf` ]]; then
    alias -s 'pdf=kfmclient exec'
else
    if [[ -x `which gpdf` ]]; then
	alias -s 'pdf=gpdf'
    else
	if [[ -x `which evince` ]]; then
	    alias -s 'pdf=evince'
	fi
    fi
fi

# Global aliases (expand whatever their position)
#  e.g. find . E L
alias -g L='| less'
alias -g H='| head'
alias -g S='| sort'
alias -g T='| tail'
alias -g N='> /dev/null'
alias -g E='2> /dev/null'
alias -g SPRUNGE='| curl -F "sprunge=<-" http://sprunge.us'

# Automatically background processes (no output to terminal etc)
alias 'z=echo $RANDOM > /dev/null; zz'
zz () {
    echo $*
    $* &> "/tmp/z-$1-$RANDOM" &!
}

# Quick find
f() {
    echo "find . -iname \"*$1*\""
    find . -iname "*$1*"
}

# When directory is changed set xterm title to host:dir
chpwd() {
    [[ -t 1 ]] || return
    case $TERM in
	sun-cmd) print -Pn "\e]l%~\e\\";;
        *xterm*|rxvt|(dt|k|E)term) print -Pn "\e]2;%m:%~\a";;
    esac
}

# For changing the umask automatically
chpwd () {
    case $PWD in
        $HOME/[Dd]ocuments*)
            if [[ $(umask) -ne 077 ]]; then
                umask 0077
                echo -e "\033[01;32mumask: private \033[m"
            fi;;
        */[Ww]eb*)
            if [[ $(umask) -ne 072 ]]; then
                umask 0072
                echo -e "\033[01;33mumask: other readable \033[m"
            fi;;
        /vol/nothing)
            if [[ $(umask) -ne 002 ]]; then
                umask 0002
                echo -e "\033[01;35mumask: group writable \033[m"
            fi;;
        *)
            if [[ $(umask) -ne 022 ]]; then
                umask 0022
                echo -e "\033[01;31mumask: world readable \033[m"
            fi;;
    esac
}
cd . &> /dev/null

# MySQL prompt
export MYSQL_PS1="\R:\m:\s \h> "

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _match
zstyle ':completion:*' completions 0
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' glob 0
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '+m:{a-z}={A-Z} r:|[._-]=** r:|=**' '+m:{a-z}={A-Z} r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 1 numeric
zstyle ':completion:*' substitute 0
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

zstyle -d users
#zstyle ':completion:*:*:*:users' menu yes select
zstyle ':completion:*:*:*:users' ignored-patterns \
    adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
    named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
    rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs backup  bind  \
    dictd  gnats  identd  irc  man  messagebus  postfix  proxy  sys  www-data \
    avahi Debian-exim hplip list cupsys haldaemon ntpd proftpd statd

[[ -f $HOME/.hosts* ]] && zstyle ':completion:*' hosts $( cat $HOME/.hosts* )

zstyle ':completion:*:cd:*' ignored-patterns '(*/)#lost+found' '(*/)#CVS'
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'

zstyle ':completion:*:(rm|kill|diff):*' ignore-line yes
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

zstyle ':completion:*:*:rmdir:*' file-sort time

zstyle ':completion:*' local matt.blissett.me.uk /web/matt.blissett.me.uk

# CD to never select parent directory
zstyle ':completion:*:cd:*' ignore-parents parent pwd


bindkey -v
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward

# Quick ../../..
rationalise-dot() {
    if [[ $LBUFFER = *.. ]]; then
	LBUFFER+=/..
    else
	LBUFFER+=.
    fi
}
zle -N rationalise-dot
bindkey . rationalise-dot

autoload zsh/sched

# Copys word from earlier in the current command line
# or previous line if it was chosen with ^[. etc
autoload copy-earlier-word
zle -N copy-earlier-word
bindkey '^[,' copy-earlier-word

# Cycle between positions for ambigous completions
autoload cycle-completion-positions
zle -N cycle-completion-positions
bindkey '^[z' cycle-completion-positions

# Increment integer argument
autoload incarg
zle -N incarg
bindkey '^X+' incarg

# Write globbed files into command line
autoload insert-files
zle -N insert-files
bindkey '^Xf' insert-files


# xargs but zargs
autoload -U zargs

# Calculator
autoload zcalc

# Line editor
autoload zed

# Renaming with globbing
autoload zmv

# Various reminders of things I forget...
# (Mostly useful features that I forget to use)
# vared
# =ls turns to /bin/ls
# =(ls) turns to filename (which contains output of ls)
# <(ls) turns to named pipe
# ^X* expand word
# ^[^_ copy prev word
# ^[A accept and hold
# echo $name:r not-extension
# echo $name:e extension
# echo $xx:l lowercase
# echo $name:s/foo/bar/

# Quote current line: M-'
# Quote region: M-"

# Up-case-word: M-u
# Down-case-word: M-l
# Capitilise word: M-c

# kill-region

# expand word: ^X*
# accept-and-hold: M-a
# accept-line-and-down-history: ^O
# execute-named-cmd: M-x
# push-line: ^Q
# run-help: M-h
# spelling correction: M-s

# echo ${^~path}/*mous*

# Add host/domain specific zshrc
if [ -f $HOME/.zshrc-$HOST ]
then
    . $HOME/.zshrc-$HOST
fi

if [ -f $HOME/.zshrc-$(hostname -d) ]
then
    . $HOME/.zshrc-$(hostname -d)
fi

[[ -f $HOME/.zshenv ]] && source $HOME/.zshenv
[[ -f $HOME/.zshlocal ]] && source $HOME/.zshlocal
source $HOME/.zsh/syntax-highlighting/zsh-syntax-highlighting.zsh
[[ -f $HOME/.zsh/git/functions/zgitinit ]] && source $HOME/.zsh/git/functions/zgitinit

export PATH=/var/lib/gems/1.8/bin:$PATH
export PATH=/opt/android-sdk/platform-tools:$PATH

autoload zkbd
function zkbd_file() {
    [[ -f ~/.zkbd/${TERM}-${VENDOR}-${OSTYPE} ]] && printf '%s' ~/".zkbd/${TERM}-${VENDOR}-${OSTYPE}" && return 0
    [[ -f ~/.zkbd/${TERM}-${DISPLAY}          ]] && printf '%s' ~/".zkbd/${TERM}-${DISPLAY}"          && return 0
    return 1
}

[[ ! -d ~/.zkbd ]] && mkdir ~/.zkbd
keyfile=$(zkbd_file)
ret=$?
if [[ ${ret} -ne 0 ]]; then
    printf 'You do not have a zkbd profile for this terminal type. Type zkbd to set one up.\n'
fi
if [[ ${ret} -eq 0 ]] ; then
    source "${keyfile}"
else
    printf 'Failed to setup keys using zkbd.\n'
fi
unfunction zkbd_file; unset keyfile ret

# setup key accordingly
[[ -n "${key[Home]}"        ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"         ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"      ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"      ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"          ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"        ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"        ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"       ]]  && bindkey  "${key[Right]}"   forward-char
[[ -n "${key[CtrlLeft]}"    ]]  && bindkey  "${key[CtrlLeft]}"    backward-word
[[ -n "${key[CtrlRight]}"   ]]  && bindkey  "${key[CtrlRight]}"   forward-word

alias 'sd=svn diff --diff-cmd /usr/bin/svn-diff-meld'
alias 'git-sync=git pull origin master && git push origin master'


activate () {
    [[ -x deactivate ]] && deactivate
    cd ~/dev/$1/$2
    source bin/activate
    cd $2
}

source $HOME/.zsh/history-substring-search/zsh-history-substring-search.zsh

# Systemd stuff
if [[ ! -e /sys/fs/cgroup/systemd ]]; then  # not using systemd
  start() {
    sudo rc.d start $1
  }

  restart() {
    sudo rc.d restart $1
  }

  stop() {
    sudo rc.d stop $1
  }
else
  start() {
    sudo systemctl start $1.service
  }

  restart() {
    sudo systemctl restart $1.service
  }

  stop() {
    sudo systemctl stop $1.service
  }

  enable() {
    sudo systemctl enable $1.service
  }

  status() {
    sudo systemctl status $1.service
  }

  disable() {
    sudo systemctl disable $1.service
  }
fi
#[[ -x /usr/bin/archey ]] && /usr/bin/archey
#
#Disable globbing for some things
setopt glob
alias aria2c='noglob aria2c'
alias curl='noglob curl'
alias wget='noglob wget'

alias sudo='sudo '

export WORKON_HOME=~/.virtualenvs
[[ -f /usr/bin/virtualenvwrapper.sh ]] && source /usr/bin/virtualenvwrapper.sh
alias mkvirtualenv='mkvirtualenv -p python2.7'
