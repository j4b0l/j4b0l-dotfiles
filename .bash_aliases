# Bash prompt colors
# Source: https://wiki.archlinux.org/index.php/Color_Bash_Prompt
# Modifications:
# - changed cursor position handling to comply with terminal emulators and line wrapping

export EDITOR=vim

# current git repository status, to be displayed in command prompt
# if the branch is in line with origin - shows origin/branch
# if the branch diverged from origin shows branch+${local_commits_count}-${remote_commits_count}
# for current git tree status additional characters are displayed:
# * if trached files were modified but not committed or staged
# ^ if there are changes staged for commit
# ! if there are new, untracked files
__parse_git_branch() {
    BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    REVLIST=$(git rev-list --count --left-right ${BRANCH}...origin/${BRANCH} 2> /dev/null|sed 's/\([0-9]\+\)\t\([0-9]\+\)/+\1-\2/g'|sed 's/+0-0//g')
    DIRTY=$( [[ -n "$(git status --porcelain 2>/dev/null | grep '^.M')" ]] && echo '*')
    CACHED=$( [[ -n "$(git status --porcelain 2>/dev/null | grep '^M')" ]] && echo '^')
    UNTRACKED=$( [[ -n "$(git status --porcelain 2>/dev/null | grep '^??')" ]] && echo '!')
    if [ -n "$BRANCH" ]; then
        if [ -n "$REVLIST" ]; then
            GITSTAT=" (${BRANCH}${REVLIST}${DIRTY}${CACHED}${UNTRACKED})"
        else
            GITSTAT=" (origin/${BRANCH}${DIRTY}${CACHED}${UNTRACKED})"
        fi
    fi
    echo "$GITSTAT"
}

# Quite a lot of companies require to have a histname compliant with global
# hostname policy. I like my own personal touch though... This way I can have
# both. It's the matter of setting 'pretty' hostname, if it's applicable to
# your host you can have company-required hostname of INV-LAPTOP-123456-WHATEVA
# and your own personal name displayed in prompt.
__parse_hostname() {
    HNAME=$(awk -F= '/PRETTY/ {print $2}' /etc/machine-info)
    if [ -z "$HNAME" ]; then
        hostname
    else
        echo $HNAME
    fi
}

# Reset
Color_Off='\033[0m'       # Text Reset
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White
# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White
# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White
# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White

function teleprompter() {
    # Reset
    local Prompt_Color_Off='\[\033[0m\]'       # Text Reset
    # Regular Colors
    local Prompt_Black='\[\033[0;30m\]'        # Black
    local Prompt_Red='\[\033[0;31m\]'          # Red
    local Prompt_Green='\[\033[0;32m\]'        # Green
    local Prompt_Yellow='\[\033[0;33m\]'       # Yellow
    local Prompt_Blue='\[\033[0;34m\]'         # Blue
    local Prompt_Purple='\[\033[0;35m\]'       # Purple
    local Prompt_Cyan='\[\033[0;36m\]'         # Cyan
    local Prompt_White='\[\033[0;37m\]'        # White
    # Bold
    local Prompt_BBlack='\[\033[1;30m\]'       # Black
    local Prompt_BRed='\[\033[1;31m\]'         # Red
    local Prompt_BGreen='\[\033[1;32m\]'       # Green
    local Prompt_BYellow='\[\033[1;33m\]'      # Yellow
    local Prompt_BBlue='\[\033[1;34m\]'        # Blue
    local Prompt_BPurple='\[\033[1;35m\]'      # Purple
    local Prompt_BCyan='\[\033[1;36m\]'        # Cyan
    local Prompt_BWhite='\[\033[1;37m\]'       # White
    # Underline
    local Prompt_UBlack='\[\033[4;30m\]'       # Black
    local Prompt_URed='\[\033[4;31m\]'         # Red
    local Prompt_UGreen='\[\033[4;32m\]'       # Green
    local Prompt_UYellow='\[\033[4;33m\]'      # Yellow
    local Prompt_UBlue='\[\033[4;34m\]'        # Blue
    local Prompt_UPurple='\[\033[4;35m\]'      # Purple
    local Prompt_UCyan='\[\033[4;36m\]'        # Cyan
    local Prompt_UWhite='\[\033[4;37m\]'       # White
    # Background
    local Prompt_On_Black='\[\033[40m\]'       # Black
    local Prompt_On_Red='\[\033[41m\]'         # Red
    local Prompt_On_Green='\[\033[42m\]'       # Green
    local Prompt_On_Yellow='\[\033[43m\]'      # Yellow
    local Prompt_On_Blue='\[\033[44m\]'        # Blue
    local Prompt_On_Purple='\[\033[45m\]'      # Purple
    local Prompt_On_Cyan='\[\033[46m\]'        # Cyan
    local Prompt_On_White='\[\033[47m\]'       # White
    # High Intensity
    local Prompt_IBlack='\[\033[0;90m\]'       # Black
    local Prompt_IRed='\[\033[0;91m\]'         # Red
    local Prompt_IGreen='\[\033[0;92m\]'       # Green
    local Prompt_IYellow='\[\033[0;93m\]'      # Yellow
    local Prompt_IBlue='\[\033[0;94m\]'        # Blue
    local Prompt_IPurple='\[\033[0;95m\]'      # Purple
    local Prompt_ICyan='\[\033[0;96m\]'        # Cyan
    local Prompt_IWhite='\[\033[0;97m\]'       # White
    # Bold High Intensity
    local Prompt_BIBlack='\[\033[1;90m\]'      # Black
    local Prompt_BIRed='\[\033[1;91m\]'        # Red
    local Prompt_BIGreen='\[\033[1;92m\]'      # Green
    local Prompt_BIYellow='\[\033[1;93m\]'     # Yellow
    local Prompt_BIBlue='\[\033[1;94m\]'       # Blue
    local Prompt_BIPurple='\[\033[1;95m\]'     # Purple
    local Prompt_BICyan='\[\033[1;96m\]'       # Cyan
    local Prompt_BIWhite='\[\033[1;97m\]'      # White

    # High Intensity backgrounds
    local Prompt_On_IBlack='\[\033[0;100m\]'   # Black
    local Prompt_On_IRed='\[\033[0;101m\]'     # Red
    local Prompt_On_IGreen='\[\033[0;102m\]'   # Green
    local Prompt_On_IYellow='\[\033[0;103m\]'  # Yellow
    local Prompt_On_IBlue='\[\033[0;104m\]'    # Blue
    local Prompt_On_IPurple='\[\033[0;105m\]'  # Purple
    local Prompt_On_ICyan='\[\033[0;106m\]'    # Cyan
    local Prompt_On_IWhite='\[\033[0;107m\]'   # White
    PS1="${Prompt_BBlue}\D{%Y%m%d_%H%M} ${Prompt_BRed}\u${Prompt_BGreen}@$(__parse_hostname)${Prompt_BBlue} \w${Prompt_IWhite}\$(__parse_git_branch) ${Prompt_BBlue}\$${Prompt_Color_Off} "
}
# Custom prompt
teleprompter

