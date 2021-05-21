variable "boot_wait" {
  type    = string
  default = "5s"
}

variable "disk_size" {
  type    = string
  default = "40960"
}

variable "iso_checksum" {
  type    = string
  default = "70721288bbcdfe3239d8f8c0fae55f1f" #MD5 Checksum
}

variable "iso_checksum_type" {
    type = string
    default = "md5"
}

variable "iso_url" {
  type    = string
  default = "https://software-download.microsoft.com/download/pr/Windows_Server_2016_Datacenter_EVAL_en-us_14393_refresh.ISO"
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
  default = "Win2016_STD"
}

variable "winrm_password" {
  type    = string
  default = "packer"
}

variable "winrm_username" {
  type    = string
  default = "Administrator"
}

# "timestamp" template function replacement
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "vmware-iso" "win2016-STD" {
  boot_wait        = "${var.boot_wait}"
  communicator     = "winrm"
  #disk_size        = "${var.disk_size}"
  disk_type_id     = "0"
  floppy_files     = ["scripts/bios/win2016/Std/autounattend.xml", "scripts/winrm.ps1"]
  guest_os_type    = "windows8srv-64"
  headless         = false
  iso_checksum     = "${var.iso_checksum_type}:${var.iso_checksum}"
  iso_url          = "${var.iso_url}"
  shutdown_command = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  shutdown_timeout = "30m"
  skip_compaction  = false
  vm_name          = "${var.vm_name}"
  vmx_data = {
    memsize             = "${var.memsize}"
    numvcpus            = "${var.numvcpus}"
    #"scsi0.virtualDev"  = "lsisas1068"
    #"virtualHW.version" = "14"
  }
  winrm_insecure = true
  winrm_password = "${var.winrm_password}"
  winrm_timeout  = "4h"
  winrm_use_ssl  = true
  winrm_username = "${var.winrm_username}"
}

build {
  sources = ["source.vmware-iso.win2016-STD"]

  provisioner "powershell" {
    only    = ["vmware-iso"]
    scripts = ["scripts/vmware-tools.ps1"]
  }

  provisioner "powershell" {
    scripts = ["scripts/setup.ps1"]
  }
   
  provisioner "windows-restart" {
    restart_timeout = "30m"
  }
  provisioner "powershell" {
    scripts = ["scripts/win-update.ps1"]
  }
  provisioner "windows-restart" {
    restart_timeout = "30m"
  }
  
  provisioner "powershell" {
    scripts = ["scripts/win-update.ps1"]
  }
  provisioner "windows-restart" {
    restart_timeout = "30m"
  }
 /*  
  provisioner "powershell" {
    scripts = ["scripts/cleanup.ps1"]
  }
  */
}