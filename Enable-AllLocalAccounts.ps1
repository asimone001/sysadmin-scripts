#############################################################################
# This script enables all local accounts on a computer except Administrator
# or lsadmin password in case somebody was dumb enough to accidentally lock
# the device.
# 
# Copyright (c) 2021 Anthony Simone
#############################################################################

#Checks to see if PowerShell is being run in 64-bit mode, and relaunches as 64-bit if it detects it is currently 32-bit.
if ($env:PROCESSOR_ARCHITEW6432 -eq "AMD64") {
    write-warning "Relaunching as 64-bit"
    if ($myInvocation.Line) {
        &"$env:WINDIR\sysnative\windowspowershell\v1.0\powershell.exe" -NonInteractive -NoProfile $myInvocation.Line
    }else{
        &"$env:WINDIR\sysnative\windowspowershell\v1.0\powershell.exe" -NonInteractive -NoProfile -file "$($myInvocation.InvocationName)" $args
    }
exit $lastexitcode
}


Write-Host 'Executing Main Script...'

#New password for all local accounts

Get-LocalUser | #Get all local accounts
    ForEach-Object {

        If ( $_.Name -ne "Administrator" ) {
            If ( $_.Name -notlike "lsadmin" ) {
                Write-Verbose "Enabling account $($_.Name)"
                Enable-LocalUser $_.Name #Enable all local accounts
            }
        }
    }
    

#############################################################################
#End
#############################################################################