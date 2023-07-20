variable "boot_wait" {
  type    = string
  default = "10s"
}

variable "config_file" {
  type    = string
  default = "preseed.cfg"
}

variable "cpu" {
  type    = string
  default = "4"
}

variable "disk_size" {
  type    = string
  default = "70000"
}

variable "headless" {
  type    = string
  default = "true"
}

variable "iso_checksum" {
  type    = string
  default = "61bd4ac9215a418924b48442ff84870082602b390b98037e5699e1fb0c6cb700"
}

variable "iso_url" {
  type    = string
  default = "https://deb.debian.org/debian/dists/bookworm/main/installer-amd64/current/images/netboot/mini.iso"
}

variable "name" {
  type    = string
  default = "debian-12"
}

variable "ram" {
  type    = string
  default = "4096"
}

variable "ssh_password" {
  type    = string
  default = "packer"
}

variable "ssh_username" {
  type    = string
  default = "packer"
}

source "vmware-iso" "debian" {
  boot_command = [
    "e<down><down><down><end> ",
    "auto=true priority=critical url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<f10>"
  ]
  boot_wait        = "${var.boot_wait}"
  disk_size        = "${var.disk_size}"
  disk_type_id     = "0"
  guest_os_type    = "debian-64"
  headless         = false
  http_directory   = "./http"
  iso_checksum     = "${var.iso_checksum}"
  iso_url          = "${var.iso_url}"
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

build {
  sources = ["source.vmware-iso.debian"]
}