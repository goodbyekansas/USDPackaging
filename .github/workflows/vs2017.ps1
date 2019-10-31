$installationPath = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise";
& "${env:COMSPEC}" /s /c "`"$installationPath\Common7\Tools\vsdevcmd.bat`" -no_logo -arch=amd64 && set" | foreach-object {
  $name, $value = $_ -split '=', 2
  set-content env:\"$name" $value
}
