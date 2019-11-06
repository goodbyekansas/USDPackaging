param (
    [string]$pythondir = "C:\Python27",
    [string]$installdir = "installed",
    [Parameter(Mandatory=$true)][string]$srcdir,
    [Parameter(Mandatory=$true)][string]$builddir
 )

python $srcdir/build_scripts/build_usd.py `--build $builddir/build `--src $builddir/src `--generator "Visual Studio 16 2019" `$installdir `--build-args USD,-DPython_ROOT_DIR="$pythondir" boost,"--with-date_time --with-thread --with-system --with-filesystem"