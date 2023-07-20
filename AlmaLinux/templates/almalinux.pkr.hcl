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

variable "headless" {
  type    = string
  default = "true"
}

variable "iso_checksum" {
  type    = string
  default = "sha256:f501de55f92e59a3fcf4ad252fdfc4e02ee2ad013d2e1ec818bb38052bcb3c32"
}

variable "iso_url" {
  type    = string
  default = "https://repo.almalinux.org/almalinux/9.2/isos/x86_64/AlmaLinux-9.2-x86_64-boot.iso"
}

variable "name" {
  type    = string
  default = "almalinux"
}

variable "ram" {
  type    = string
  default = "2048"
}

variable "ssh_password" {
  type    = string
  default = "vagrant"
}

variable "ssh_username" {
  type    = string
  default = "vagrant"
}

variable "version" {
  type    = string
  default = "9"
}

source "vmware-iso" "almalinux-9" {
  boot_command     = ["e<down><down><end><bs><bs><bs><bs><bs>inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/almalinux9-kickstart.cfg<leftCtrlOn>x<leftCtrlOff>"]
  boot_wait        = "${var.boot_wait}"
  disk_size        = "${var.disk_size}"
  disk_type_id     = "0"
  guest_os_type    = "centos-64"
  headless         = false
  http_directory   = "./http"
  iso_checksum     = "${var.iso_checksum}"
  iso_url          = "${var.iso_url}"
  shutdown_command = "echo 'vagrant'|sudo -S /sbin/halt -h -p"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = 22
  ssh_timeout      = "30m"
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
  sources = ["source.vmware-iso.almalinux-9"]
}