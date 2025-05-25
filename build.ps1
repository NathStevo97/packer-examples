param(
    [ValidateSet("verify", "build", "")]
    [string]$Action = "",

    [ValidateSet(0, 1)]
    [int]$Log = 0,

    [string]$Template = "",

    [string]$Version = "",

    [ValidateSet("vmware-iso", "virtualbox-iso", "hyperv-iso", "qemu")]
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
$var_file = "./variables/$Template/$Template-$Version.pkrvars.hcl"
$template_file = "./templates/$Template/$Template.pkr.hcl"

# Get Start Time
$startDTM = (Get-Date)

# Variables
$env:PACKER_LOG_PATH="packerlog-$Template-$Version.txt"
packer init "required_plugins.pkr.hcl"

$machine="$Template - $Version"

Write-Host "Start Time: = $startDTM" -ForegroundColor Yellow

if ((Test-Path -Path "$Template_file")) {
  Write-Output "Template file found"
  Write-Output "Building: $machine"
  try {
    $env:PACKER_LOG=$packer_log
    packer validate -var-file="$var_file" -only="$Provider.$template" "$template_file"
  }
  catch {
    Write-Output "Packer validation failed, exiting."
    exit (-1)
  }
  try {
    $env:PACKER_LOG=$packer_log
    packer version
    packer build -var-file="$var_file" -only="$Provider.$template" --force "$template_file"
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