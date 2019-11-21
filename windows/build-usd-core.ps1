param (
    [string]$pythondir,
    [string]$installdir = "installed",
    [Parameter(Mandatory=$true)][string]$srcdir,
    [Parameter(Mandatory=$true)][string]$builddir
 )

$srcdir = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($srcdir)
$installdir = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($installdir)
$builddir = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($builddir)

$pythondirarg = ""
if ($pythondir) {
    $pythondirarg = "-DPython_ROOT_DIR='$pythondir' -DPython_EXECUTABLE='$pythondir\python.exe'"
}

$usdoptions = ""
if ($pythondirarg) {
    $usdoptions = "USD,$pythondirarg"
}

python $srcdir/build_scripts/build_usd.py `
--build $builddir/build `
--src $builddir/src `
$installdir `
--build-args $usdoptions boost,"--with-date_time --with-thread --with-system --with-filesystem"
