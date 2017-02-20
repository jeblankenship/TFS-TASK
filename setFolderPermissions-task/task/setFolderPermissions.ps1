[CmdletBinding()]
param(
    [string]$server,
    [string] $path,
    [string] $user,
    [string] $rights,
    [string] $inheritanceFlags,
    [string] $propagationFlags,
    [string] $accessControlType
)

Import-Module "Microsoft.TeamFoundation.DistributedTask.Task.Internal"
Import-Module "Microsoft.TeamFoundation.DistributedTask.Task.Common"

Write-Verbose "Entering script $($MyInvocation.MyCommand.Name)"
Write-Verbose "Parameter Values"
$PSBoundParameters.Keys | % { Write-HOST "  ${_} = $($PSBoundParameters[$_])" }

$command = {
    param(
        [string] $path,
        [string] $user,
        [string] $rights,
        [string] $inheritanceFlags,
        [string] $propagationFlags,
        [string] $accessControlType
    )
    Write-Host "Set Folder Permissions Task: Started"
    $Acl = Get-ACL $path
    # See the page below for links to values
    #https://msdn.microsoft.com/en-us/library/ms147785(v=vs.110).aspx
    $AccessRule= New-Object System.Security.AccessControl.FileSystemAccessRule($user,$rights,$inheritanceFlags,$propagationFlags,$accessControlType)
    $Acl.AddAccessRule($AccessRule)
    Set-Acl $path $Acl
    Write-Host "Set Folder Permissions Task: Completed"
}

Invoke-Command -ComputerName $server $command -ArgumentList $path,$user,$rights,$inheritanceFlags,$propagationFlags, $accessControlType