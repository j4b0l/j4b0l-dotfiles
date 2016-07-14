#!/usr/bin/env bash

set -x
ROOT_DIR=$(dirname $0)

HOME_LINKS=".bash_aliases .git_aliases .vim .vimrc"

for LINK in ${HOME_LINKS}; do
    FULL_LINK="${HOME}/${LINK}"
    J4_ALIAS=$(readlink -f ${ROOT_DIR}/${LINK})
    if [ -e ${FULL_LINK} ]; then
        if [ "$(readlink -f ${FULL_LINK})" != "${J4_ALIAS}" ]; then
            mv ${FULL_LINK} ${HOME}/.j4_bak$(date +%s).bash_aliases
            ln -s ${J4_ALIAS} ${FULL_LINK}
        fi
    else
        ln -s ${J4_ALIAS} ${FULL_LINK}
    fi
done
git config --global include.path ~/.git_aliases

exit 0

