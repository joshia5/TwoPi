#!/bin/bash

_usage() {
    echo 'MUMPS : Multifrontal Sparse Direct Solver'
    echo '            --eneable-scotch (default)'
    echo '            --disable-scotch'
    echo '            --enable-metis (default)'
    echo '            --disable-metis'
    echo '            --debug (-g option)'
    echo '            --help'
}

GIT=$(command -v git)
SRCDIR=${TwoPiRoot}/src

CMAKE=$(command -v cmake)
MAKE=$(command -v make)

SCRIPT=$(dirname "$0")/env_${TwoPiDevice}.sh
source $SCRIPT

_USE_SCOTCH="ON"
_USE_METIS="ON"
_USE_DEBUG="OFF"

while [[ $# -gt 0 ]]
do
key="$1"
case $key in
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

REPO=${SRCDIR}/${MUMPS_REPO}

# find MPI 
#source $(dirname "$0")/subs/find_mpi.sh
#source $(dirname "$0")/subs/find_lapack.sh

MYPATH=$BASH_SOURCE
echo $MYPATH

if [[ -z "${MUMPSSOLVE_USE_MPISEQ}" ]]; then
  USE_SERIAL=0
else
  USE_SERIAL="${MUMPSSOLVE_USE_MPISEQ}"
fi

if [ "${USE_SERIAL}" -eq "1" ]; then
   MAKEINC=$(dirname "$MYPATH")/../extra/MUMPS/MUMPS_${TwoPiDevice}_serial_Makefile.inc
else
   MAKEINC=$(dirname "$MYPATH")/../extra/MUMPS/MUMPS_${TwoPiDevice}_Makefile.inc
fi


if [ ! -f $MAKEINC ]; then
    MAKEINC=$(dirname "$MYPATH")/../extra/MUMPS/MUMPS_default_Makefile.inc
fi

echo $MAKEINC
cp $MAKEINC ${REPO}/Makefile.inc
cd ${REPO}

ORDERING="-Dpord"
BKEXT=''
if [[ "${TwoPiDevice}" == "brew" ]]; then
  BKEXT='.bu'   ### On MacOS, -i option needs extension.
fi
if [[ "${_USE_SCOTCH}" == "ON" ]]; then
    sed -i${BKEXT} 's,#SCOTCHDIR  = ${HOME}/scotch_6.0,SCOTCHDIR=${TwoPiRoot},g' Makefile.inc
    sed -i${BKEXT} 's,#ISCOTCH    = -I$(SCOTCHDIR)/include,ISCOTCH    = -I$(SCOTCHDIR)/include,g' Makefile.inc
    sed -i${BKEXT} 's,#LSCOTCH    = -L$(SCOTCHDIR)/lib -lptesmumps -lptscotch -lptscotcherr,LSCOTCH    = -L$(SCOTCHDIR)/lib -lptesmumps -lptscotch -lptscotcherr -lscotch,g' Makefile.inc
    ORDERING="-Dscotch "${ORDERING}" -Dptscotch"
fi
if [[ "${_USE_METIS}" == "ON" ]]; then
    sed -i${BKEXT} 's,#LMETISDIR = /opt/metis-5.1.0/build/Linux-x86_64/libmetis,METISDIR=${TwoPiRoot},g' Makefile.inc
    sed -i${BKEXT} 's,#IMETIS    = /opt/metis-5.1.0/include,IMETIS   = -I$(METISDIR)/include,g' Makefile.inc
    sed -i${BKEXT} 's,#LMETIS    = -L$(LMETISDIR) -lparmetis -lmetis,LMETIS    = -L$(METISDIR)/lib -lparmetis -lmetis,g' Makefile.inc
    ORDERING="-Dmetis "${ORDERING}" -Dparmetis"    
fi
sed -i${BKEXT} "s,ORDERINGSF  = -Dpord,ORDERINGSF  = $ORDERING,g" Makefile.inc

if [[ "${_USE_DEBUG}" == "ON" ]]; then
    sed -i${BKEXT} 's,OPTF    = -O,OPTF    = -g,g' Makefile.inc
    sed -i${BKEXT} 's,OPTC    = -O,OPTC    = -g,g' Makefile.inc
    sed -i${BKEXT} 's,OPTL    = -O,OPTL    = -g,g' Makefile.inc
fi

$MAKE all MPICC=${MPICC} MPIFC=${MPIFC} MPIFL=${MPIFL} \
      OMPFCFLAG=${OMPFCFLAG} \
      OMPLINKFLAG=${OMPLINKFLAG} OMPCCFLAG=${OMPCCFLAG} $MAKEOPT






