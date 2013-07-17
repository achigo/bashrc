# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes
##############################################################################################
# Achigo Force_Color_Prompt Config 2013/02/26
##############################################################################################

#ip=`/bin/hostname -I`
ip=`/sbin/ifconfig eth0 | /usr/bin/perl -ne 'if ( m/^\s*inet (?:addr:)?([\d.]+).*?cast/ ) { print qq($1\n); exit 0; }'`

#ESC="\033["
DEFAULT="\[\e[0m\]"    #default
BDH="\[\e[0;1m\]"       #bold and highlight
BGC="\[\e[0;4m\]"       #background
FGC="\[\e[0;3m\]"       #foreground           
FBLACK="\[\e[1;30m\]"   #black foreground   BBLACK="\[\e[0;40m\]"   #black background
FRED="\[\e[1;31m\]"     #red foreground     BRED="\[\e[0;41m\]"     #red background
FGREEN="\[\e[0;32m\]"   #green foreground   BGREEN="\[\e[0;42m\]"   #green background
FYELLOW="\[\e[1;33m\]"  #yellow foreground  BYELLOW="\[\e[0;43m\]"  #yellow background
FBLUE="\[\e[1;34m\]"    #blue foreground    BBLUE="\[\e[0;44m\]"    #blue background 
FPINK="\[\e[1;35m\]"    #pink foreground    BPINK="\[\e[0;45m\]"    #pink background
FCYAN="\[\e[1;36m\]"    #cyan foreground    BCYAN="\[\e[0;46m\]"    #cyan background
FWHITE="\[\e[1;37m\]"   #white foreground   BWHITE="\[\e[0;47m\]"   #white background

#SETTING="${FRED}[${FYELLOW}\w${FRED}]\n${FGREEN}\u${FRED}@${FBLUE}\h${FPINK}[${FPINK}\d]"
#SETTING="${FRED}[${FYELLOW}\w${FRED}]\n${FGREEN}\u${FRED}@${FBLUE}\h${FCYAN}[${FCYAN}\d]${FPINK}[${FPINK}\t]"
#SETTING="${FRED}[${FYELLOW}\w${FRED}]\n${FGREEN}\u${FRED}@${FBLUE}\h${FPINK}[${FPINK}\t]"
SETTING="${FGREEN}\u${FRED}@${FCYAN}\h${FRED}[${FWHITE}$ip${FRED}]${FRED}[${FPINK}\D{%Y-%m-%d} \t${FRED}][${FYELLOW}\w${FRED}]"

case `id -u` in
        0) PS1="${SETTING}${FRED}\n# ${MyIP} ${DEFAILT}"
        ;;
        *) PS1="${SETTING}${FYELLOW}\n$ ${DEFAULT}"
        ;;
esac

unset DEFAULT BDH BGC FGC 
unset FBLACK FRED FGREEN FYELLOW FBLUE FPINK FCYAN FWHITE
unset BBLACK BRED BGREEN BYELLOW BBLUE BPINK BCYAN BWHITE
unset SETTING MyIP

#export SETTING

##############################################################################################
# END
##############################################################################################

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1=$PS1
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias gg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# for History Tab
alias h='history 25'
case "$-" in
    *i*)
        bind '"\x1b\x5b\x41":history-search-backward'
        bind '"\x1b\x5b\x42":history-search-forward'
        ;;
esac
HISTFILESIZE=1000000000
HISTSIZE=1000000
HISTCONTROL=ignoredups
HISTTIMEFORMAT="%F %T ) "

# for P4
#export P4PORT=10.9.32.71:1668
#export P4CLIENT=U18_WenChih_29_3
#export P4USER=HTCTAIPEI\\achigo_liu
#export P4PASSWD=eK2sUrY&

#export PATH=$PATH:/home/achigo/arm-eabi-4.4.0/bin;
#export ARCH=arm
#export LC_ALL=zh_TW.Big5
#export LANG=zh_TW.Big5

export PATH=$PATH:~/bin/arm-eabi-4.6/bin

