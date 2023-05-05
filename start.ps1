# Get the names of all the directories and write them to a Hash Table (in case any new ones get added)
# Write out numbered list of OS system choices based on above
# Request user input (select number) to determine the OS desired
# Depending on the OS selected; navigate to the desired directory
# Get the list of all available plugins that can be used for the OS (get unique prefixes)
# Write out numbered list of OS system choices based on above
# Request user input (select number) to determine the plugin desired
# Get the list of all available OS variants for the plugin

<#
.SYNOPSIS
Rename Azure VM Network Interfaces.

.DESCRIPTION
Rename single or multiple Network Adapter interfaces attached to an Azure Virtual Machine (Linux and Windows).

.EXAMPLE
.\Rename-AzVMNIC.ps1 -resourceGroup [ResourceGroupName] -VMName [VMName] -NewNicName [NewNicName] -Subscription [AzSub] -Verbose
This example will rename the NIC interface for the specified VM, you need to specify the Resource Group name, VM name, and the new NIC name.
The script will preserve the old network settings and apply them to the new network interface.
#>

[CmdletBinding()]
Param (
[Parameter(Position = 0, Mandatory = $True, HelpMessage = 'Enter either vmware, hyperv, virtualbox, or qemu')]
[Alias('plugin')]
[String]$packerPlugin,

[Parameter(Position = 1, Mandatory = $False)]
[Alias('gen')]
[String]$generation,

[Parameter(Position = 2, Mandatory = $True, HelpMessage = 'Enter a valid OS variant')]
[Alias('os')]
[String]$osVariant
)

write-host $packerPlugin $generation $osVariant

$filename = $packerPlugin + '_' + $osVariant + '.ps1'

write-host $filename