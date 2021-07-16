# This script adds Everyone - FullControl permissions to the file or folder specified. Can be adjusted as needed 
# and is typically run from PowerShell directly, or can be copied into a script for use as part of a larger operation.
# TODO: Add parameters and format correctly with header etc.
$FolderName = "C:\Temp\test-file.txt"
$ACL = Get-ACL -Path $FileName
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Everyone","FullControl","Allow")
$ACL.SetAccessRule($AccessRule)
$ACL | Set-Acl -Path $FileName
#Debug output - File Permission
(Get-ACL -Path $FileName).Access | Format-Table IdentityReference,FileSystemRights,AccessControlType,IsInherited,InheritanceFlags -AutoSize
