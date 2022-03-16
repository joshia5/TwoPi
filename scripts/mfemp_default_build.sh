#!/bin/bash

SCRIPT=$(dirname "$0")/env_${TwoPiDevice}.sh
source $SCRIPT

_usage() {
    echo 'MFEM : parallel build (with metis/hypre)'
    echo '   options: --cuda (nvcc must be found on PATH)'
}

SRCDIR=${TwoPiRoot}/src
REPO=${SRCDIR}/mfem
TWOPILIB=${TwoPiRoot}/lib
TWOPIINC=${TwoPiRoot}/include

CMAKE=$(command -v cmake)
MAKE=$(command -v make)


cd $REPO

echo "############# configuring mfem parallel"

mkdir -p $REPO/cmbuild_par
cd $REPO/cmbuild_par
rm -rf $REPO/cmbuild_par/*

WITH_PUMI=NO
WITH_SUITESPARSE=NO
ENABLE_CUDA=NO
CUDA_OPTIONS=
while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    --with-pumi)
    WITH_PUMI=YES
    shift # past argument    
    ;;
    --with-suitesparse)
    WITH_SUITESPARSE=YES
    shift # past argument
    ;;
    --cuda)
    HOST_COMPILER=$(command -v ${MPICXX})
    CUDA_OPTS=" -DMFEM_USE_CUDA=1"
    CUDA_OPTS=${CUDA_OPTS}" -DCMAKE_CUDA_HOST_COMPILER=""${HOST_COMPILER}"
    if [ -n "${CUDA_ARCH}" ]; then
	CUDA_OPTS="${CUDA_OPTS}"" -DCMAKE_CUDA_ARCHITECTURE=""${CUDA_ARCH}"
    fi
    shift # past argument    	
    ;;
    *)
    echo "Unknown option " $key
    exit 2  #  error_code=2
    ;;
esac
done

<<<<<<< Updated upstream
echo cuda"${ENABLE_CUDA}"

$CMAKE .. -DCMAKE_VERBOSE_MAKEFILE=1                           \
=======
METIS_HYPRE_LINK='"'-L" "${TWOPILIB}' -lHYPRE -lmetis"'

COMM=${CMAKE}" .. -DCMAKE_VERBOSE_MAKEFILE=1                           \
>>>>>>> Stashed changes
          -DBUILD_SHARED_LIBS=1                                \
          -DMFEM_ENABLE_EXAMPLES=1                             \
          -DCMAKE_INSTALL_PREFIX=${TwoPiRoot}/mfem/par         \
          -DHYPRE_DIR=$TWOPILIB                                \
	  -DHYPRE_INCLUDE_DIRS=$TWOPIINC                       \
          -DMETIS_DIR=$TWOPILIB                                \
<<<<<<< Updated upstream
	  -DMETIS_INCLUDE_DIRS=$TWOPIINC                       \
	  "${CUDA_OPTS}"                                       \
=======
	  -DMETIS_INCLUDE_DIRS=${TWOPIINC}                     \
>>>>>>> Stashed changes
          -DMFEM_USE_ZLIB=1                                    \
          -DMFEM_USE_MPI=1                                     \
	  -DMFEM_USE_METIS_5=1                                 \
	  -DMFEM_ENABLE_EXAMPLES=1                             \
          -DMFEM_USE_PUMI=${WITH_PUMI}                       \
 	  -DPUMI_DIR=${TwoPiRoot}                            \
          -DMFEM_USE_SUITESPARSE=${WITH_SUITESPARSE}         \
          -DSuiteSparse_DIR=${TwoPiRoot}                     \
          -DCMAKE_CXX_COMPILER=$MPICXX                         \
          -DCMAKE_CXX_FLAGS=$CXX11FLAG                         \
<<<<<<< Updated upstream
	  -DCMAKE_SHARED_LINKER_FLAGS="-L$TWOPILIB -lHYPRE -lmetis"   \
	  -DCMAKE_EXE_LINKER_FLAGS="-L$TWOPILIB -lHYPRE -lmetis"      \
          -DCMAKE_INSTALL_RPATH="${TWOPILIB}":${TwoPiRoot}/mfem/par/lib \
          -DCMAKE_BUILD_WITH_INSTALL_RPATH=1
=======
	  -DCMAKE_SHARED_LINKER_FLAGS=${METIS_HYPRE_LINK}      \
	  -DCMAKE_EXE_LINKER_FLAGS=${METIS_HYPRE_LINK}         \
          -DCMAKE_INSTALL_RPATH=${TWOPILIB}:${TwoPiRoot}/mfem/par/lib \
          -DCMAKE_BUILD_WITH_INSTALL_RPATH=1"
COMM=${COMM}"${CUDA_OPTS}"                                       
echo $COMM
eval $COMM
>>>>>>> Stashed changes

$MAKE $MAKEOPT
$MAKE install

