#!/bin/bash

_usage() {
    echo 'PetraM_MUMPS : MUMPS wrapper for Petra-M'
    echo '   options: --clean-swig'
    echo '            --run-swig'
    echo '            --eneable-scotch (default)'
    echo '            --disable-scotch '
    echo '            --enable-metis (default)'
    echo '            --disable-metis'
    echo '            --debug (use debug flag)'            
    echo '            --help'
}


MAKE=$(command -v make)
SRCDIR=${TwoPiRoot}/src
REPO=${SRCDIR}/PetraM_MUMPS

TWOPILIB=${TwoPiRoot}/lib
TWOPIINC=${TwoPiRoot}/include

# load env
SCRIPT=$(dirname "$0")/env_${TwoPiDevice}.sh
source $SCRIPT


DO_SWIG=false
DO_CLEAN_SWIG=false
_USE_DEBUG="OFF"
_USE_SCOTCH="ON"
_USE_METIS="ON"

while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    --clean-swig)
    DO_CLEAN_SWIG=true
    shift # past argument    
    ;;
    --run-swig)
    DO_SWIG=true
    shift # past argument    
    ;;
    --enable-scotch)
    _USE_SCOTCH="ON"
    shift # past argument    
    ;;
    --disable-scotch)
    _USE_SCOTCH="OFF"
    shift # past argument    
    ;;
    --enable-metis)
    _USE_METIS="ON"
    shift # past argument    
    ;;
    --disable-metis)
    _USE_METIS="OFF"
    shift # past argument    
    ;;
    --debug)
    _USE_DEBUG="ON"	
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

if $DO_SWIG ;then
    cd ${REPO}    
    MUMPS_INC=${SRCDIR}/${MUMPS_REPO}/include
    export MUMPS_INC_DIR=${MUMPS_INC}
    $MAKE cxx
    exit 0
fi
if $DO_CLEAN_SWIG ;then
    cd ${REPO}
    MUMPS_INC=${SRCDIR}/${MUMPS_REPO}/include
    $MAKE cleancxx
    exit 0
fi

### this are used in build1
export USE_METIS=${_USE_METIS}
export USE_SCOTCH=${_USE_SCOTCH}
export USE_DEBUG=${_USE_DEBUG}

export SCALAPACK_LIB="${SCALAPACK_LIB}"
export LAPACK_LIB="${LAPACK_LIB}"
export BLAS_LIB="${BLAS_LIB}"

export CPATH=${TwoPiRoot}/src/MUMPS_$MUMPS_VERSION}/include

SCRIPT=$(dirname "$0")/buildcomponent.sh
${SCRIPT} PetraM_MUMPS build1
${SCRIPT} PetraM_MUMPS build2

