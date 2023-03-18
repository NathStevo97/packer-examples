# Build images

# Get Start Time
$startDTM = (Get-Date)

# Variables
$template_file="./templates/win2022.pkr.hcl"
$var_file="./variables/variables_win2022_std.pkrvars.hcl"
$machine="Windows Server 2022 Standard Gen-2"
$packer_log=0
$env:PACKER_LOG_PATH="packerlog-2022-STD-hv2.txt"
packer init -upgrade "./required_plugins.pkr.hcl"
#Write start time so you know how long it's been
Write-Host "Start Time: = $startDTM" -ForegroundColor Yellow
if ((Test-Path -Path "$template_file") -and (Test-Path -Path "$var_file")) {
  Write-Output "Template and var file found"
  Write-Output "Building: $machine"
  try {
    $env:PACKER_LOG=$packer_log
    packer validate -var-file="$var_file" -only='hyperv-iso.hv2-win2022' -var-file="$var_file" "$template_file"
  }
  catch {
    Write-Output "Packer validation failed, exiting."
    exit (-1)
  }
  try {
    $env:PACKER_LOG=$packer_log
    packer version
    packer build -var-file="$var_file" -only='hyperv-iso.hv2-win2022' --force -var-file="$var_file" "$template_file"
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
