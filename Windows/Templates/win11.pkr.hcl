
variable "boot_wait" {
  type    = string
  default = "60s"
}

variable "disk_size" {
  type    = string
  default = "61440"
}

variable "iso_checksum" {
  type    = string
  default = "md5:1f7840814b672457482ae77a70ace03f"
}

variable "iso_path" {
  type    = string
  default = "../../../../Downloads/Win11_English_x64v1.iso"
}

variable "iso_url" {
  type    = string
  default = "https://software-download.microsoft.com/db/Win11_English_x64v1.iso?t=b5e15b66-1f53-4ac8-8934-4f8704a4ce92&e=1639914163&h=b1f45d2851313ae5cbc38f15543caa36"
}

variable "memsize" {
  type    = string
  default = "4096"
}

variable "numvcpus" {
  type    = string
  default = "4"
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
  default = "Password"
}

variable "winrm_username" {
  type    = string
  default = "Administrator"
}


source "vmware-iso" "vmware-win11" {
  boot_wait       = "${var.boot_wait}"
  communicator    = "winrm"
  disk_size       = "${var.disk_size}"
  floppy_files    = ["./Files/bios/win11/autounattend.xml", "./Files/scripts/update-windows.ps1", "./Files/scripts/configure-winrm.ps1"]
  guest_os_type   = "windows11-64"
  headless        = false
  iso_checksum    = "${var.iso_checksum}"
  iso_urls        = ["${var.iso_path}", "${var.iso_url}"]
  skip_compaction = false
  #tools_upload_flavor = "windows"
  #tools_upload_path   = "c:/Windows/Temp/windows.iso"
  vmx_data = {
    memsize                                    = "${var.memsize}"
    numvcpus                                   = "${var.numvcpus}"
    #"scsi0.virtualDev"                         = "lsisas1068"
    "virtualHW.version"                        = "11"
  }
  winrm_password = "${var.winrm_password}"
  winrm_timeout  = "6h"
  winrm_username = "${var.winrm_username}"
}

build {
  sources = ["source.vmware-iso.vmware-win11"]

  provisioner "windows-shell" {
    inline = ["dir c:\\"]
  }

}
