#!/bin/bash

REPO="PetraM_Base"
SRCDIR=${TwoPiRoot}/src
SC=$(dirname "$0")/subs/git_access.sh
source $SC

git_clone_or_pull "git@github.com:joshia5/PetraM_Base.git" $REPO $SRCDIR $*




