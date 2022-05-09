#!/bin/bash
SCRIPT=$(dirname "$0")/env_${TwoPiDevice}.sh
source $SCRIPT

SRCDIR=${TwoPiRoot}/src
REPO=${SRCDIR}/${SUITESPARSE_REPO}

cd ${REPO}
make distclean
