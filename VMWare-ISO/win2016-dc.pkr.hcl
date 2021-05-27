variable "boot_wait" {
  type    = string
  default = "5s"
}
variable "iso_checksum" {
  type    = string
  default = "70721288bbcdfe3239d8f8c0fae55f1f"
}

variable "iso_url" {
  type    = string
  default = "../../../ISOs/Windows Server/2016/Windows_Server_2016_Datacenter_EVAL_en-us_14393_refresh.ISO"
}

variable "memsize" {
  type    = string
  default = "2048"
}

variable "numvcpus" {
  type    = string
  default = "2"
}

variable "vm_name" {
  type    = string
  default = "Win2016_Standard"
}

variable "winrm_password" {
  type    = string
  default = "packer"
}

variable "winrm_username" {
  type    = string
  default = "Administrator"
}

variable "disk_size" {
  type    = string
  default = "40960"
}
# "timestamp" template function replacement
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "vmware-iso" "win2016-datacenter" {
  communicator         = "winrm"
  floppy_files         = ["scripts/bios/win2016/DC/autounattend.xml", "scripts/winrm.ps1"]
  iso_checksum         = "md5:${var.iso_checksum}"
  iso_url              = "${var.iso_url}"
  disk_size        = "${var.disk_size}"
  shutdown_timeout     = "15m"
  vm_name              = "2016min-datacenter"
  winrm_password       = "vagrant"
  winrm_timeout        = "12h"
  winrm_username       = "vagrant"
  vmx_data = {
    memsize             = "${var.memsize}"
    numvcpus            = "${var.numvcpus}"
    "scsi0.virtualDev"  = "lsisas1068"
    "virtualHW.version" = "14"
  }
}

build {
  sources = ["source.vmware-iso.win2016-datacenter"]


  provisioner "powershell" {
    elevated_password = "vagrant"
    elevated_user     = "vagrant"
    scripts = ["scripts/vmware-tools.ps1"]
  }

  provisioner "powershell" {
    elevated_password = "vagrant"
    elevated_user     = "vagrant"
    scripts = ["scripts/setup.ps1"]
  }
  
  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

   
  provisioner "powershell" {
    elevated_password = "vagrant"
    elevated_user     = "vagrant"
    scripts = ["scripts/win-update.ps1"]
  }
  provisioner "windows-restart" {
    restart_timeout = "30m"
  }
  
  provisioner "powershell" {
    elevated_password = "vagrant"
    elevated_user     = "vagrant"
    scripts = ["scripts/win-update.ps1"]
  }
  provisioner "windows-restart" {
    restart_timeout = "30m"
  }
  provisioner "powershell" {
    scripts = ["../../Testing/illumio_install.ps1"]
  }
}