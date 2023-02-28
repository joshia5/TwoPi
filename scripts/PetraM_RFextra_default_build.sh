#!/bin/bash

SRCDIR=${TwoPiRoot}/src
REPO=${SRCDIR}/PetraM_RFextra
PYTHON=$(command -v python)

cd $REPO


export PetraM=${TwoPiRoot}
$PYTHON -m pip install ./ --verbose

