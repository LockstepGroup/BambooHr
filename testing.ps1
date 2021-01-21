[CmdletBinding()]
Param (
)
$ThisModulePath = Join-Path (Resolve-Path ./) (Split-Path (Resolve-Path ./) -Leaf)
ipmo $ThisModulePath -Force

Connect-BambooHrServer

$Employees = Get-BambooHrEmployee
$TimeOffRequests = Get-BambooHrTimeOffRequest