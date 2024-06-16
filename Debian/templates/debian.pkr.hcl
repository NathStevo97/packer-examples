variable "boot_wait" {
  type    = string
  default = "10s"
}

variable "boot_command" {
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

source "vmware-iso" "debian" {
  boot_command     = "${var.boot_command}"
  boot_wait        = "${var.boot_wait}"
  disk_size        = "${var.disk_size}"
  disk_type_id     = "0"
  guest_os_type    = "${var.guest_os_type_vmware}"
  headless         = var.headless
  http_directory   = "${var.http_directory}"
  iso_checksum     = "${var.iso_checksum}"
  iso_url          = "${var.iso_url}"
  output_directory = "../builds/${var.name}-vmware"
  shutdown_command = "echo 'packer'|sudo -S /sbin/halt -h -p"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = 22
  ssh_timeout      = "1h"
  ssh_username     = "${var.ssh_username}"
  vm_name          = "${var.name}-vmware"
  vmx_data = {
    firmware            = "efi"
    memsize             = "${var.ram}"
    numvcpus            = "${var.cpu}"
    "virtualHW.version" = "14"
  }
}

source "virtualbox-iso" "debian" {
  boot_command     = "${var.boot_command}"
  boot_wait        = "${var.boot_wait}"
  disk_size        = "${var.disk_size}"
  guest_os_type    = "${var.guest_os_type_vbox}"
  headless         = var.headless
  http_directory   = "${var.http_directory}"
  iso_checksum     = "${var.iso_checksum}"
  iso_interface    = "sata"
  iso_url          = "${var.iso_url}"
  output_directory = "../builds/${var.name}-vbox"
  shutdown_command = "echo 'packer'|sudo -S /sbin/halt -h -p"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = 22
  ssh_timeout      = "1h"
  ssh_username     = "${var.ssh_username}"
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--memory", "${var.ram}"],
    ["modifyvm", "{{ .Name }}", "--cpus", "${var.cpu}"],
    ["modifyvm", "{{ .Name }}", "--firmware", "EFI"],
    ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]
  ]
  vm_name = "${var.name}-virtualbox"
}

build {
  sources = ["source.vmware-iso.debian", "source.virtualbox-iso.debian"]
}