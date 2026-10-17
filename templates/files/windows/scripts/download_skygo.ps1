# PowerShell script to download SkyGoInstaller.exe

$url = "https://desktopclient.ott.sky.com/skygodesktop/GB/SkyGoInstaller.exe"
# Construct the download path for ~/Downloads
$downloadPath = "$env:USERPROFILE\Downloads\SkyGoInstaller.exe"

Write-Host "Starting download of SkyGoInstaller.exe..."
Write-Host "Source URL: $url"
Write-Host "Destination Path: $downloadPath"

try {
    Invoke-WebRequest -Uri $url -OutFile $downloadPath
    Write-Host "Successfully downloaded and saved SkyGoInstaller.exe to $downloadPath"
}
catch {
    Write-Error "Failed to download the file. Error: $($_.Exception.Message)"
}
