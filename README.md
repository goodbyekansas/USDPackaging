# USDPackaging
Packaging for USD on Windows and Linux

# Building on Windows

- Download and install Visual Studio 2019 (Community Edition is fine) from
  [here](https://visualstudio.microsoft.com/downloads/). Make sure to select the "Desktop development with C++" workload during the installation.
- Make sure Python 2 is installed and available in PATH

## USD Core
- Open a powershell prompt with administrative permissions.
- First, some environment variables need to be set up for Visual Studio. This is done by using the
  Powershell script at `./windows/latest-vs.ps1` like this:
  ```shell
  . ./windows/latest-vs.ps1
  ```
- Kick off the build process by issuing:
```shell
./windows/build-usd-core.ps1 -installdir <dir-to-put-result-in> -srcdir <path-to-us-core-clone> -builddir <dir-to-put-temp-build-stuff-in>
```

You can also use the python build script in the USD core sync directly but our powershell script
makes sure to set needed boost options for building maya USD later.

## USD Maya
