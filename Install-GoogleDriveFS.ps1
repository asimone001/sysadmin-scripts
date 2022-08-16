# Variables
$Path = $env:TEMP
$Installer = "gdfs.exe"

# Download and install the program
Invoke-WebRequest "https://dl.google.com/drive-file-stream/GoogleDriveFSSetup.exe" -OutFile $Path\$Installer
Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait

# Clean up installer after it is finished.
Remove-Item $Path\$Installer
