$svc_name = "Spooler"
Get-Service | Where-Object {$_.Name -eq $svc_name} | Stop-Service
Set-Service $svc_name -StartupType Disabled
