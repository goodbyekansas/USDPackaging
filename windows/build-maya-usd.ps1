param (
    [Parameter(Mandatory=$true)][string]$srcdir,
    [Parameter(Mandatory=$true)][string]$builddir,
    [Parameter(Mandatory=$true)][string]$installdir,
    [Parameter(Mandatory=$true)][string]$usdcorelocation,
    [Parameter(Mandatory=$true)][string]$devkitlocation,
    [string]$pythondir = "C:\Python27",
    [Parameter(Mandatory=$true)][string]$patchdir
 )

# these need to be full paths for CMake to find things
$usdcorelocation = (Resolve-Path $usdcorelocation).Path
$devkitlocation = (Resolve-Path $devkitlocation).Path

echo "Applying patches to usd core..."
git apply --directory=$usdcorelocation --unsafe-paths (get-item $patchdir\*.patch)

if ($?) {
    echo "Patches applied"
} else {
    echo "Failed to apply patches, exiting..."
    #exit 1
}

python $srcdir/build.py $builddir `--devkit-location $devkitlocation/devkitBase `--pxrusd-location $usdcorelocation `--install-location $installdir `--generator "Visual Studio 16 2019" `--build-relwithdebug