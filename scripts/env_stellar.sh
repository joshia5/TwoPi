#!/bin/bash
CC=gcc
CXX=g++
FC=gfortran
FL=gfortran
MPICC=mpicc
MPICXX=mpicxx
MPIFC=mpiffort
MPIFL=mpifort
OMPFLAG="-fopenmp"
OMPLINKFLAG=-fopenmp
OMPCXXFLAG=-fopenmp
OMPCCFLAG=-fopenmp
OMPFCFLAG=-fopenmp

source $(dirname $BASH_SOURCE)/env_common.sh

# path to mpi.h
#    (note) It appears find_mpi does not work with CC (cray MPI compiler)
# MPI_INCLUDE_PATH=/opt/cray/pe/mpt/7.7.10/gni/mpich-intel/16.0/include
# MPI_LIBRARY_PATH=/opt/cray/pe/mpt/7.7.10/gni/mpich-intel/16.0/lib

# enforce scotch to 6.0.6
#SCOTCH_DL=37622
#SCOTCH_VERSION=6.0.6


