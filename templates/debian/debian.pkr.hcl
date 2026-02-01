variable "boot_wait" {
  type    = string
  default = "10s"
}

variable "boot_command" {
  type    = list(string)
  default = []
}

variable "boot_command_hyperv" {
  type    = list(string)
  default = []
}

variable "boot_command_qemu" {
  type    = list(string)
  default = []
}

variable "cpu" {
  type    = string
  default = "2"
}

variable "disk_size" {
  type    = string
  default = "70000"
}

variable "guest_os_type_vbox" {
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
  default = ""
}

variable "iso_url" {
  type    = string
  default = ""
}

variable "name" {
  type    = string
  default = ""
}

variable "ram" {
  type    = string
  default = "2048"
}

variable "ssh_password" {
  type    = string
  default = ""
}

variable "ssh_username" {
  type    = string
  default = ""
}

variable "switch_name" {
  type    = string
  default = ""
}

variable "vlan_id" {
  type    = string
  default = ""
}

source "vmware-iso" "debian" {
  boot_command     = var.boot_command
  boot_wait        = var.boot_wait
  cpus             = var.cpu
  disk_size        = var.disk_size
  disk_type_id     = "0"
  firmware         = "efi"
  guest_os_type    = var.guest_os_type_vmware
  headless         = var.headless
  http_directory   = var.http_directory
  http_port_min    = var.http_port_min
  http_port_max    = var.http_port_max
  iso_checksum     = var.iso_checksum
  iso_url          = var.iso_url
  memory           = var.ram
  output_directory = "./builds/${var.name}-vmware"
  shutdown_command = "echo '${var.ssh_password}'|sudo -S /sbin/halt -h -p"
  ssh_password     = var.ssh_password
  ssh_port         = 22
  ssh_timeout      = "1h"
  ssh_username     = var.ssh_username
  vm_name          = "${var.name}-vmware"
}

source "qemu" "debian" {
  boot_command     = var.boot_command_qemu
  boot_wait        = var.boot_wait
  disk_size        = var.disk_size
  headless         = var.headless
  http_directory   = var.http_directory
  iso_checksum     = var.iso_checksum
  iso_url          = var.iso_url
  memory           = var.ram
  output_directory = "./builds/${var.name}-qemu"
  qemuargs = [
    ["-cpu", "Nehalem"], # set to "host" for linux-based packer execution
    ["-netdev", "user,hostfwd=tcp::{{ .SSHHostPort }}-:22,id=forward"],
    ["-device", "virtio-net,netdev=forward,id=net0"]
  ]
  shutdown_command = "echo '${var.ssh_password}'|sudo -S /sbin/halt -h -p"
  ssh_password     = var.ssh_password
  ssh_port         = 22
  ssh_timeout      = "6h"
  ssh_username     = var.ssh_username
  vm_name          = var.name
}

# source "virtualbox-iso" "debian" {
#   boot_command     = "${var.boot_command}"
#   boot_wait        = "${var.boot_wait}"
#   disk_size        = "${var.disk_size}"
#   guest_os_type    = "${var.guest_os_type_vbox}"
#   headless         = var.headless
#   http_directory   = "${var.http_directory}"
#   http_port_min    = "${var.http_port_min}"
#   http_port_max    = "${var.http_port_max}"
#   iso_checksum     = "${var.iso_checksum}"
#   iso_interface    = "sata"
#   iso_url          = "${var.iso_url}"
#   output_directory = "./builds/${var.name}-vbox"
#   shutdown_command = "echo 'packer'|sudo -S /sbin/halt -h -p"
#   ssh_password     = "${var.ssh_password}"
#   ssh_port         = 22
#   ssh_timeout      = "1h"
#   ssh_username     = "${var.ssh_username}"
#   vboxmanage = [
#     ["modifyvm", "{{ .Name }}", "--memory", "${var.ram}"],
#     ["modifyvm", "{{ .Name }}", "--cpus", "${var.cpu}"],
#     ["modifyvm", "{{ .Name }}", "--firmware", "EFI"],
#     ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]
#   ]
#   vm_name = "${var.name}-virtualbox"
# }

# source "hyperv-iso" "debian" {
#   boot_command          = "${var.boot_command_hyperv}"
#   boot_wait             = "${var.boot_wait}"
#   communicator          = "ssh"
#   cpus                  = "${var.cpu}"
#   disk_block_size       = "1"
#   disk_size             = "${var.disk_size}"
#   enable_dynamic_memory = "true"
#   enable_secure_boot    = false
#   generation            = 2
#   guest_additions_mode  = "disable"
#   headless              = var.headless
#   http_directory        = "${var.http_directory}"
#   iso_checksum          = "${var.iso_checksum}"
#   iso_url               = "${var.iso_url}"
#   memory                = "${var.ram}"
#   output_directory      = "./builds/${var.name}-hyperv"
#   shutdown_command      = "echo 'packer' | sudo -S shutdown -P now"
#   shutdown_timeout      = "2h"
#   ssh_password          = "${var.ssh_password}"
#   ssh_timeout           = "4h"
#   ssh_username          = "${var.ssh_username}"
#   switch_name           = "${var.switch_name}"
#   temp_path             = "."
#   vlan_id               = "${var.vlan_id}"
#   vm_name               = "${var.name}"
# }

build {
  sources = ["source.vmware-iso.debian", "source.qemu.debian"]
}
