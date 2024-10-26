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

.PARAMETER Template
Specifies the path to the Packer template to be used. If not specified, it defaults to "templates/hv_rhel.pkr.hcl".

.PARAMETER Provider
Specifies the path to the Packer template to be used. If not specified, it defaults to "templates/hv_rhel.pkr.hcl".
#>

param(
    [ValidateSet("verify", "build", "")]
    [string]$Action = "",

    [ValidateSet(0, 1)]
    [int]$Log = 0,

    [string]$Template = "",

    [string]$Version = "",

    [ValidateSet("vmware-iso", "virtualbox-iso", "hyperv-iso")]
    [string]$Provider = ""
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
    $Template = "almalinux"
}

if ($Version -eq "") {
    $Version = "9"
}

if ($Provider -eq "") {
    $Provider = "virtualbox-iso"
}

# Define other variables
$var_file = "variables/$Template-$Version.pkrvars.hcl"
$template = "templates/$Template.pkr.hcl"

# Get Start Time
$startDTM = (Get-Date)

# Variables
$env:PACKER_LOG_PATH="packerlog-almalinux-9.txt"
packer init "../required_plugins.pkr.hcl"

$machine="Alma Linux $Version"

Write-Host "Start Time: = $startDTM" -ForegroundColor Yellow

if ((Test-Path -Path "$template")) {
  Write-Output "Template file found"
  Write-Output "Building: $machine"
  try {
    $env:PACKER_LOG=$packer_log
    packer validate -var-file="$var_file" -only="$Provider.almalinux" "$template"
  }
  catch {
    Write-Output "Packer validation failed, exiting."
    exit (-1)
  }
  try {
    $env:PACKER_LOG=$packer_log
    packer version
    packer build -var-file="$var_file" -only="$Provider.almalinux" --force "$template"
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