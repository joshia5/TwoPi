#!/bin/sh

SRCDIR=${TwoPiRoot}/src
REPO=${SRCDIR}/PetraM_MUMPS

TWOPILIB=${TwoPiRoot}/lib
TWOPIINC=${TwoPiRoot}/include

# load env
SCRIPT=$(dirname "$0")/env_${TwoPiDevice}.sh
source $SCRIPT

MAKE=$(command -v make)
cd $REPO

make MUMPS_SOLVE_DIR=${TwoPiRoot}/lib \
     MUMPS_INC_DIR=${TwoPiRoot}/src/${MUMPS_REPO}/include/ \
     MPI_INC_DIR=${MPI_INCLUDE_PATH} \
     MPICXX=${MPICXX} \
     MPICC=${MPICC}
make install PREFIX=${TwpPiRoot}
