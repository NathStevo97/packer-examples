variable "iso_checksum" {
  type    = string
  default = "3022424f777b66a698047ba1c37812026b9714c5"
}

variable "iso_url" {
  type    = string
  default = "../../../ISOs/Windows Server/2019/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"
}

source "hyperv-iso" "win2019-DC" {
  communicator = "winrm"
  cpus         = 1
  disk_size    = 40960
  floppy_files         = ["./Files/bios/win2019/DC/autounattend.xml", "./Files/scripts/winrmConfig.ps1"]
  guest_additions_mode = "disable"
  iso_checksum         = "${var.iso_checksum}"
  iso_url              = "${var.iso_url}"
  memory               = 2048
  shutdown_timeout     = "15m"
  switch_name          = "Default Switch"
  vm_name              = "2019min-DC"
  winrm_password       = "packer"
  winrm_timeout        = "12h"
  winrm_username       = "Administrator"
}

build {
  sources = ["source.hyperv-iso.win2019-DC"]
  
  provisioner "powershell" {
    only    = ["vmware-iso"]
    scripts = ["./Files/scripts/vmware-tools.ps1"]
  }

  provisioner "powershell" {
    scripts = ["./Files/scripts/setup.ps1"]
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }
  /*  
  provisioner "powershell" {
    elevated_password = "packer"
    elevated_user     = "Administrator"
    script            = "./Files/scripts/win-update.ps1"
  }

  provisioner "windows-restart" {
    restart_timeout = "15m"
  }
  provisioner "powershell" {
    scripts = ["../../../../Testing/illumio_install.ps1"]
  }
*/
}