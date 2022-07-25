<#
.SYNOPSIS
    A simple script to remove Silverlight from any computer it is installed on.
.DESCRIPTION
    This script searches for any package with Silverlight in the name, and uninstalls it.
.NOTES
    This function requires the NuGet Package Provider. The use of -Force is intended to bypass the normal install 
    prompt so it can be used in an automated fashion.
    Author: Anthony Simone
.LINK
    https://i.imgur.com/cXjhpcX.jpg
#>

$pkgName = "*Silverlight*"

If (Get-Package -Name $pkgName) {
    Write-Host "Silverlight found, removing it..."
    Get-Package -Name $pkgName | Uninstall-Package -AllVersions -Force
}
else {
    Write-Host "Silverlight not found, exiting script now."
}