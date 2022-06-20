# This script will eject the User Registry hive. The main purpose is to prevent login by disabled Domain Users, by killing
# any cached credentials. It will log out any active users first. Special users are exempted by design and necessity.

# CAUTION: THIS SCRIPT CAN BE DANGEROUS! MAKE SURE YOU KNOW WHAT YOU ARE DOING.

# Force logout of any active user
(Get-WmiObject -Class Win32_OperatingSystem).Win32Shutdown(4)

# Delete profile in registry for all domain users to prevent login with cached credentials
Get-WmiObject -Class Win32_UserProfile | Where {(!$_.Special) -and (!$_.Loaded)} | Remove-WmiObject
