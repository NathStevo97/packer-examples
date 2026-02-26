variable "boot_command" {
  type    = list(string)
  default = []
}

variable "boot_command_hv" {
  type    = list(string)
  default = []
}

variable "boot_wait" {
  type    = string
  default = "5s"
}

variable "box_basename" {
  type    = string
  default = ""
}

variable "build_directory" {
  type    = string
  default = ""
}

variable "cpus" {
  type    = string
  default = "2"
}

variable "disk_size" {
  type    = string
  default = "65536"
}

variable "git_revision" {
  type    = string
  default = "__unknown_git_revision__"
}

variable "guest_os_type_vmware" {
  type    = string
  default = "oraclelinux-64"
}

variable "guest_additions_url" {
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

variable "http_proxy" {
  type    = string
  default = "${env("http_proxy")}"
}

variable "https_proxy" {
  type    = string
  default = "${env("https_proxy")}"
}

variable "hyperv_generation" {
  type    = string
  default = ""
}

variable "hyperv_switch" {
  type    = string
  default = ""
}

variable "iso_checksum" {
  type    = string
  default = "8b756a95da40d70fabb784fb7d5484494720e97cccf9b5bdc51aed184bedc099"
}

variable "iso_path" {
  type    = string
  default = "https://yum.oracle.com/ISOS/OracleLinux/OL9/u7/x86_64/OracleLinux-R9-U7-x86_64-boot.iso"
}

variable "iso_url" {
  type    = string
  default = "https://yum.oracle.com/ISOS/OracleLinux/OL9/u7/x86_64/OracleLinux-R9-U7-x86_64-boot.iso"
}

variable "ks_path" {
  type    = string
  default = ""
}

variable "memory" {
  type    = string
  default = "2048"
}

variable "name" {
  type    = string
  default = ""
}

variable "qemu_display" {
  type    = string
  default = "none"
}

variable "ssh_password" {
  type    = string
  default = ""
}

variable "ssh_timeout" {
  type    = string
  default = "2h"
}

variable "ssh_username" {
  type    = string
  default = "vagrant"
}

variable "template" {
  type    = string
  default = "oraclelinux"
}

variable "switch_name" {
  type    = string
  default = ""
}

variable "version" {
  type    = string
  default = "TIMESTAMP"
}

variable "vlan_id" {
  type    = string
  default = ""
}

locals {
  build_timestamp = "${legacy_isotime("2019102650405")}"
}

source "vmware-iso" "oracle" {
  boot_command     = var.boot_command
  boot_wait        = var.boot_wait
  cpus             = var.cpus
  disk_size        = var.disk_size
  guest_os_type    = var.guest_os_type_vmware
  headless         = var.headless
  http_directory   = var.http_directory
  http_port_min    = var.http_port_min
  http_port_max    = var.http_port_max
  iso_checksum     = var.iso_checksum
  iso_urls         = [var.iso_path, var.iso_url]
  memory           = var.memory
  output_directory = "${var.build_directory}/packer-${var.template}-vmware"
  shutdown_command = "echo '${var.ssh_password}' | sudo -S /sbin/halt -h -p"
  ssh_password     = var.ssh_password
  ssh_port         = 22
  ssh_timeout      = var.ssh_timeout
  ssh_username     = var.ssh_username
  vm_name          = "${var.template}-vmware"
}

source "qemu" "oracle" {
  boot_command     = var.boot_command
  boot_wait        = "5s"
  cpus             = var.cpus
  disk_size        = var.disk_size
  disk_interface   = "virtio-scsi"
  headless         = var.headless
  http_directory   = var.http_directory
  http_port_min    = var.http_port_min
  http_port_max    = var.http_port_max
  iso_checksum     = var.iso_checksum
  iso_urls         = [var.iso_path, var.iso_url]
  memory           = var.memory
  output_directory = "./builds/${var.template}-qemu"
  qemuargs = [
    # ["-cpu", "Nehalem"], # set to "host" for linux-based packer execution
    ["-cpu", "host,+nx"], # set to "Nehalem" for windows-based packer execution
    ["-netdev", "user,hostfwd=tcp::{{ .SSHHostPort }}-:22,id=forward"],
    ["-device", "virtio-net,netdev=forward,id=net0"]
  ]
  shutdown_command = "echo '${var.ssh_password}'|sudo -S shutdown -P now"
  ssh_password     = var.ssh_password
  ssh_port         = 22
  ssh_timeout      = var.ssh_timeout
  ssh_username     = var.ssh_username
  vm_name          = "${var.template}-qemu"
}

/*
Deprecated Sources
*/

# DEPRECATED: VirtualBox - conflicts with KVM on Linux
# source "virtualbox-iso" "oracle" {
#   boot_command         = "${var.boot_command}"
#   boot_wait            = "${var.boot_wait}"
#   disk_size            = "${var.disk_size}"
#   guest_additions_mode = "disable"
#   #guest_additions_path = "c:/Windows/Temp/windows.iso"
#   guest_os_type        = "RedHat_64"
#   hard_drive_interface = "sata"
#   headless             = var.headless
#   http_directory       = "${var.http_directory}"
#   iso_checksum         = "${var.iso_checksum}"
#   iso_urls             = ["${var.iso_path}", "${var.iso_url}"]
#   iso_interface        = "sata"
#   output_directory     = "${var.build_directory}/packer-${var.template}-hv"
#   shutdown_command     = "echo 'vagrant'|sudo -S /sbin/halt -h -p"
#   ssh_password         = "${var.ssh_password}"
#   ssh_port             = 22
#   ssh_timeout          = "${var.ssh_timeout}"
#   ssh_username         = "${var.ssh_username}"
#   vboxmanage           = [["modifyvm", "{{ .Name }}", "--memory", "${var.memory}"], ["modifyvm", "{{ .Name }}", "--cpus", "${var.cpus}"], ["modifyvm", "{{ .Name }}", "--vram", "32"], ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]]
# }

# DEPRECATED: Hyper-V - Windows only
# source "hyperv-iso" "oracle" {
#   boot_command          = var.boot_command_hv
#   boot_wait             = "${var.boot_wait}"
#   communicator          = "ssh"
#   cpus                  = "${var.cpus}"
#   disk_block_size       = "1"
#   disk_size             = "${var.disk_size}"
#   enable_dynamic_memory = "true"
#   enable_secure_boot    = false
#   generation            = 2
#   guest_additions_mode  = "disable"
#   headless              = var.headless
#   http_directory        = "${var.http_directory}"
#   iso_checksum          = "${var.iso_checksum}"
#   iso_urls              = ["${var.iso_path}", "${var.iso_url}"]
#   memory                = "${var.memory}"
#   output_directory      = "${var.build_directory}/packer-${var.template}-hv"
#   shutdown_command      = "echo 'vagrant' | sudo -S shutdown -P now"
#   shutdown_timeout      = "30m"
#   ssh_password          = "${var.ssh_password}"
#   ssh_timeout           = "4h"
#   ssh_username          = "${var.ssh_username}"
#   switch_name           = "${var.switch_name}"
#   temp_path             = "."
#   vlan_id               = "${var.vlan_id}"
#   vm_name               = "${var.template}"
# }

build {
  sources = ["source.vmware-iso.oracle", "source.qemu.oracle"]
  /*
  provisioner "shell" {
    environment_vars  = ["HOME_DIR=/home/vagrant"]
    execute_command   = "echo 'vagrant' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
    scripts           = ["./Files/update.sh", "./Files/networking.sh", "./Files/cleanup.sh"]
  }
  */
  /*
  post-processor "vagrant" {
    output = "${var.build_directory}/${var.box_basename}.<no value>.box"
  }
  */
}
