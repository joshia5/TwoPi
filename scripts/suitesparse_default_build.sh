#!/bin/bash
SCRIPT=$(dirname "$0")/env_${TwoPiDevice}.sh
source $SCRIPT

_usage() {
    echo 'SUITESPARSE installer installs UMFPACK/KLU'
}

SRCDIR=${TwoPiRoot}/src
REPO=${SRCDIR}/${SUITESPARSE_REPO}

export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${TwoPiRoot}/lib

cd ${REPO}/SuiteSparse_config
make MY_METIS_LIB=${TwoPiRoot}/lib/libmetis.so MY_METIS_INC=${TwoPiRoot}/include \
     F77=${FC} CC=${CC} CXX=${CXX} INSTALL=${TwoPiRoot}
make install INSTALL=${TwoPiRoot} \
     F77=${FC} CC=${CC} CXX=${CXX} INSTALL=${TwoPiRoot}

cd ${REPO}/AMD
make MY_METIS_LIB=${TwoPiRoot}/lib/libmetis.so MY_METIS_INC=${TwoPiRoot}/include \
     F77=${FC} CC=${CC} CXX=${CXX} INSTALL=${TwoPiRoot}
make install INSTALL=${TwoPiRoot} \
     F77=${FC} CC=${CC} CXX=${CXX} INSTALL=${TwoPiRoot}

cd ${REPO}/CAMD
make MY_METIS_LIB=${TwoPiRoot}/lib/libmetis.so MY_METIS_INC=${TwoPiRoot}/include \
     F77=${FC} CC=${CC} CXX=${CXX} INSTALL=${TwoPiRoot}
make install INSTALL=${TwoPiRoot} \
     F77=${FC} CC=${CC} CXX=${CXX} INSTALL=${TwoPiRoot}

cd ${REPO}/CCOLAMD
make MY_METIS_LIB=${TwoPiRoot}/lib/libmetis.so MY_METIS_INC=${TwoPiRoot}/include \
     F77=${FC} CC=${CC} CXX=${CXX} INSTALL=${TwoPiRoot}
make install INSTALL=${TwoPiRoot} \
     F77=${FC} CC=${CC} CXX=${CXX} INSTALL=${TwoPiRoot}

cd ${REPO}/COLAMD
make MY_METIS_LIB=${TwoPiRoot}/lib/libmetis.so MY_METIS_INC=${TwoPiRoot}/include \
     F77=${FC} CC=${CC} CXX=${CXX} INSTALL=${TwoPiRoot}
make install INSTALL=${TwoPiRoot} \
     F77=${FC} CC=${CC} CXX=${CXX} INSTALL=${TwoPiRoot}

cd ${REPO}/CHOLMOD
make MY_METIS_LIB=${TwoPiRoot}/lib/libmetis.so MY_METIS_INC=${TwoPiRoot}/include \
     F77=${FC} CC=${CC} CXX=${CXX} INSTALL=${TwoPiRoot}
make install INSTALL=${TwoPiRoot} \
     F77=${FC} CC=${CC} CXX=${CXX} INSTALL=${TwoPiRoot}

cd ${REPO}/BTF
make MY_METIS_LIB=${TwoPiRoot}/lib/libmetis.so MY_METIS_INC=${TwoPiRoot}/include \
     F77=${FC} CC=${CC} CXX=${CXX} INSTALL=${TwoPiRoot}
make install INSTALL=${TwoPiRoot} \
     F77=${FC} CC=${CC} CXX=${CXX} INSTALL=${TwoPiRoot}

cd ${REPO}/KLU
make MY_METIS_LIB=${TwoPiRoot}/lib/libmetis.so MY_METIS_INC=${TwoPiRoot}/include \
     F77=${FC} CC=${CC} CXX=${CXX} INSTALL=${TwoPiRoot}

cd ${REPO}/UMFPACK
make MY_METIS_LIB=${TwoPiRoot}/lib/libmetis.so MY_METIS_INC=${TwoPiRoot}/include \
     F77=${FC} CC=${CC} CXX=${CXX} INSTALL=${TwoPiRoot}

cd ${REPO}/KLU
make install INSTALL=${TwoPiRoot} \
     F77=${FC} CC=${CC} CXX=${CXX} INSTALL=${TwoPiRoot}

cd ${REPO}/UMFPACK
make install INSTALL=${TwoPiRoot} \
     F77=${FC} CC=${CC} CXX=${CXX} INSTALL=${TwoPiRoot}
