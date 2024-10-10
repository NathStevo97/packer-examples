<#
.SYNOPSIS
This script validates and builds Packer templates based on the specified parameters.

.DESCRIPTION
The script accepts three parameters: Action, Log, and Version. Based on these parameters, it performs actions like validating and building Packer templates. It also sets the PACKER_LOG environment variable to control Packer's logging behavior.

.PARAMETER Action
Specifies the action to be performed. It can be:
- "verify": Only validates the Packer template.
- "build": Validates and then builds the Packer template (default action).

.PARAMETER Log
Controls the logging behavior of Packer. It can be:
- 0: Disables logging (default).
- 1: Enables logging.

.PARAMETER Version
Specifies the version of the template to be used. If not specified, it defaults to "rockylinux-8.8".

.PARAMETER Type
Specify the type of Windows Server - Standard or Datacenter

.PARAMETER Template
Specifies the path to the Packer template to be used. If not specified, it defaults to "templates/hv_rhel.pkr.hcl".

.PARAMETER Provider
Specifies the path to the Packer template to be used. If not specified, it defaults to "templates/hv_rhel.pkr.hcl".

.PARAMETER Generation
Specify the Hyper-V VM Generation (1 or 2)
#>

param(
    [ValidateSet("verify", "build", "")]
    [string]$Action = "",

    [ValidateSet(0, 1)]
    [int]$Log = 0,

    [string]$Template = "",

    [ValidateSet("10", "11")]
    [string]$Version = "",

    [ValidateSet("hyperv-iso", "virtualbox-iso", "vmware-iso")]
    [string]$Provider = "",

    [ValidateSet("1", "2")]
    [string]$Generation = ""
)

# Set default values if parameters are not specified
if ($Action -eq "") {
    $Action = "build"
}

if ($Log -eq 1) {
    $PACKER_LOG = 1
} else {
    $PACKER_LOG = 0
}

if ($Template -eq "") {
    $Template = "windows"
}

if ($Version -eq "") {
    $Version = "10"
}

if ($Provider -eq "") {
    $Provider = "virtualbox-iso"
}

if ($Generation -eq "") {
  $Generation = "2"
}

# Define other variables
$var_file = "variables/$Template-$Version.pkrvars.hcl"
$template = "templates/$Template.pkr.hcl"

# Get Start Time
$startDTM = (Get-Date)

# Variables
$env:PACKER_LOG_PATH="packerlog-windows-$Version.txt"
packer init "../required_plugins.pkr.hcl"

$machine="Windows $Version $Type"

Write-Host "Start Time: = $startDTM" -ForegroundColor Yellow

if ((Test-Path -Path "$template")) {
  Write-Output "Template file found"
  Write-Output "Building: $machine"
  try {
    $env:PACKER_LOG=$packer_log
    if (( $Provider -eq "hyperv-iso")) {
      if (( $Version -eq "11" -And $Generation -eq "1")) {
        Write-Output "Windows 11 is not Supported for Generation 1 VMs - Please Update to Generation 2"
        exit (-1)
      }
      packer validate -var-file="$var_file" -only="$Provider.hv$Generation-windows" "$template"
    }
    else {
      packer validate -var-file="$var_file" -only="$Provider.windows" "$template"
    }
  }
  catch {
    Write-Output "Packer validation failed, exiting."
    exit (-1)
  }
  try {
    $env:PACKER_LOG=$packer_log
    packer version
    if (( $Provider -eq "hyperv-iso")) {
      packer build -var-file="$var_file" -only="$Provider.hv$Generation-windows" --force "$template"
    }
    else {
      packer build -var-file="$var_file" -only="$Provider.windows" --force "$template"
    }
  }
  catch {
    Write-Output "Packer build failed, exiting."
    exit (-1)
  }
}
else {
  Write-Output "Template or Var file not found - exiting"
  exit (-1)
}

$endDTM = (Get-Date)
Write-Host "[INFO]  - Elapsed Time: $(($endDTM-$startDTM).totalseconds) seconds" -ForegroundColor Yellow