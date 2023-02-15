#!/bin/bash
#
#  twopi_env.sh
#     set enviromental variables to use twopi
#
#     this script assumes python exists under $TwoPiRoot/bin
#     normally this executable is made from virtualenv. but
#     it could be a link to an executable in other location.
#
#     TwoPi install all modules using prefix=$TwoPiRoot
#     python module is iinstalled in
#       $TwoPiRoot/lib/pythonA.B/site-packages
#     A.B is inferred from os.__file__

SOURCE=${BASH_SOURCE[0]}
export PATH=$(dirname $SOURCE):$PATH
function ostype() {
    unameOut="$(uname -s)"
    case "${unameOut}" in
        Linux*)     machine=Linux;;
        Darwin*)    machine=Mac;;
        CYGWIN*)    machine=Cygwin;;
        MINGW*)     machine=MinGw;;
        *)          machine="UNKNOWN:${unameOut}"
    esac
    echo ${machine}
}
function safe_realpath() {
   OSTYPE=$(ostype)
   if [ -x "$(command -v realpath)" ]; then
      #echo "realpath found !"
      realpath $1
      return
   fi
   if [ "$OSTYPE" == "Mac" ]; then
      # we dont try readlink in Mac since it is different 
      # readlink (BSD) used in Linuxxa
      #echo "realpath is not avaialbe emulating it with python (Mac)"
      python -c 'import os,sys;print(os.path.realpath("'"$1"'"))'
      exit 0
   fi
   if [ -x "$(command -v readlink)" ]; then
      #echo "Using readlink"
      readlink -f $1
      return
   fi
   # I am not sure if it comes to this fallback...
   #echo "realpath is not avaialbe emulating it with python"
   python -c 'import os,sys;print(os.path.realpath("'"$1"'"))'
}


SC="$(safe_realpath  "$BASH_SOURCE")"
SC="$(dirname $SC)"
SC="$(dirname $SC)"

TWOPIROOT=$SC
TWOPIVER=$(basename $SC)
TWOPIDEVICE=$(cat $TWOPIROOT/etc/devicename)

export TwoPiDevice=$TWOPIDEVICE
export TwoPiRoot=$TWOPIROOT

export LD_LIBRARY_PATH=$TwoPiRoot/lib:$LD_LIBRARY_PATH
export PATH=$TwoPiRoot/bin:$PATH

# we need to find lib/pythonA.B (A.B is a version number)
# we get this number from os.__file__

PYTHON=$TwoPiRoot/bin/python
PYTHONVERSION=$(${PYTHON} -c "import os;print(os.path.basename(os.path.dirname(os.__file__))[6:])")
PYTHONLIB=$TwoPiRoot/lib/python${PYTHONVERSION}
mkdir -p $PYTHONLIB/site-packages
export PYTHONPATH=$PYTHONLIB/site-packages:$PYTHONPATH

export PetraM=$TwoPiRoot

if [[ -z "$TwoPiGit" ]]; then
   export TwoPiGit=https://github.com/piScope
fi

# this is necessary to luanch piScope with proper framework enviroment
INTERPRETER=$(cat $TWOPIROOT/etc/interpreter)

if [[ -f $TwoPiRoot/etc/set_pythonhome ]]; then
    export PYTHONHOME=$TWOPIROOT
fi


