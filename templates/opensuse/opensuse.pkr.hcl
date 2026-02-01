variable "boot_command" {
  type    = list(string)
  default = []
}

variable "boot_wait" {
  type    = string
  default = "10s"
}

variable "cpu" {
  type    = string
  default = "2"
}

variable "disk_size" {
  type    = string
  default = "70000"
}

variable "guest_os_type_vmware" {
  type    = string
  default = ""
}

variable "guest_os_type_vbox" {
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

variable "iso_url" {
  type    = string
  default = ""
}

variable "name" {
  type    = string
  default = "opensuse-15"
}

variable "ram" {
  type    = string
  default = "4096"
}

variable "ssh_password" {
  type    = string
  default = "vagrant"
}

variable "ssh_username" {
  type    = string
  default = "vagrant"
}

source "vmware-iso" "opensuse" {
  boot_command     = var.boot_command
  boot_wait        = var.boot_wait
  cpus             = var.cpu
  disk_size        = var.disk_size
  guest_os_type    = var.guest_os_type_vmware
  headless         = var.headless
  http_directory   = var.http_directory
  iso_checksum     = var.iso_checksum
  iso_url          = var.iso_url
  memory           = var.ram
  output_directory = "./builds/${var.name}-vmware"
  shutdown_command = "echo '${var.ssh_password}' |sudo -S /sbin/halt -h -p"
  ssh_password     = var.ssh_password
  ssh_port         = 22
  ssh_timeout      = "6h"
  ssh_username     = var.ssh_username
  vm_name          = "${var.name}-vmware"
}

/*
Deprecated Sources
*/

# DEPRECATED: VirtualBox - conflicts with KVM on Linux
# source "virtualbox-iso" "opensuse" {
#   boot_command           = var.boot_command
#   boot_wait              = var.boot_wait
#   cpus                   = var.cpu
#   disk_size              = var.disk_size
#   guest_os_type          = var.guest_os_type_vbox
#   headless               = var.headless
#   http_directory         = var.http_directory
#   iso_checksum           = var.iso_checksum
#   iso_url                = var.iso_url
#   memory                 = var.ram
#   output_directory       = "./builds/${var.name}-vbox"
#   shutdown_command       = "sudo shutdown -h now"
#   ssh_password           = var.ssh_password
#   ssh_port               = 22
#   ssh_read_write_timeout = "600s"
#   ssh_timeout            = "120m"
#   ssh_username           = var.ssh_username
#   vboxmanage             = [["modifyvm", "{{ .Name }}", "--cpu-profile", "host"], ["modifyvm", "{{ .Name }}", "--nat-localhostreachable1", "on"]]
#   vm_name                = "${var.name}-virtualbox"
#   vrdp_bind_address      = "0.0.0.0"
#   vrdp_port_max          = 6000
#   vrdp_port_min          = 5900
# }

build {
  sources = ["source.vmware-iso.opensuse"]
}
