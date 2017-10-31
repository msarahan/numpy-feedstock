#!/bin/bash

cp $RECIPE_DIR/test_fft.py numpy/fft/tests

if [ "$blas_impl" = "mkl" ]; then
printf "\n\n__mkl_version__ = \"$mkl\"\n" >> numpy/__init__.py
fi

if [ "$blas_impl" = "openblas" ]; then
    export LDFLAGS="${LDFLAGS} -shared"
fi

# site.cfg comes from blas devel package (e.g. mkl-devel)
cp $PREFIX/site.cfg site.cfg

$PYTHON setup.py config
$PYTHON setup.py build
$PYTHON setup.py install
