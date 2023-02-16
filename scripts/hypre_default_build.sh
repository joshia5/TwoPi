#!/bin/bash

SCRIPT=$(dirname "$0")/env_${TwoPiDevice}.sh
source $SCRIPT

_usage() {
    echo 'HYPRE : parallel linear solver'
    echo '   options: --with-cuda (nvcc must be found on PATH)'
}


while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    --with-cuda)
      HOST_COMPILER=$(command -v ${MPICXX})		
      CUDA_OPTS=" -DHYPRE_WITH_CUDA=YES"
      CUDA_OPTS=${CUDA_OPTS}" -DCMAKE_CUDA_HOST_COMPILER=""${HOST_COMPILER}"      
      if [ -n "${CUDA_ARCH}" ]; then
	CUDA_OPTS="${CUDA_OPTS}"" -DHYPRE_CUDA_SM=""${CUDA_ARCH}"
      fi
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

GIT=$(command -v git)
SRCDIR=${TwoPiRoot}/src
CMAKE=$(command -v cmake)
MAKE=$(command -v make)


HYPREDIR=${SRCDIR}/hypre-${HYPRE_VERSION}

#export CXX=${MPICXX}
#export CC=${MPICC}

mkdir -p ${HYPREDIR}/src/cmbuild
cd ${HYPREDIR}/src/cmbuild

COMM=${CMAKE}" .. -DCMAKE_VERBOSE_MAKEFILE=1                             \
          -DBUILD_SHARED_LIBS=1                                          \
          -DHYPRE_INSTALL_PREFIX=${TwoPiRoot}                            \
          -DHYPRE_SHARED=1                                               \
	  -DMPI_C_COMPILER=${MPICC}                                      \
	  -DCMAKE_C_COMPILER=${CC}                                       \
          -DCMAKE_INSTALL_PREFIX=${TwoPiRoot}                            \
          -DCMAKE_OSX_DEPLOYMENT_TARGET=${MACOSX_DEPLOYMENT_TARGET}      \
          -DCMAKE_INSTALL_NAME_DIR=${TwoPiRoot}/lib"     

COMM=${COMM}"${CUDA_OPTS}"

echo "executing ..."${COMM}
eval ${COMM}

$MAKE $MAKEOPT
$MAKE install

cd $TwoPiRoot/lib
if [ -f $TwoPiRoot/lib64/libHYPRE.so ]; then
   ln -snf $TwoPiRoot/lib64/libHYPRE.so libHYPRE.so
fi



