variable "boot_command" {
  type    = list(string)
  default = []
}

variable "boot_command_hyperv" {
  type    = list(string)
  default = []
}

variable "boot_wait" {
  type    = string
  default = "5s"
}

variable "config_file" {
  type    = string
  default = ""
}

variable "disk_size" {
  type    = string
  default = "40960"
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
  default = "96c9d96c33ebacc8e909dcf8abf067b6bb30588c0c940a9c21bb9b83f3c99868"
}

variable "iso_url" {
  type    = string
  default = "https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.8-x86_64-boot.iso"
}

variable "memsize" {
  type    = string
  default = "2048"
}

variable "numvcpus" {
  type    = string
  default = "2"
}

variable "ssh_password" {
  type    = string
  default = "packer"
}

variable "ssh_username" {
  type    = string
  default = "packer"
}

variable "switch_name" {
  type    = string
  default = ""
}

variable "vlan_id" {
  type    = string
  default = ""
}

variable "vm_name" {
  type    = string
  default = "Rocky-8.8-x86_64"
}

source "virtualbox-iso" "rockylinux" {
  boot_command     = "${var.boot_command}"
  boot_wait        = "${var.boot_wait}"
  disk_size        = "${var.disk_size}"
  guest_os_type    = "${var.guest_os_type_vbox}"
  headless         = var.headless
  http_directory   = "${var.http_directory}"
  iso_checksum     = "${var.iso_checksum}"
  iso_interface    = "sata"
  iso_url          = "${var.iso_url}"
  output_directory = "../builds/${var.vm_name}-vbox"
  shutdown_command = "echo 'packer'|sudo -S /sbin/halt -h -p"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = 22
  ssh_timeout      = "30m"
  ssh_username     = "${var.ssh_username}"
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--memory", "${var.memsize}"],
    ["modifyvm", "{{ .Name }}", "--cpus", "${var.numvcpus}"],
    ["modifyvm", "{{ .Name }}", "--firmware", "EFI"],
    ["modifyvm", "{{ .Name }}", "--nat-localhostreachable1", "on"]
  ]
  vm_name = "${var.vm_name}-virtualbox"
}

source "vmware-iso" "rockylinux" {
  boot_command     = "${var.boot_command}"
  boot_wait        = "${var.boot_wait}"
  cpus            = "${var.numvcpus}"
  disk_size        = "${var.disk_size}"
  disk_type_id     = "0"
  firmware         = "efi"
  guest_os_type    = "${var.guest_os_type_vmware}"
  headless         = var.headless
  http_directory   = "${var.http_directory}"
  iso_checksum     = "${var.iso_checksum}"
  iso_url          = "${var.iso_url}"
  memory             = "${var.memsize}"
  output_directory = "../builds/${var.vm_name}-vmware"
  shutdown_command = "echo 'packer'|sudo -S /sbin/halt -h -p"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = 22
  ssh_timeout      = "30m"
  ssh_username     = "${var.ssh_username}"
  version          = "14"
  vm_name          = "${var.vm_name}-vmware"
}

source "hyperv-iso" "rockylinux" {
  boot_command          = "${var.boot_command_hyperv}"
  boot_wait             = "${var.boot_wait}"
  communicator          = "ssh"
  cpus                  = "${var.numvcpus}"
  disk_block_size       = "1"
  disk_size             = "${var.disk_size}"
  enable_dynamic_memory = "true"
  enable_secure_boot    = false
  generation            = 2
  guest_additions_mode  = "disable"
  headless              = var.headless
  http_directory        = "${var.http_directory}"
  iso_checksum          = "sha256:${var.iso_checksum}"
  iso_url               = "${var.iso_url}"
  memory                = "${var.memsize}"
  output_directory      = "../builds/${var.vm_name}-hyperv"
  shutdown_command      = "echo 'password' | sudo -S shutdown -P now"
  shutdown_timeout      = "30m"
  ssh_password          = "${var.ssh_password}"
  ssh_timeout           = "4h"
  ssh_username          = "${var.ssh_username}"
  switch_name           = "${var.switch_name}"
  temp_path             = "."
  vlan_id               = "${var.vlan_id}"
  vm_name               = "${var.vm_name}"
}

build {
  sources = ["source.virtualbox-iso.rockylinux", "source.vmware-iso.rockylinux", "source.hyperv-iso.rockylinux"]

  provisioner "shell" {
    execute_command = "echo 'packer'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    inline          = ["dnf -y update", "dnf -y install python3", "alternatives --set python /usr/bin/python3", "python3 -m pip install -U pip", "pip3 install ansible"]
  }
}
