# This script will silently install Chrome on a device.
# If already installed, it will update in the background and then apply when the browser re-launches. Suitable for running remotely.

$Path = $env:TEMP;
$Installer = "chrome_installer.exe";

Invoke-WebRequest "http://dl.google.com/chrome/install/latest/chrome_installer.exe" -OutFile $Path\$Installer;
Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait;
Remove-Item $Path\$Installer
