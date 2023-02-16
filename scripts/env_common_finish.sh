#!/bin/bash
#
#  Set derived variables
#
if [ -z "$SCALAPACK_LIBRARIES"  ]
then
    SCALAPACK_INC=
    SCALAPACK_LIB=    
else
    SCALAPACK_INC="-I "$SCALAPACK_LIBRARIES"/include"
    SCALAPACK_LIB="-L "$SCALAPACK_LIBRARIES"/lib"
fi

if [ -z "$LAPACK_LIBRARIES"  ]
then
    LAPACK_INC=
    LAPACK_LIB=    
else
    LAPACK_INC="-I "$LAPACK_LIBRARIES"/include"
    LAPACK_LIB="-L "$LAPACK_LIBRARIES"/lib"
fi

if [ -z "$BLAS_LIBRARIES"  ]
then
    BLAS_INC=
    BLAS_LIB=    
else
    BLAS_INC="-I "$BLAS_LIBRARIES"/include"
    BLAS_LIB="-L "$BLAS_LIBRARIES"/lib"
fi


