#!/bin/bash

GIT=$(command -v git)
REPO="glvis"
SRCDIR=${TwoPiRoot}/src

SC=$(dirname "$0")/subs/git_access.sh
source $SC

git_clone_or_pull "git@github.com:joshia5/glvis.git" $REPO $SRCDIR
