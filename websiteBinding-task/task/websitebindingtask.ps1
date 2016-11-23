[CmdletBinding()]
param(
    [string]$server,
    [string] $webSiteName,
    [string] $ipAddress,
    [string] $port,
    [string] $hostHeader,
    [string] $protocol,
    [string] $actionType
)

Import-Module "Microsoft.TeamFoundation.DistributedTask.Task.Internal"
Import-Module "Microsoft.TeamFoundation.DistributedTask.Task.Common"

Write-Verbose "Entering script $($MyInvocation.MyCommand.Name)"
Write-Verbose "Parameter Values"
$PSBoundParameters.Keys | % { Write-HOST "  ${_} = $($PSBoundParameters[$_])" }

$command = {
    param(
        [string] $webSiteName,
        [string] $ipAddress,
        [string] $port,
        [string] $hostHeader,
        [string] $protocol,
        [string] $actionType
    )
    Import-Module WebAdministration
    Write-Host "Web Site Binding Task: Started"
    $binding =  Get-WebBinding -Name $webSiteName -IPAddress $ipAddress -Port $port -HostHeader $hostHeader -Protocol $protocol
    if ($actionType -eq 'add') {
        if (-not $binding){
            Write-Host "Creating new binding..."
            New-WebBinding -Name $webSiteName -IPAddress $ipAddress -Port $port -HostHeader $hostHeader -Protocol $protocol
        } else {
            Write-Host "Binding already exist. No changes made."
        }
    } elseif ($actionType -eq 'remove'){
        if ($binding){
            Write-Host "Removing binding..."
            Remove-WebBinding -Name $webSiteName -IPAddress $ipAddress -Port $port -HostHeader $hostHeader -Protocol $protocol
        } else {
            Write-Host "Binding does not exist. No changes made."
        }
    } else {
        Write-Error "Invalid action specified: $action"
    }
    Write-Host "Web Site Binding Task: Completed."
}

Invoke-Command -ComputerName $server $command -ArgumentList $webSiteName,$ipAddress,$port,$hostHeader,$protocol, $actionType