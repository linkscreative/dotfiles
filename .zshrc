START=$(date +%s%N | cut -b1-13)
if [[ -z $DISPLAY ]] && ! [[ -e /tmp/.X11-unix/X0 ]] && (( EUID )) && [ "$TTY" = "/dev/tty1" ]; then
  if [[ -x /usr/bin/vlock ]]; then
    exec nohup startx > .xlog & vlock
  else
    [[ -x /usr/bin/startx ]] && exec startx
  fi
fi

# # Skip all this for non-interactive shells
[[ -z "$PS1" ]] && return


PS1=$'%f%n%{\e[1;35m%}@%{\e[0;31m%}%m%{\e[1;37m%}:%{\e[1;32m%}%~ %{\e[1;30m%}%# %{\e[00m%}'

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

# Global aliases (expand whatever their position)
#  e.g. find . E L
alias -g L='| less'
alias -g H='| head'
alias -g S='| sort'
alias -g T='| tail'
alias -g N='> /dev/null'
alias -g E='2> /dev/null'
alias -g SPRUNGE='| curl -F "sprunge=<-" http://sprunge.us'


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

# Ctrl-R find
bindkey -v
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward
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

# [[ -f $HOME/.zshlocal ]] && source $HOME/.zshlocal
source $HOME/.zsh/syntax-highlighting/zsh-syntax-highlighting.zsh

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

alias 'git-sync=git pull origin master && git push origin master'

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

setopt glob
alias aria2c='noglob aria2c'
alias curl='noglob curl'
alias wget='noglob wget'

alias sudo='sudo '

export WORKON_HOME=~/.virtualenvs
[[ -f /usr/bin/virtualenvwrapper.sh ]] && source /usr/bin/virtualenvwrapper.sh
alias mkvirtualenv='mkvirtualenv -p python2.7'

unlock() {
    [[ -x $(which keychain) ]] && eval $(keychain --eval --agents gpg,ssh --nogui -Q -q ~/.ssh/id_rsa)
}
alias 'u=unlock'
unlock

#echo "END: $(expr $(date +%s%N | cut -b1-13) - $START)"
PATH=/opt/java/bin:$PATH
