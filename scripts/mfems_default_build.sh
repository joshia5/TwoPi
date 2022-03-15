#!/bin/bash

SCRIPT=$(dirname "$0")/env_${TwoPiDevice}.sh
source $SCRIPT

_usage() {
    echo 'mfems : serial MFEM'
    echo '   options: --cuda'
}

ENABLE_CUDA="NO"

while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    --cuda)
    ENABLE_CUDA=YES	
    shift # past argument    	
    ;;
    --help)
    _usage
    exit 1
    ;;
    *)
    echo "Unknown option " $key
    exit 2  #  error_code=2
    ;;
esac
done
    
SRCDIR=${TwoPiRoot}/src
REPO=${SRCDIR}/mfem
TWOPILIB=${TWOPI}/lib
TWOPIINC=${TWOPI}/include

CMAKE=$(command -v cmake)
MAKE=$(command -v make)
HOST_COMPILER=$(command -v ${CC})

cd $REPO


echo "############# configuring mfem serial"

mkdir -p $REPO/cmbuild_ser
cd $REPO/cmbuild_ser
rm -rf $REPO/cmbuild_ser/*

$CMAKE .. -DCMAKE_VERBOSE_MAKEFILE=1                         \
          -DBUILD_SHARED_LIBS=1                              \
          -DMFEM_USE_ZLIB=1                                  \
          -DCMAKE_INSTALL_PREFIX=${TwoPiRoot}/mfem/ser       \
	  -DMFEM_ENABLE_EXAMPLES=1                           \
          -DMFEM_USE_EXCEPTIONS=1                            \
          -DCMAKE_CXX_FLAGS=$CXX11FLAG                       \
	  -DCMAKE_CXX_COMPILER=${CXX}                        \
          -DCMAKE_CUDA_HOST_COMPILER=${HOST_COMPILER}        \
	  -DMFEM_USE_CUDA=${ENABLE_CUDA}

$MAKE $MAKEOPT
$MAKE install

