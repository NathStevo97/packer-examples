param(
    [ValidateSet("verify", "build", "")]
    [string]$Action = "",

    [ValidateSet(0, 1)]
    [int]$Log = 0,

    [string]$Template = "",

    [string]$Version = "",

    [string]$Type = "",

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

# If Type is specified, adjust var_file path
if ($Type -ne "") {
  $var_file = "./variables/$Template/$Template-$Version-$Type.pkrvars.hcl"
}
else {
  $var_file = "./variables/$Template/$Template-$Version.pkrvars.hcl"
}

# Get Start Time
$startDTM = (Get-Date)

# Variables
$logs_path = ".\logs"
If(!(test-path -PathType container $logs_path))
{
      New-Item -ItemType Directory -Path $logs_path
}
$env:PACKER_LOG_PATH="./logs/packerlog-$Template-$Version.txt"
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
