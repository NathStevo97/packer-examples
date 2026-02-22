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

variable "http_port_min" {
  type    = string
  default = "9000"
}

variable "http_port_max" {
  type    = string
  default = "9000"
}

variable "iso_checksum" {
  type    = string
  default = "4683345f242397c7fd7d89a50731a120ffd60a24460e21d2634e783b3c169695"
}

variable "iso_url" {
  type    = string
  default = "http://downloadcontent.opensuse.org/distribution/leap/15.4/iso/openSUSE-Leap-15.4-DVD-x86_64-Build243.2-Media.iso"
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
  http_port_min    = var.http_port_min
  http_port_max    = var.http_port_max
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

source "qemu" "opensuse" {
  boot_command     = var.boot_command
  boot_wait        = "5s"
  cpus             = var.cpu
  disk_size        = var.disk_size
  disk_interface   = "virtio" # use virtio as virtio-scsi is not supported by opensuse with qemu
  headless         = var.headless
  http_directory   = var.http_directory
  http_port_min    = var.http_port_min
  http_port_max    = var.http_port_max
  iso_checksum     = var.iso_checksum
  iso_url          = var.iso_url
  memory           = var.ram
  output_directory = "./builds/${var.name}-qemu"
  qemuargs = [
    # ["-cpu", "Nehalem"], # set to "host" for linux-based packer execution
    ["-cpu", "host,+nx"], # set to "Nehalem" for windows-based packer execution
    ["-netdev", "user,hostfwd=tcp::{{ .SSHHostPort }}-:22,id=forward"],
    ["-device", "virtio-net,netdev=forward,id=net0"]
  ]
  shutdown_command = "echo '${var.ssh_password}'|sudo -S shutdown -P now"
  ssh_password     = var.ssh_password
  ssh_port         = 22
  ssh_timeout      = "6h"
  ssh_username     = var.ssh_username
  vm_name          = "${var.name}-qemu"
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
  sources = ["source.vmware-iso.opensuse", "source.qemu.opensuse"]
}
