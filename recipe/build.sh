#!/bin/bash

cp $RECIPE_DIR/test_fft.py numpy/fft/tests

if [ "$blas_impl" = "mkl" ]; then
printf "\n\n__mkl_version__ = \"$mkl\"\n" >> numpy/__init__.py
fi

if [ "$blas_impl" = "openblas" ] && [ $(uname) == Linux ]; then
    # add -shared to LDFLAGS to prevent linking errors similar to:
    # In function `_start':
    # (.text+0x20): undefined reference to `main'
    # these seems to only occur when using gfortran
    export LDFLAGS="${LDFLAGS} -shared"
fi

# site.cfg comes from blas devel package (e.g. mkl-devel)
cp $PREFIX/site.cfg site.cfg

$PYTHON setup.py config
$PYTHON setup.py build
$PYTHON setup.py install
