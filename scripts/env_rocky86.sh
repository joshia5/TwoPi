#!/bin/bash

CC=cc
CXX=c++
FC=gfortran
MPICC=mpicc
MPICXX=mpic++
MPIFC=mpif90
MPIFL=mpif90
OMPFLAG=-fopenmp
OMPLINKFLAG=-fopenmp
OMPCXXFLAG=-fopenmp
OMPCCFLAG=-fopenmp
OMPFCFLAG=-fopenmp

source $(dirname $BASH_SOURCE)/env_common.sh

#
# these are currently used only for STRUMPACK, ZPF, Butterflypack
#
BLAS_LIBRARIES='/usr/lib64/libopenblas.so'
LAPACK_LIBRARIES=''
SCALAPACK_LIBRARIES='/usr/lib64/openmpi/lib/libscalapack.so'
ARPACK_LIBRARIES='/usr/lib64/libarpack.so'
MPI_INCLUDE='/usr/include/openmpi-x86_64/'
