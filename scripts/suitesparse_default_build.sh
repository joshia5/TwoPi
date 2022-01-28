#!/bin/bash
SCRIPT=$(dirname "$0")/env_${TwoPiDevice}.sh
source $SCRIPT

_usage() {
    echo 'SUITESPARSE installer installs UMFPACK/KLU'
}

SRCDIR=${TwoPiRoot}/src
REPO=${SRCDIR}/${SUITESPARSE_REPO}

cd ${REPO}/AMD
make 
make install INSTALL=${TwoPiRoot}

cd ${REPO}/CAMD
make 
make install INSTALL=${TwoPiRoot}

cd ${REPO}/CCOLAMD
make 
make install INSTALL=${TwoPiRoot}

cd ${REPO}/CHOLMOD
make 
make install INSTALL=${TwoPiRoot}

cd ${REPO}/COLAMD
make 
make install INSTALL=${TwoPiRoot}

cd ${REPO}/BTF
make 
make install INSTALL=${TwoPiRoot}

cd ${REPO}/KLU
make  MY_METIS_LIB=${TwoPiRoot}/lib/libmetis.so MY_METIS_INC=${TwoPiRoot}/include

cd ${REPO}/UMFPACK
make


cd ${REPO}/KLU
make install INSTALL=${TwoPiRoot}

cd ${REPO}/UMFPACK
make install INSTALL=${TwoPiRoot}
