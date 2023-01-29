#!/bin/bash

GIT=$(command -v git)
SRCDIR=${TwoPiRoot}/src
REPO=${SRCDIR}/swig-rel-4.0.2
CMAKE=$(command -v cmake)
MAKE=$(command -v make)

SCRIPT=$(dirname "$0")/env_${TwoPiDevice}.sh
source $SCRIPT

cd ${REPO}
${REPO}/autogen.sh
${REPO}/configure --prefix=${TwoPiRoot}/SWIG_4_0_2
$MAKE
$MAKE install
