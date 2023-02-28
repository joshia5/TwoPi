#!/bin/bash

_usage() {
    echo 'GKlib'
    echo '            --help'    
    
}

SCRIPT=$(dirname "$0")/env_${TwoPiDevice}.sh
source $SCRIPT

SCRIPT=$(dirname "$0")/subs/ostype.sh
source $SCRIPT

GIT=$(command -v git)
SRCDIR=${TwoPiRoot}/src
CMAKE=$(command -v cmake)
MAKE=$(command -v make)


while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    --help)
    _usage
    exit 1
    ;;
    *)
    echo "Unknown option " $key
    exit 2  #  error_code=2
    ;;
esac
done

cd ${SRCDIR}/GKlib

$MAKE config shared=1 prefix=$TwoPiRoot cc=${CC}
$MAKE $MAKEOPT
$MAKE install

OSTYPE=$(ostype)
if [ "${OSTYPE}" == "Mac" ]; then
   install_name_tool -id ${TwoPiRoot}/lib/libgklib.dylib ${TwoPiRoot}/lib/libgklib.dylib
fi



