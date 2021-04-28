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
  default = "3022424f777b66a698047ba1c37812026b9714c5"
}

variable "iso_url" {
  type    = string
  default = "https://software-download.microsoft.com/download/pr/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"
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
  default = "Win2019_17763"
}

variable "winrm_password" {
  type    = string
  default = "packer"
}

variable "winrm_username" {
  type    = string
  default = "Administrator"
}

source "hyperv-iso" "win2019" {
  boot_wait        = "${var.boot_wait}"
  communicator     = "winrm"
  disk_size        = "61440"
  #disk_type_id     = "0"
  floppy_files     = ["scripts/bios/gui/autounattend.xml"]
  guest_os_type    = "windows9srv-64"
  headless         = false
  http_directory   = "http"
  iso_checksum     = "${var.iso_checksum}"
  iso_url          = "${var.iso_url}"
  shutdown_command = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  shutdown_timeout = "30m"
  skip_compaction  = false
  vm_name          = "${var.vm_name}"
  memsize             = "4096"
  numvcpus            = "2"
  winrm_insecure = true
  winrm_password = "${var.winrm_password}"
  winrm_timeout  = "4h"
  winrm_use_ssl  = true
  winrm_username = "${var.winrm_username}"
}

build {
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