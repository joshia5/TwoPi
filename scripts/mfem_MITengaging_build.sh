#!/bin/sh

SRCDIR=${TwoPiRoot}/src
REPO=${SRCDIR}/mfem-git
TWOPILIB=${TWOPI}/lib
TWOPIINC=${TWOPI}/include

CMAKE=$(command -v cmake)
MAKE=$(command -v make)
MPICXX=$(command -v mpiicxx)
cd $REPO

echo "############# configuring mfem serial"

mkdir -p $REPO/cmbuild_ser
cd $REPO/cmbuild_ser
rm -rf $REPO/cmbuild_ser/*

$CMAKE .. -DCMAKE_VERBOSE_MAKEFILE=1 -DBUILD_SHARED_LIBS=1 \
-DCMAKE_INSTALL_PREFIX=${TwoPiRoot}/mfem-git/ser -DMFEM_ENABLE_EXAMPLES=1 \
-DMFEM_USE_EXCEPTIONS=1

$MAKE
$MAKE install

echo "############# configuring mfem parallel"

mkdir -p $REPO/cmbuild_par
cd $REPO/cmbuild_par
rm -rf $REPO/cmbuild_par/*

$CMAKE .. -DCMAKE_VERBOSE_MAKEFILE=1 -DBUILD_SHARED_LIBS=1                 \
-DCMAKE_INSTALL_PREFIX=${TwoPiRoot}/mfem-git/par -DMFEM_ENABLE_EXAMPLES=1  \
-DHYPRE_DIR=$TWOPILIB -DHYPRE_INCLUDE_DIRS=$TWOPIINC                       \
-DMETIS_DIR=$TWOPILIB -DMETIS_INCLUDE_DIRS=$TWOPIINC                       \
-DMFEM_USE_MPI=1 -DMFEM_USE_METIS_5=1 -DMFEM_ENABLE_EXAMPLES=1             \
-DCMAKE_CXX_COMPILER=$MPICXX  -DCMAKE_SHARED_LINKER_FLAGS="-L$TWOPILIB     \
-lHYPRE -lmetis" -DCMAKE_EXE_LINKER_FLAGS="-L$TWOPILIB -lHYPRE -lmetis"

$MAKE
$MAKE install
