if "%blas_impl%" == "mkl" (

:: echo newlines
echo/ >> numpy/__init__.py
echo/ >> numpy/__init__.py
echo __mkl_version__ = "%mkl%" >> numpy/__init__.py
echo/ >> numpy/__init__.py

)

:: site.cfg comes from blas devel package (e.g. mkl-devel)
::   This gets stored in numpy/distutils, so it affects other packages that use numpy for setup.
COPY %PREFIX%\site.cfg site.cfg

python setup.py build install --single-version-externally-managed --record=record.txt
if errorlevel 1 exit 1

COPY %RECIPE_DIR%\f2py.bat %PREFIX%\Scripts\f2py.bat
