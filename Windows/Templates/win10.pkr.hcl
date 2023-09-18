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

variable "secondary_iso_image" {
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

########################################################
#                 Hyper-V Gen 1 Builder                #
########################################################

source "hyperv-iso" "hv1-win10" {
  boot_wait        = "${var.boot_wait}"
  communicator     = "winrm"
  disk_size        = "${var.disk_size}"
  floppy_files     = "${var.floppy_files}"
  generation       = "1"
  headless         = "${var.headless}"
  iso_checksum     = "${var.iso_checksum}"
  iso_urls         = ["${var.iso_path}", "${var.iso_url}"]
  memory           = "${var.memsize}"
  output_directory      = "${var.output_directory}-hv1"
  shutdown_command = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  skip_compaction  = false
  switch_name      = "${var.switch_name}"
  winrm_password   = "${var.winrm_password}"
  winrm_timeout    = "${var.winrm_timeout}"
  winrm_username   = "${var.winrm_username}"
}

########################################################
#                 Hyper-V Gen 2 Builder                #
########################################################

source "hyperv-iso" "hv2-win10" {
  boot_command         = "${var.boot_command}"
  boot_wait            = "${var.boot_wait_hyperv}"
  communicator         = "winrm"
  disk_size            = "${var.disk_size}"
  generation           = "2"
  headless             = "${var.headless}"
  iso_checksum         = "${var.iso_checksum}"
  iso_urls             = ["${var.iso_path}", "${var.iso_url}"]
  secondary_iso_images = ["${var.secondary_iso_image}"]
  memory               = "${var.memsize}"
  output_directory      = "${var.output_directory}-hv2"
  shutdown_command     = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  skip_compaction      = false
  shutdown_timeout     = "2h"
  skip_export          = true
  temp_path            = "."
  vlan_id              = "${var.vlan_id}"
  switch_name          = "${var.switch_name}"
  winrm_password       = "${var.winrm_password}"
  winrm_timeout        = "${var.winrm_timeout}"
  winrm_username       = "${var.winrm_username}"
}

########################################################
#                 VMWare Builder                       #
########################################################

source "vmware-iso" "vmware-win10" {
  boot_wait       = "${var.boot_wait}"
  communicator    = "winrm"
  disk_size       = "${var.disk_size}"
  floppy_files    = "${var.floppy_files}"
  guest_os_type   = "${var.guest_os_type_vmware}"
  headless        = "${var.headless}"
  iso_checksum    = "${var.iso_checksum}"
  iso_urls        = ["${var.iso_path}", "${var.iso_url}"]
  output_directory      = "${var.output_directory}-vmware"
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
  winrm_timeout  = "${var.winrm_timeout}"
  winrm_username = "${var.winrm_username}"
}

#################################################################
#                    Virtualbox-ISO Builder                     #
#################################################################

source "virtualbox-iso" "vbox-win10" {
  communicator         = "winrm"
  disk_size            = "${var.disk_size}"
  floppy_files         = "${var.floppy_files}"
  guest_additions_mode = "disable"
  #guest_additions_path = "c:/Windows/Temp/windows.iso"
  guest_os_type        = "${var.guest_os_type_virtualbox}"
  hard_drive_interface = "sata"
  headless             = "${var.headless}"
  iso_checksum         = "${var.iso_checksum}"
  iso_interface        = "sata"
  iso_urls             = ["${var.iso_path}", "${var.iso_url}"]
  output_directory      = "${var.output_directory}-vbox"
  shutdown_command     = "shutdown /s /t 0 /f /d p:4:1 /c \"Packer Shutdown\""
  vboxmanage           = [
    ["modifyvm", "{{ .Name }}", "--memory", "${var.memsize}"],
    ["modifyvm", "{{ .Name }}", "--cpus", "${var.numvcpus}"],
    ["modifyvm", "{{ .Name }}", "--vram", "32"],
    ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]
  ]
  winrm_insecure       = true
  winrm_password       = "${var.winrm_password}"
  winrm_timeout        = "${var.winrm_timeout}"
  winrm_username       = "${var.winrm_username}"
}

build {
  sources = ["source.hyperv-iso.hv1-win10", "source.hyperv-iso.hv2-win10", "source.vmware-iso.vmware-win10", "source.virtualbox-iso.vbox-win10"]

}
