#################################################################
#                           Variables                           #
#################################################################
variable "boot_command" {
  type    = list(string)
  default = []
}

variable "boot_wait" {
  type    = string
  default = ""
}

variable "boot_wait_hyperv" {
  type    = string
  default = ""
}

variable "disk_size" {
  type    = string
  default = ""
}

variable "floppy_files" {
  type    = list(string)
  default = []
}

variable "guest_os_type_virtualbox" {
  type    = string
  default = ""
}

variable "guest_os_type_vmware" {
  type    = string
  default = ""
}

variable "headless" {
  type    = bool
  default = false
}

variable "http_directory" {
  type    = string
  default = ""
}

variable "iso_checksum" {
  type    = string
  default = ""
}

variable "iso_path" {
  type    = string
  default = ""
}

variable "iso_url" {
  type    = string
  default = ""
}

variable "memsize" {
  type    = string
  default = ""
}

variable "numvcpus" {
  type    = string
  default = ""
}

variable "output_directory" {
  type    = string
  default = ""
}

variable "secondary_iso_images" {
  type    = string
  default = ""
}

variable "switch_name" {
  type    = string
  default = ""
}

variable "upgrade_timeout" {
  type    = string
  default = ""
}

variable "vlan_id" {
  type    = string
  default = ""
}

variable "vm_name" {
  type    = string
  default = ""
}

variable "winrm_password" {
  type    = string
  default = ""
}

variable "winrm_timeout" {
  type    = string
  default = ""
}

variable "winrm_username" {
  type    = string
  default = ""
}

source "virtualbox-iso" "windows" {
  boot_wait            = var.boot_wait
  communicator         = "winrm"
  disk_size            = var.disk_size
  floppy_files         = var.floppy_files
  guest_additions_mode = "disable"
  guest_os_type        = var.guest_os_type_virtualbox
  headless             = var.headless
  iso_checksum         = var.iso_checksum
  iso_urls         = [var.iso_path, var.iso_url]
  output_directory     = "${var.output_directory}-vbox"
  shutdown_command     = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  shutdown_timeout     = "30m"
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--memory", "${var.memsize}"],
    ["modifyvm", "{{ .Name }}", "--cpus", "${var.numvcpus}"],
    ["modifyvm", "{{ .Name }}", "--vram", "32"],
    ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]
  ]
  vm_name        = var.vm_name
  winrm_insecure = true
  winrm_password = var.winrm_password
  winrm_timeout  = var.winrm_timeout
  winrm_use_ssl  = true
  winrm_username = var.winrm_username
}

source "vmware-iso" "windows" {
  boot_wait        = var.boot_wait
  communicator     = "winrm"
  cpus             = var.numvcpus
  disk_size        = var.disk_size
  disk_type_id     = "0"
  floppy_files     = var.floppy_files
  guest_os_type    = var.guest_os_type_vmware
  headless         = var.headless
  iso_checksum     = var.iso_checksum
  iso_urls         = [var.iso_path, var.iso_url]
  memory           = var.memsize
  output_directory = "${var.output_directory}-vmware"
  shutdown_command = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  shutdown_timeout = "30m"
  skip_compaction  = false
  vm_name          = "${var.vm_name}-vmware"
  winrm_insecure   = true
  winrm_password   = var.winrm_password
  winrm_timeout    = var.winrm_timeout
  winrm_use_ssl    = true
  winrm_username   = var.winrm_username
}

source "hyperv-iso" "windows" {
  boot_command          = var.boot_command
  boot_wait             = var.boot_wait_hyperv
  communicator          = "winrm"
  cpus                  = var.numvcpus
  disk_size             = var.disk_size
  enable_dynamic_memory = "true"
  enable_secure_boot    = false
  generation            = 2
  guest_additions_mode  = "disable"
  headless              = var.headless
  iso_checksum          = var.iso_checksum
  iso_urls         = [var.iso_path, var.iso_url]
  memory                = var.memsize
  output_directory      = "${var.output_directory}-hv"
  secondary_iso_images  = [var.secondary_iso_images]
  shutdown_timeout      = "2h"
  skip_export           = true
  switch_name           = "Default Switch"
  temp_path             = "."
  vm_name               = "${var.vm_name}-hv"
  winrm_insecure        = true
  winrm_password        = var.winrm_password
  winrm_timeout         = var.winrm_timeout
  winrm_use_ssl         = true
  winrm_username        = var.winrm_username
}

build {
  sources = ["source.virtualbox-iso.windows", "source.vmware-iso.windows", "source.hyperv-iso.windows"]

  /* provisioner "powershell" {
    only         = ["vmware-iso"]
    pause_before = "1m0s"
    scripts      = ["scripts/vmware-tools.ps1"]
  }

  provisioner "powershell" {
    only         = ["virtualbox-iso"]
    pause_before = "1m0s"
    scripts      = ["scripts/virtualbox-guest-additions.ps1"]
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

  provisioner "powershell" {
    pause_before = "1m0s"
    scripts      = ["scripts/cleanup.ps1"]
  }

  */

}
