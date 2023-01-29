#!/bin/bash
#
# default action is to get PyOCC
#

GIT=$(command -v git)
REPO="pythonocc-core"
SRCDIR=${TwoPiRoot}/src

DO_LATEST=false

# defualt SHA (7.4.0)
SHA=7848ff8412c6358bf19d113cb46753ef8d96351a
# defualt SHA (7.5.1)
SHA=5b38e1eae3e9d69f1d81280f70f0e4e8a385ad14
# defualt SHA (7.7.0)
SHA=692373c70046e080dae0b6cccfb6e1d67a428dfd
# branch
BRANCH=master

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -l|--latest)
    DO_LATEST=true
    shift # past argument    
    ;;
    -b|--branch)
    BRANCH=$2
    shift # past argument    
    shift # past param
    ;;
    --sha)
    SHA=$2
    DO_LATEST=false
    shift # past argument
    shift # past param
    ;;
    --75)
    SHA=5b38e1eae3e9d69f1d81280f70f0e4e8a385ad14	 
    DO_LATEST=false
    shift # past argument
    shift # past param
    ;;
esac
done

SC=$(dirname "$0")/subs/git_access.sh
source $SC

git_clone_or_pull "https://github.com/tpaviot/pythonocc-core.git" $REPO $SRCDIR

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



