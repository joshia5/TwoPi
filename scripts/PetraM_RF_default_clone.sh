#!/bin/sh

GIT=$(command -v git)
SRCDIR=${TwoPiRoot}/src
REPO="PetraM_RF"

SC=$(dirname "$0")/subs/git_access.sh
source $SC

git_clone_or_pull "git@github.com:piScope/PetraM_RF.git" $REPO $SRCDIR


