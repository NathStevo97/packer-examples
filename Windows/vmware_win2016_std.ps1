# Build images

# Get Start Time
$startDTM = (Get-Date)

# Variables
$template_file="./templates/win2016.pkr.hcl"
$var_file="./variables/variables_win2016_std.pkrvars.hcl"
$machine="Windows Server 2016 Standard"
$packer_log=0
$env:PACKER_LOG_PATH="packerlog-2016-STD-vmware.txt"
packer init -upgrade "./required_plugins.pkr.hcl"
#Write start time so you know how long it's been
Write-Host "Start Time: = $startDTM" -ForegroundColor Yellow
if ((Test-Path -Path "$template_file")) {
  Write-Output "Template file found"
  Write-Output "Building: $machine"
  try {
    $env:PACKER_LOG=$packer_log
    #packer validate -var-file="$var_file" "$template_file"
    packer validate -var-file="$var_file" -only='vmware-iso.vmware-win2016' "$template_file"
  }
  catch {
    Write-Output "Packer validation failed, exiting."
    exit (-1)
  }
  try {
    $env:PACKER_LOG=$packer_log
    packer version
    #packer build --force -var-file="$var_file" "$template_file"
    packer build -var-file="$var_file" -only='vmware-iso.vmware-win2016' --force "$template_file"
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
