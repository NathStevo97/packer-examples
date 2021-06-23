variable "iso_checksum" {
  type    = string
  default = "70721288bbcdfe3239d8f8c0fae55f1f"
}

variable "iso_url" {
  type    = string
  default = "https://software-download.microsoft.com/download/pr/Windows_Server_2016_Datacenter_EVAL_en-us_14393_refresh.ISO"
}

source "hyperv-iso" "win2016-STD" {
  communicator         = "winrm"
  floppy_files         = ["../extra/files/gen1-2016/std/autounattend.xml", "../extra/scripts/winrm.ps1"]
  guest_additions_mode = "disable"
  iso_checksum         = "md5:${var.iso_checksum}"
  iso_url              = "${var.iso_url}"
  memory               = 2048
  shutdown_timeout     = "15m"
  switch_name          = "Default Switch"
  vm_name              = "2016min"
  winrm_password       = "vagrant"
  winrm_timeout        = "12h"
  winrm_username       = "vagrant"
}

build {
  sources = ["source.hyperv-iso.win2016-STD"]

   provisioner "powershell" {
    elevated_password = "vagrant"
    elevated_user     = "vagrant"
    script            = "../extra/scripts/windows-updates.ps1"
  }

  provisioner "windows-restart" {
    restart_timeout = "15m"
  }
  provisioner "powershell" {
    scripts = ["../../../../Testing/illumio_install.ps1"]
  }
}