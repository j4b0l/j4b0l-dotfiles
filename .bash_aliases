# Bash prompt colors
# Source: https://wiki.archlinux.org/index.php/Color_Bash_Prompt
# Modifications:
# - changed cursor position handling to comply with terminal emulators and line wrapping

export EDITOR=vim

# Reset
Color_Off='\[\033[0m\]'       # Text Reset
# Regular Colors
Black='\[\033[0;30m\]'        # Black
Red='\[\033[0;31m\]'          # Red
Green='\[\033[0;32m\]'        # Green
Yellow='\[\033[0;33m\]'       # Yellow
Blue='\[\033[0;34m\]'         # Blue
Purple='\[\033[0;35m\]'       # Purple
Cyan='\[\033[0;36m\]'         # Cyan
White='\[\033[0;37m\]'        # White
# Bold
BBlack='\[\033[1;30m\]'       # Black
BRed='\[\033[1;31m\]'         # Red
BGreen='\[\033[1;32m\]'       # Green
BYellow='\[\033[1;33m\]'      # Yellow
BBlue='\[\033[1;34m\]'        # Blue
BPurple='\[\033[1;35m\]'      # Purple
BCyan='\[\033[1;36m\]'        # Cyan
BWhite='\[\033[1;37m\]'       # White
# Underline
UBlack='\[\033[4;30m\]'       # Black
URed='\[\033[4;31m\]'         # Red
UGreen='\[\033[4;32m\]'       # Green
UYellow='\[\033[4;33m\]'      # Yellow
UBlue='\[\033[4;34m\]'        # Blue
UPurple='\[\033[4;35m\]'      # Purple
UCyan='\[\033[4;36m\]'        # Cyan
UWhite='\[\033[4;37m\]'       # White
# Background
On_Black='\[\033[40m\]'       # Black
On_Red='\[\033[41m\]'         # Red
On_Green='\[\033[42m\]'       # Green
On_Yellow='\[\033[43m\]'      # Yellow
On_Blue='\[\033[44m\]'        # Blue
On_Purple='\[\033[45m\]'      # Purple
On_Cyan='\[\033[46m\]'        # Cyan
On_White='\[\033[47m\]'       # White
# High Intensity
IBlack='\[\033[0;90m\]'       # Black
IRed='\[\033[0;91m\]'         # Red
IGreen='\[\033[0;92m\]'       # Green
IYellow='\[\033[0;93m\]'      # Yellow
IBlue='\[\033[0;94m\]'        # Blue
IPurple='\[\033[0;95m\]'      # Purple
ICyan='\[\033[0;96m\]'        # Cyan
IWhite='\[\033[0;97m\]'       # White
# Bold High Intensity
BIBlack='\[\033[1;90m\]'      # Black
BIRed='\[\033[1;91m\]'        # Red
BIGreen='\[\033[1;92m\]'      # Green
BIYellow='\[\033[1;93m\]'     # Yellow
BIBlue='\[\033[1;94m\]'       # Blue
BIPurple='\[\033[1;95m\]'     # Purple
BICyan='\[\033[1;96m\]'       # Cyan
BIWhite='\[\033[1;97m\]'      # White

# High Intensity backgrounds
On_IBlack='\[\033[0;100m\]'   # Black
On_IRed='\[\033[0;101m\]'     # Red
On_IGreen='\[\033[0;102m\]'   # Green
On_IYellow='\[\033[0;103m\]'  # Yellow
On_IBlue='\[\033[0;104m\]'    # Blue
On_IPurple='\[\033[0;105m\]'  # Purple
On_ICyan='\[\033[0;106m\]'    # Cyan
On_IWhite='\[\033[0;107m\]'   # White


# Custom prompt
PS1="${BBlue}\D{%Y%m%d_%H%M} ${BRed}\u${BGreen}@\h${BBlue} \w \$${Color_Off} "

# To overcome some common mistakes and terminal pitfalls
alias sl="ls"
alias mc='mc -s'

# Stage all of modified files in git
# use when you think 'OMG, it's finally done and I can commit it'
function omg-done() {
	git status |grep modified|awk '{print $2}'|xargs git add
}

# DOGE GIT - just for fun ;)
# usage - just have fun like
# much commit
# so push
# wow
alias much='git'
alias so='git'
alias such='git'
alias very='git'
alias wow='git status'

# repeat last command with sudo
alias orly='sudo $(history -p \!\!)'

function j4-find() {
	if [ -z "$1" ]; then
		return
	else
		if [ -z "$2" ]; then
			find . -name "*$1*"
		else
			find $2 -name "*$1*"
		fi
	fi
}

function j4-git-lasttag() {
	git describe --abbrev=0 --tags HEAD
}

function j4-git-pullall() {
	if [ -z "$1" ]; then
		GITDIR=${HOME}/git
	else
		GITDIR=$1
	fi
	find ${GITDIR} -maxdepth 2 -type d -name .git|sed 's/\.git//g'|while read repo; do
		pushd $repo
		git pull --rebase
		popd
	done
}

function j4-docker-watch() {
	if [ -z "$1" ]; then
		WIDTH=210
	else
		WIDTH=$1
	fi
	watch "docker ps -a|cut -b -${WIDTH}"
}

function mkdir-dated() {
    DATE=`date +%Y%m%d`
    if [ -n "$1" ]; then
        mkdir ${DATE}_$1
    else
        mkdir ${DATE}
    fi
}

function mknotes-dated() {
    DATE=`date +%Y%m%d`
    if [ -n "$1" ]; then
        vim ${DATE}_$1.txt
    else
        vim ${DATE}.txt
    fi
}

# For some company-confidential mumbo-jumbo
if [ -f ~/.bash_aliases_private ]; then
    . ~/.bash_aliases_private
fi

