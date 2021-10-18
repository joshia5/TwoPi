#!/bin/bash

# common envriomental variables

piScope_REPO=piScope

# Strumpack
STRUMPACK_VERSION=5.0.0
STRUMPACK_REPO=STRUMPACK-${STRUMPACK_VERSION}

# OpenCASCADE
OCC=opencascade-7.4.0

# Python OCC
PyOCC=pythonocc-core

# GMSH
GMSH=gmsh-4.5.6

# HYPRE
HYPRE_VERSION=2.20.0

# MUMPS
MUMPS_VERSION=5.4.1
MUMPS_REPO=MUMPS_${MUMPS_VERSION}

# SCOTCH
SCOTCH_VERSION=6.1.1

# Lapack
LAPACK_VERSION=3.9.0

# Scalapack
SCALAPACK_VERSION=2.1.0

# ButterflyPack
BUTTERFLYPACK_VERSION=1.2.1
BUTTERFLYPACK_REPO=ButterflyPACK-${BUTTERFLYPACK_VERSION}

# ZFP
ZFP_VERSION=0.5.5
ZFP_REPO=zfp-${ZFP_VERSION}

# C++11 flag
CXX11FLAG=-std=c++11

# make runs using the half of processor cores
NPROCHALF=$((($(nproc)+1)/2))
MAKEOPT="-j "${NPROCHALF}
