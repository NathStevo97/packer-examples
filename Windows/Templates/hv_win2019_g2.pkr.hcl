#################################################
#Variables
#################################################

variable "disk_size" {
  type    = string
  default = ""
}

variable "iso_checksum" {
  type    = string
  default = ""
}

variable "iso_checksum_type" {
  type    = string
  default = ""
}

variable "iso_url" {
  type    = string
  default = ""
}

variable "output_directory" {
  type    = string
  default = ""
}

variable "secondary_iso_image" {
  type    = string
  default = ""
}

variable "switch_name" {
  type    = string
  default = ""
}

variable "sysprep_unattended" {
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

#################################################
#Builder Sources
#################################################
source "hyperv-iso" "winserver2019" {
  boot_command          = ["a<enter><wait>a<enter><wait>a<enter><wait>a<enter>"]
  boot_wait             = "1s"
  communicator          = "winrm"
  cpus                  = 2
  disk_size             = "${var.disk_size}"
  enable_dynamic_memory = "true"
  enable_secure_boot    = false
  generation            = 2
  guest_additions_mode  = "disable"
  #iso_checksum          = "${var.iso_checksum_type}:${var.iso_checksum}"
  iso_checksum         = "${var.iso_checksum}"
  iso_url              = "${var.iso_url}"
  memory               = 2048
  output_directory     = "${var.output_directory}"
  secondary_iso_images = ["${var.secondary_iso_image}"]
  shutdown_timeout     = "30m"
  skip_export          = true
  switch_name          = "${var.switch_name}"
  temp_path            = "."
  vlan_id              = "${var.vlan_id}"
  vm_name              = "${var.vm_name}"
  winrm_password       = "packer"
  winrm_timeout        = "4h"
  winrm_username       = "Administrator"
}

#################################################
#Building and Provisioners
#################################################
build {
  sources = ["source.hyperv-iso.winserver2019"]

  provisioner "powershell" {
    scripts = ["./Files/scripts/setup.ps1"]
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

  provisioner "powershell" {
    scripts = ["./Files/scripts/win-update.ps1"]
  }
  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

  provisioner "powershell" {
    scripts = ["./Files/scripts/win-update.ps1"]
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }
}
