#!/bin/bash
CC=icc
CXX=icpc
FC=ifort
FL=ifort
MPICC=mpiicc
MPICXX=mpiicpc
MPIFC=mpiifort
MPIFL=mpiifort
OMPFLAG="-qopenmp"
OMPLINKFLAG=-qopenmp
OMPCXXFLAG=-qopenmp
OMPCCFLAG=-qopenmp
OMPFCFLAG=-qopenmp

source $(dirname $BASH_SOURCE)/env_common.sh

# path to mpi.h
#    (note) It appears find_mpi does not work with CC (cray MPI compiler)
MPI_INCLUDE_PATH=/usr/common/software/intel/parallel_studio_xe_2020_cluster_edition/impi/2019.6.166/intel64/include
MPI_LIBRARY_PATH=/usr/common/software/intel/parallel_studio_xe_2020_cluster_edition/impi/2019.6.166/intel64/lib

# enforce scotch to 6.0.6
#SCOTCH_DL=37622
#SCOTCH_VERSION=6.0.6


