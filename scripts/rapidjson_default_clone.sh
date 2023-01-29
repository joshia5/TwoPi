#!/bin/bash
#
# default action is to get PyOCC
#

GIT=$(command -v git)
REPO="rapidjson"
SRCDIR=${TwoPiRoot}/src

#V.1.1.0
SHA=012be8528783cdbf4b7a9e64f78bd8f056b97e24
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


