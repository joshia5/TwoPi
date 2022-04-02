#!/bin/bash
CC=nvc
CXX=nvc++
FC=nvfortran
FL=nvfortran
MPICC=cc
MPICXX=CC
MPIFC=ftn
MPIFL=ftn
OMPFLAG="-fast -mp=gpu -gpu=cc80"
OMPLINKFLAG="-fast -mp=gpu -gpu=cc80"
OMPCXXFLAG=-"-fast -mp=gpu -gpu=cc80"
OMPCCFLAG=-"-fast -mp=gpu -gpu=cc80"
OMPFCFLAG="-fast -mp=gpu -gpu=cc80"

source $(dirname $BASH_SOURCE)/env_common.sh

# path to mpi.h
#    (note) It appears find_mpi does not work with CC (cray MPI compiler)
#MPI_INCLUDE_PATH=/opt/cray/pe/mpt/7.7.10/gni/mpich-intel/16.0/include
#MPI_LIBRARY_PATH=/opt/cray/pe/mpt/7.7.10/gni/mpich-intel/16.0/lib

# enforce scotch to 6.0.6
#SCOTCH_DL=37622
#SCOTCH_VERSION=6.0.6

# CUDA_ARCHITECUTRES (will be passed by DCMAKE_CUDA_ARCHITECTURES)
CUDA_ARCH=80


