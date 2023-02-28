#!/bin/bash

GIT=$(command -v git)
SRCDIR=${TwoPiRoot}/src
REPO="GKlib"

mkdir -p $SRCDIR
cd $SRCDIR

SC=$(dirname "$0")/subs/git_access.sh
source $SC

git_clone_or_pull "https://github.com/KarypisLab/GKlib.git" $REPO $SRCDIR


