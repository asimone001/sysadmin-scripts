$Path = $env:TEMP
$Installer = "gdfs.exe"

Invoke-WebRequest "https://dl.google.com/drive-file-stream/GoogleDriveFSSetup.exe" -OutFile $Path\$Installer
Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait
Remove-Item $Path\$Installer
