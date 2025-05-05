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
  default = ""
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
  default = ""
}

variable "disk_size" {
  type    = string
  default = ""
}

variable "git_revision" {
  type    = string
  default = "__unknown_git_revision__"
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

variable "ks_path" {
  type    = string
  default = ""
}

variable "memory" {
  type    = string
  default = ""
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
  default = ""
}

variable "ssh_username" {
  type    = string
  default = ""
}

variable "template" {
  type    = string
  default = ""
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
  boot_command                   = "${var.boot_command}"
  boot_wait                      = "${var.boot_wait}"
  cpus                           = "${var.cpus}"
  disk_size                      = "${var.disk_size}"
  guest_os_type                  = "oraclelinux-64"
  headless                       = var.headless
  http_directory                 = "${var.http_directory}"
  iso_checksum                   = "${var.iso_checksum}"
  iso_urls                       = ["${var.iso_path}", "${var.iso_url}"]
  memory                         = "${var.memory}"
  output_directory               = "${var.build_directory}/packer-${var.template}-vmware"
  shutdown_command               = "echo 'vagrant' | sudo -S /sbin/halt -h -p"
  ssh_password                   = "${var.ssh_password}"
  ssh_port                       = 22
  ssh_timeout                    = "${var.ssh_timeout}"
  ssh_username                   = "${var.ssh_username}"
  tools_upload_flavor            = "linux"
  version                        = 19
  vm_name                        = "${var.template}"
  vmx_remove_ethernet_interfaces = true
}

source "hyperv-iso" "oracle" {
  boot_command          = var.boot_command_hv
  boot_wait             = "${var.boot_wait}"
  communicator          = "ssh"
  cpus                  = "${var.cpus}"
  disk_block_size       = "1"
  disk_size             = "${var.disk_size}"
  enable_dynamic_memory = "true"
  enable_secure_boot    = false
  generation            = 2
  guest_additions_mode  = "disable"
  headless              = var.headless
  http_directory        = "${var.http_directory}"
  iso_checksum          = "${var.iso_checksum}"
  iso_urls              = ["${var.iso_path}", "${var.iso_url}"]
  memory                = "${var.memory}"
  output_directory      = "${var.build_directory}/packer-${var.template}-hv"
  shutdown_command      = "echo 'vagrant' | sudo -S shutdown -P now"
  shutdown_timeout      = "30m"
  ssh_password          = "${var.ssh_password}"
  ssh_timeout           = "4h"
  ssh_username          = "${var.ssh_username}"
  switch_name           = "${var.switch_name}"
  temp_path             = "."
  vlan_id               = "${var.vlan_id}"
  vm_name               = "${var.template}"
}

source "virtualbox-iso" "oracle" {
  boot_command         = "${var.boot_command}"
  boot_wait            = "${var.boot_wait}"
  disk_size            = "${var.disk_size}"
  guest_additions_mode = "disable"
  #guest_additions_path = "c:/Windows/Temp/windows.iso"
  guest_os_type        = "RedHat_64"
  hard_drive_interface = "sata"
  headless             = var.headless
  http_directory       = "${var.http_directory}"
  iso_checksum         = "${var.iso_checksum}"
  iso_urls             = ["${var.iso_path}", "${var.iso_url}"]
  iso_interface        = "sata"
  output_directory     = "${var.build_directory}/packer-${var.template}-hv"
  shutdown_command     = "echo 'vagrant'|sudo -S /sbin/halt -h -p"
  ssh_password         = "${var.ssh_password}"
  ssh_port             = 22
  ssh_timeout          = "${var.ssh_timeout}"
  ssh_username         = "${var.ssh_username}"
  vboxmanage           = [["modifyvm", "{{ .Name }}", "--memory", "${var.memory}"], ["modifyvm", "{{ .Name }}", "--cpus", "${var.cpus}"], ["modifyvm", "{{ .Name }}", "--vram", "32"], ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]]
}

source "qemu" "oracle" {
  headless         = var.headless
  boot_command     = "${var.boot_command}"
  http_directory   = "${var.http_directory}"
  iso_checksum     = "${var.iso_checksum}"
  iso_urls         = ["${var.iso_path}", "${var.iso_url}"]
  output_directory = "../builds/${var.template}-qemu"
  shutdown_command = "echo 'vagrant'|sudo -S shutdown -P now"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = 22
  ssh_timeout      = "${var.ssh_timeout}"
  ssh_username     = "${var.ssh_username}"
  disk_size        = "${var.disk_size}"
  disk_interface   = "virtio-scsi"
  boot_wait        = "5s"
  memory           = "${var.memory}"
  cpus             = "${var.cpus}"
}

build {
  sources = ["source.vmware-iso.oracle", "source.hyperv-iso.oracle", "source.virtualbox-iso.oracle", "source.qemu.oracle"]
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
