
variable "boot_wait" {
  type    = string
  default = "2m"
}

variable "disk_size" {
  type    = string
  default = "61440"
}

variable "iso_checksum" {
  type    = string
  default = "e8b1d2a1a85a09b4bf6154084a8be8e3c814894a15a7bcf3e8e63fcfa9a528cb"
}

variable "iso_path" {
  type    = string
  default = "../../ISOs/Windows/11/22000.194.210913-1444.co_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_en-us.iso"
}

variable "iso_url" {
  type    = string
  default = "https://software-download.microsoft.com/download/sg/22000.194.210913-1444.co_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_en-us.iso"
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

variable "upgrade_timeout" {
  type    = string
  default = ""
}

variable "vm_name" {
  type    = string
  default = "Win11"
}

variable "winrm_password" {
  type    = string
  default = "vagrant"
}

variable "winrm_username" {
  type    = string
  default = "vagrant"
}

########################################################
#                 VMWare Builder                       #
########################################################

source "vmware-iso" "vmware-win11" {
  boot_wait       = "${var.boot_wait}"
  communicator    = "winrm"
  cpus            = "${var.numvcpus}"
  disk_adapter_type = "lsisas1068"
  disk_size       = "${var.disk_size}"
  floppy_files    = ["./Files/bios/win11/autounattend.xml", "./Files/scripts/update-windows.ps1", "./Files/scripts/configure-winrm.ps1"]
  #floppy_files    = ["./Files/bios/win11/autounattend.xml","./Files/scripts/win11_winrm.ps1" ] 
  guest_os_type   = "windows9-64"
  headless        = false
  iso_checksum    = "${var.iso_checksum}"
  iso_urls        = ["${var.iso_path}", "${var.iso_url}"]
  memory          = "${var.memsize}"
  skip_compaction = false
  #tools_upload_flavor = "windows"
  #tools_upload_path   = "c:/Windows/Temp/windows.iso"
  version        = "19"
  winrm_password = "${var.winrm_password}"
  winrm_timeout  = "6h"
  winrm_username = "${var.winrm_username}"
}

build {
  sources = ["source.vmware-iso.vmware-win11"]

}
