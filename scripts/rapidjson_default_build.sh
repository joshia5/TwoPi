#!/bin/bash
#
# default action is to get PyOCC
#
SCRIPT=$(dirname "$0")/env_${TwoPiDevice}.sh
source $SCRIPT

GIT=$(command -v git)
SRCDIR=${TwoPiRoot}/src
REPO=${SRCDIR}/rapidjson

CMAKE=$(command -v cmake)
MAKE=$(command -v make)

mkdir -p $REPO/cmbuild
cd $REPO/cmbuild

$CMAKE .. -DCMAKE_INSTALL_PREFIX=${TwoPiRoot}     \
          -DCMAKE_C_COMPILER=${CC}                \
          -DCMAKE_CXX_COMPILER=${CXX}
