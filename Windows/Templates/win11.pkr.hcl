variable "boot_wait" {
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
#                 VMWare Builder                       #
########################################################

source "vmware-iso" "vmware-win11" {
  boot_wait         = "${var.boot_wait}"
  communicator      = "winrm"
  cpus              = "${var.numvcpus}"
  disk_adapter_type = "lsisas1068"
  disk_size         = "${var.disk_size}"
  floppy_files      = "${var.floppy_files}"
  guest_os_type     = "${var.guest_os_type_vmware}"
  headless          = "${var.headless}"
  iso_checksum      = "${var.iso_checksum}"
  iso_urls          = ["${var.iso_path}", "${var.iso_url}"]
  memory            = "${var.memsize}"
  skip_compaction   = false
  #tools_upload_flavor = "windows"
  #tools_upload_path   = "c:/Windows/Temp/windows.iso"
  version        = "19"
  winrm_password = "${var.winrm_password}"
  winrm_timeout  = "${var.winrm_timeout}"
  winrm_username = "${var.winrm_username}"
}

#################################################################
#                    Virtualbox-ISO Builder                     #
#################################################################

source "virtualbox-iso" "vbox-win11" {
  communicator         = "winrm"
  disk_size            = "${var.disk_size}"
  floppy_files         = "${var.floppy_files}"
  guest_additions_mode = "disable"
  #guest_additions_path = "c:/Windows/Temp/windows.iso"
  guest_os_type        = "${var.guest_os_type_virtualbox}"
  hard_drive_interface = "sata"
  headless             = "${var.headless}"
  iso_checksum         = "${var.iso_checksum}"
  iso_interface        = "ide"
  iso_urls             = ["${var.iso_path}", "${var.iso_url}"]
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

########################################################
#                 Hyper-V Gen 1 Builder                #
########################################################

source "hyperv-iso" "hv1-win11" {
  boot_wait        = "${var.boot_wait}"
  communicator     = "winrm"
  disk_size        = "${var.disk_size}"
  floppy_files     = "${var.floppy_files}"
  generation       = "1"
  headless         = "${var.headless}"
  iso_checksum     = "${var.iso_checksum}"
  iso_urls         = ["${var.iso_path}", "${var.iso_url}"]
  memory           = "${var.memsize}"
  shutdown_command = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  skip_compaction  = false
  switch_name      = "${var.switch_name}"
  winrm_password   = "${var.winrm_password}"
  winrm_timeout    = "${var.winrm_timeout}"
  winrm_username   = "${var.winrm_username}"
}

build {
  sources = ["source.vmware-iso.vmware-win11", "source.virtualbox-iso.vbox-win11", "source.hyperv-iso.hv1-win11"]

}
