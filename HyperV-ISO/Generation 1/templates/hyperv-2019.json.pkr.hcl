variable "iso_checksum" {
  type    = string
  default = "549bca46c055157291be6c22a3aaaed8330e78ef4382c99ee82c896426a1cee1"
}

variable "iso_url" {
  type    = string
  default = "https://software-download.microsoft.com/download/pr/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"
}

source "hyperv-iso" "win2019-STD" {
  communicator         = "winrm"
  floppy_files         = ["../extra/files/gen1-2019/std/Autounattend.xml", "../extra/scripts/winrm.ps1"]
  guest_additions_mode = "disable"
  iso_checksum         = "sha256:${var.iso_checksum}"
  iso_url              = "${var.iso_url}"
  memory               = 2048
  shutdown_timeout     = "15m"
  switch_name          = "Default Switch"
  vm_name              = "2019min"
  winrm_password       = "vagrant"
  winrm_timeout        = "12h"
  winrm_username       = "vagrant"
}

build {
  sources = ["source.hyperv-iso.win2019-STD"]

   provisioner "powershell" {
    elevated_password = "vagrant"
    elevated_user     = "vagrant"
    script            = "../extra/scripts/windows-updates.ps1"
  }

  provisioner "windows-restart" {
    restart_timeout = "15m"
  }
}