
variable "boot_wait" {
  type    = string
  default = "10s"
}

variable "disk_size" {
  type    = string
  default = "61440"
}

variable "iso_checksum" {
  type    = string
  default = "D5B2F95E3DD658517FE7C14DF4F36DE633CA4845"
}

variable "iso_url" {
  type    = string
  default = "../../ISOs/SW_DVD5_WIN_ENT_LTSC_2019_64-bit_English_MLF_X21-96425.ISO"
}

variable "memsize" {
  type    = string
  default = "2048"
}

variable "numvcpus" {
  type    = string
  default = "2"
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
  default = "Default Switch"
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
  default = "Win10"
}

variable "winrm_password" {
  type    = string
  default = "packer"
}

variable "winrm_username" {
  type    = string
  default = "Administrator"
}

########################################################
#                 Hyper-V Gen 1 Builder                #
########################################################

source "hyperv-iso" "hv1-win10" {
  boot_wait   = "${var.boot_wait}"
  communicator      = "winrm"
  disk_size         = "${var.disk_size}"
  floppy_files        = ["./Files/bios/win10/autounattend.xml", "./Files/scripts/update-windows.ps1", "./Files/scripts/configure-winrm.ps1"]
  generation        = "1"
  headless          = false
  iso_checksum      = "${var.iso_checksum}"
  iso_url           = "${var.iso_url}"
  shutdown_command  = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  skip_compaction   = false
  switch_name       = "${var.switch_name}"
  winrm_password    = "${var.winrm_password}"
  winrm_timeout     = "6h"
  winrm_username    = "${var.winrm_username}"
}

########################################################
#                 VMWare Builder                       #
########################################################

source "vmware-iso" "vmware-win10" {
  boot_wait   = "${var.boot_wait}"
  communicator      = "winrm"
  disk_size         = "${var.disk_size}"
  floppy_files        = ["./Files/bios/win10/autounattend.xml", "./Files/scripts/update-windows.ps1", "./Files/scripts/configure-winrm.ps1"]
  guest_os_type       = "windows9-64"
  headless            = false
  iso_checksum        = "${var.iso_checksum}"
  iso_url             = "${var.iso_url}"
  skip_compaction     = false
  #tools_upload_flavor = "windows"
  #tools_upload_path   = "c:/Windows/Temp/windows.iso"
  vmx_data = {
    "gui.fitguestusingnativedisplayresolution" = "FALSE"
    memsize                                    = "${var.memsize}"
    numvcpus                                   = "${var.numvcpus}"
    "scsi0.virtualDev"                         = "lsisas1068"
    "virtualHW.version"                        = "10"
  }
  winrm_password    = "${var.winrm_password}"
  winrm_timeout     = "6h"
  winrm_username    = "${var.winrm_username}"
}
}

build {
  sources = ["source.hyperv-iso.hv1-win10", "source.vmware-iso.vmware-win10"]

}
