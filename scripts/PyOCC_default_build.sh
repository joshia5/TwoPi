#!/bin/bash
SCRIPT=$(dirname "$0")/env_${TwoPiDevice}.sh
source $SCRIPT

GIT=$(command -v git)
SRCDIR=${TwoPiRoot}/src
REPO=$SRCDIR/${PyOCC}
CMAKE=$(command -v cmake)
MAKE=$(command -v make)

if [ ! -d ${REPO} ];then
    echo "PythonOCC repo does not exist in"  ${REPO}
    exit 1
fi

OCC_INSTALL_DIR=$(${PYTHON} -c "from distutils.sysconfig import get_python_lib; import os;print(get_python_lib())")

# if TwoPi has OOC installed use it otherwise defualt
if [  -d ${TwoPiRoot}/include/opencascade ]; then
    OCC_HEADER=${TwoPiRoot}/include/opencascade
    OCC_LIB=${TwoPiRoot}/lib
else
    OCC_HEADER=/usr/local/include/opencascade
    OCC_LIB=/usr/local/lib
fi


echo "OCC header :"${OCC_HEADER}
echo "OCC lib    :"${OCC_LIB}

FILE=$REPO/src/SWIG_files/wrapper/ShapeUpgrade.i

echo "PATCHING :"${FILE}
${PYTHON} -c "txt=open('${FILE}').read().replace('#include<Precision.hxx>', '#include<Precision.hxx>\n#include<TopoDS_Edge.hxx>');fid=open('${FILE}', 'w');fid.write(txt)"

mkdir -p $REPO/cmbuild
cd $REPO/cmbuild

$CMAKE .. -DCMAKE_INSTALL_PREFIX=${TwoPiRoot}     \
          -DCMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES=${TwoPiRoot}/include \
          -DCMAKE_INSTALL_RPATH=${TwoPiRoot}      \
          -DOCE_INCLUDE_PATH=${OCC_HEADER}        \
          -DOCE_LIB_PATH=${OCC_LIB}               \
          -DCMAKE_C_COMPILER=${CC}                \
          -DCMAKE_CXX_COMPILER=${CXX}             \
          -DPYTHONOCC_INSTALL_DIRECTORY=${OCC_INSTALL_DIR}/OCC

$MAKE VERBOSE=1 $MAKEOPT
$MAKE install


