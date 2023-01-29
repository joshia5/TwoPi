#!/bin/bash
#
# default action is to get PyOCC
#

GIT=$(command -v git)
REPO="rapidjson"
SRCDIR=${TwoPiRoot}/src

#V.1.1.0
SHA=f54b0e47a08782a6131cc3d60f94d038fa6e0a51
DO_LATEST=false

SC=$(dirname "$0")/subs/git_access.sh
source $SC

git_clone_or_pull "https://github.com/Tencent/rapidjson" $REPO $SRCDIR

if [ ! -f ${SRCDIR}/${REPO} ]; then
   cd ${SRCDIR}/${REPO}
   echo "Checking out" ${BRANCH}   $DO_LATEST 
   $GIT checkout ${BRANCH} 
   if ! ${DO_LATEST} 
   then   
      echo "Checking out" ${SHA}
      $GIT checkout ${SHA}
   fi
fi