J4_REAL_ALIASES=`readlink -f ~/.bash_aliases`
J4_DOTFILES_ROOT=`dirname $J4_REAL_ALIASES`
J4_BINPATH="${J4_DOTFILES_ROOT}/bin"
if [ -d $J4_BINPATH ]; then
    export PATH="${J4_BINPATH}:${PATH}"
fi

if [ -d ~/bin ]; then
    export PATH="~/bin:${PATH}"
fi

# To overcome some common mistakes and terminal pitfalls
alias sl="ls"
alias mc='mc -s'
alias grpe='grep'
alias lelss='less'

# Stage all of modified files in git
# use when you think 'OMG, it's finally done and I can commit it'
function omg-done() {
    local GIT_TOP=$(git rev-parse --show-toplevel|sed 's/\//\\\//g')
	git diff --name-only|sed "s/^/${GIT_TOP}\//g"|xargs git add
}

# See list of people responsible for the code in repository
function who-did-that() {
    git ls-tree -r -z --name-only HEAD -- . | xargs -0 -n1 git blame --line-porcelain HEAD |grep  "^author "|sort|uniq -c|sort -nr
}

function who-worked-on-that() {
    git ls-tree -r -z --name-only HEAD -- . | xargs -0 -n1 git blame --line-porcelain HEAD |grep  "^author "|sort|uniq -c|sort -nr|while read line; do
        author=`echo $line | awk -F' author ' '{print $2}'`
        count=`echo $line | awk -F' author ' '{print $1}'`
        stats=`git log --author="$author" --pretty=tformat: --numstat | gawk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "%s = +%s -%s\n", loc, add, subs }' -`
        echo -e "$author\t$stats\n"
    done
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
alias doco='docker-compose'

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
        cd ${DATE}_$1
    else
        mkdir ${DATE}
        cd ${DATE}
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

function journal-dated() {
    DATE=`date +%Y%m%d`
    if [ -n "$1" ]; then
        TARGET=${DATE}_$1.txt
    else
        TARGET=${DATE}.txt
    fi
    if [ -f "00000000.txt" -a ! -f $TARGET ]; then
        cp 00000000.txt $TARGET
    fi
    vim $TARGET
}

function j4-realias() {
    . ~/.bash_aliases
}

# See function void sv_histsize in:
# http://bashcookbook.com/bashinfo/source/bash-3.1/variables.c
export HISTSIZE=""
export HISTFILESIZE=-1

function short-prompt() {
    export PS1="$ "
}

function EOD-status() {
    find $HOME -name .git -type d|sed s/\.git$//g|while read REPO_PATH; do
        pushd $REPO_PATH >/dev/null 2>/dev/null
            if git remote |grep origin >/dev/null 2>/dev/null; then
                CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`
                if [ "$CURRENT_BRANCH" != "HEAD" ]; then
                    git log --pretty=%H origin/${CURRENT_BRANCH}..${CURRENT_BRANCH}|while read $LOCAL_COMMIT; do
                        if ! git ls-remote | grep $LOCAL_COMMIT >/dev/null 2>/dev/null; then
                            echo "Commit only local in $REPO_PATH"
                        fi
                    done
                else
                    echo "$REPO_PATH is DECAPITATED"
                fi
            fi
        popd >/dev/null 2>/dev/null
    done
}

function run() {
    docker run -ti --rm --entrypoint=/bin/bash $1
}

function whatIvedone() {
    SEARCH_PATH='.'
    if [ -n '$1' ]; then
        SEARCH_PATH=$1
    fi
    find $SEARCH_PATH -name .git|sed s/..git$//g|while read line; do
        echo $line; git --no-pager -C $line log --author='Maciej Jablonski' --since yesterday
    done
}

export LESS="-R"
alias msed='perl -0777 -pe'
alias first="awk '{print \$1}'"

# For some company-confidential mumbo-jumbo
if [ -f ~/.bash_aliases_private ]; then
    . ~/.bash_aliases_private
fi

# vim: set filetype=sh:
