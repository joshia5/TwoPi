#!/bin/bash

GIT=$(command -v git)
SRCDIR=${TwoPiRoot}/src
REPO="ParMETIS"

mkdir -p $SRCDIR
cd $SRCDIR

wget https://github.com/sshiraiwa/tpls/raw/gh-pages/parmetis-4.0.3.tar.gz
#wget http://glaros.dtc.umn.edu/gkhome/fetch/sw/parmetis/parmetis-4.0.3.tar.gz
tar -zxvf parmetis-4.0.3.tar.gz
rm parmetis-4.0.3.tar.gz
mv parmetis-4.0.3 ParMETIS

#SC=$(dirname "$0")/subs/git_access.sh
#source $SC

#git_clone_or_pull "https://github.com/KarypisLab/ParMETIS.git" $REPO $SRCDIR


