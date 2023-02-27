#!/bin/bash
#
# default action is to get mfem-3.4 
#
#   ./script/buildcomponent.sh mfem clone (# master mfem 4.0)
#   ./script/buildcomponent.sh mfem clone -l (# master latest)
#   ./script/buildcomponent.sh mfem clone -b test -l latest (# test branch latest)
#   

GIT=$(command -v git)
REPO="mfem"
SRCDIR=${TwoPiRoot}/src

DO_LATEST=false

# SHA 
# v3.4
# SHA=0715efbaf95990a4e76380ac69337096b1cd347d
# v4.0
# SHA=4d900b0c5fd6352c92173e74678bcbeeb11c8691
# v4.1
# SHA=8dbbcfc25629ac7612fe31afd5b511752ff0e69b
# v4.2
# SHA=ed5604e0d350461f20842275578aa2f9e6a61343
# v4.3
# SHA=9d8043b9e78dcdcd86639bbb28d3bd7b514fb5e2
# v4.4
# SHA=a1f6902ed72552f3e680d1489f1aa6ade2e0d3b2
# v4.5
SHA=b7a4b61b5ce80b326a002aebccf7da7ad2432556
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
esac
done

SC=$(dirname "$0")/subs/git_access.sh
source $SC

git_clone_or_pull "https://github.com/mfem/mfem.git" $REPO $SRCDIR

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



