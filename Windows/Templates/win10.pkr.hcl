
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
  default = "574f00380ead9e4b53921c33bf348b5a2fa976ffad1d5fa20466ddf7f0258964"
}

variable "iso_path" {
  type    = string
  default = "../../ISOs/10240.16384.150709-1700.TH1_CLIENTENTERPRISEEVAL_OEMRET_X64FRE_EN-US.ISO"
}

variable "iso_url" {
  type    = string
  default = "https://software-download.microsoft.com/download/pr/19042.508.200927-1902.20h2_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_en-us.iso"
}

variable "memsize" {
  type    = string
  default = "4096"
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
  default = "./Files/bios/win10/secondary.iso"
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
  boot_wait        = "${var.boot_wait}"
  communicator     = "winrm"
  disk_size        = "${var.disk_size}"
  floppy_files     = ["./Files/bios/win10/autounattend.xml", "./Files/scripts/update-windows.ps1", "./Files/scripts/configure-winrm.ps1"]
  generation       = "1"
  headless         = false
  iso_checksum     = "${var.iso_checksum}"
  iso_urls         = ["${var.iso_path}", "${var.iso_url}"]
  memory                = "${var.memsize}"
  shutdown_command = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  skip_compaction  = false
  switch_name      = "${var.switch_name}"
  winrm_password   = "${var.winrm_password}"
  winrm_timeout    = "6h"
  winrm_username   = "${var.winrm_username}"
}

########################################################
#                 Hyper-V Gen 2 Builder                #
########################################################

source "hyperv-iso" "hv2-win10" {
  boot_command = ["<tab><wait><enter><wait>",
  "a<wait>a<wait>a<wait>a<wait>a<wait>a<wait>"]
  boot_wait             = "120s"
  communicator     = "winrm"
  disk_size        = "${var.disk_size}"
  generation       = "2"
  headless         = false
  iso_checksum     = "${var.iso_checksum}"
  iso_urls         = ["${var.iso_path}", "${var.iso_url}"]
  secondary_iso_images  = ["${var.secondary_iso_image}"]
  memory                = "${var.memsize}"
  shutdown_command = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  skip_compaction  = false
  shutdown_timeout      = "2h"
  skip_export           = true
  temp_path             = "."
  vlan_id               = "${var.vlan_id}"
  switch_name      = "${var.switch_name}"
  winrm_password   = "${var.winrm_password}"
  winrm_timeout    = "6h"
  winrm_username   = "${var.winrm_username}"
}

########################################################
#                 VMWare Builder                       #
########################################################

source "vmware-iso" "vmware-win10" {
  boot_wait       = "${var.boot_wait}"
  communicator    = "winrm"
  disk_size       = "${var.disk_size}"
  floppy_files    = ["./Files/bios/win10/autounattend.xml", "./Files/scripts/update-windows.ps1", "./Files/scripts/configure-winrm.ps1"]
  guest_os_type   = "windows9-64"
  headless        = true
  iso_checksum    = "${var.iso_checksum}"
  iso_urls        = ["${var.iso_path}", "${var.iso_url}"]
  skip_compaction = false
  #tools_upload_flavor = "windows"
  #tools_upload_path   = "c:/Windows/Temp/windows.iso"
  vmx_data = {
    "gui.fitguestusingnativedisplayresolution" = "FALSE"
    memsize                                    = "${var.memsize}"
    numvcpus                                   = "${var.numvcpus}"
    "scsi0.virtualDev"                         = "lsisas1068"
    "virtualHW.version"                        = "10"
  }
  winrm_password = "${var.winrm_password}"
  winrm_timeout  = "6h"
  winrm_username = "${var.winrm_username}"
}

#################################################################
#                    Virtualbox-ISO Builder                     #
#################################################################

source "virtualbox-iso" "vbox-win10" {
  communicator = "winrm"
  disk_size    = 61440
  floppy_files    = ["./Files/bios/win10/autounattend.xml", "./Files/scripts/update-windows.ps1", "./Files/scripts/configure-winrm.ps1"]
  guest_additions_mode = "disable"
  #guest_additions_path = "c:/Windows/Temp/windows.iso"
  guest_os_type        = "Windows10_64"
  hard_drive_interface = "sata"
  headless         = false
  iso_checksum         = "${var.iso_checksum}"
  iso_interface    = "sata"
  iso_urls          = ["${var.iso_path}", "${var.iso_url}"]
  shutdown_command = "shutdown /s /t 0 /f /d p:4:1 /c \"Packer Shutdown\""
  vboxmanage       = [["modifyvm", "{{ .Name }}", "--memory", "${var.memsize}"], ["modifyvm", "{{ .Name }}", "--cpus", "${var.numvcpus}"], ["modifyvm", "{{ .Name }}", "--vram", "32"]]
  winrm_insecure   = true
  winrm_password   = "${var.winrm_password}"
  winrm_timeout    = "4h"
  winrm_username   = "${var.winrm_username}"
}

build {
  sources = ["source.hyperv-iso.hv1-win10", "source.hyperv-iso.hv2-win10", "source.vmware-iso.vmware-win10", "source.virtualbox-iso.vbox-win10"]

}
