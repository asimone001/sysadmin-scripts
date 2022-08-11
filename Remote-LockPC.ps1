<#
  .SYNOPSIS
    Remotely locks Windows computers
  .DESCRIPTION
    This script resets all local account passwords, disables them, removes  registry profiles and forces a reboot to complete remote lockout.
  .PARAMETER NewPassword
    New password that all local accounts will be set to.
  .PARAMETER GuestAccountPassword
    Password for the Guest Account created after all other users are disabled
  .LINK
    https://i.imgur.com/cXjhpcX.jpg
  .NOTES
    Author: Anthony Simone
    Created: 17 March 2020
    Updated: 11 August 2022
    Version: 1.4.2
#>

param(
    [string]$NewPassword,
    [string]$GuestAccountPassword
    )
# Checks to see if the proper parameters have been sent
if(-not($NewPassword)) {
  throw “You must supply a value for NewPassword”
  }
if(-not($GuestAccountPassword)) {
  throw “You must supply a value for GuestAccountPassword”
  }

# Convert new passwords to SecureStrings
$SecureNewPassword = ConvertTo-SecureString -String $NewPassword -AsPlainText -Force
$SecureGuestAccountPassword = ConvertTo-SecureString -String $GuestAccountPassword -AsPlainText -Force

# Force logout of any active user
(Get-WmiObject -Class Win32_OperatingSystem).Win32Shutdown(4)

# Delete profile in registry for all domain users to prevent login with cached credentials
Get-WmiObject -Class Win32_UserProfile | Where {(!$_.Special) -and (!$_.Loaded)} | Remove-WmiObject

Get-LocalUser | #Get all local acocunts
    ForEach-Object {
        Write-Verbose "Changing password for account $($_.Name)"
        Set-LocalUser $_.Name -Password $SecureNewPassword #Reset password for all local accounts
        Write-Verbose "Disabling account $($_.Name)"
        Disable-LocalUser $_.Name #Disable all local accounts
    }
    

# Create a guest account in case access to the machine is needed
New-LocalUser "GuestUser" -Password $SecureGuestAccountPassword -FullName "Guest Account"
Add-LocalGroupMember -Group "Users" -Member "GuestUser"

# Force reboot the device
Restart-Computer -Force

#############################################################################
#End
#############################################################################
