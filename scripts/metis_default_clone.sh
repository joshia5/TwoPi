#!/bin/bash

GIT=$(command -v git)
SRCDIR=${TwoPiRoot}/src
REPO="METIS"

mkdir -p $SRCDIR
cd $SRCDIR

wget https://github.com/mfem/tpls/raw/gh-pages/metis-5.1.0.tar.gz
#wget http://glaros.dtc.umn.edu/gkhome/fetch/sw/metis/metis-5.1.0.tar.gz
tar -zxvf metis-5.1.0.tar.gz
rm metis-5.1.0.tar.gz
mv metis-5.1.0 METIS

#SC=$(dirname "$0")/subs/git_access.sh
#source $SC

#git_clone_or_pull "https://github.com/KarypisLab/METIS.git"  $REPO $SRCDIR




