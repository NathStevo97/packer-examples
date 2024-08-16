variable "boot_command" {
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
  boot_command        = "${var.boot_command}"
  boot_wait           = "${var.boot_wait}"
  disk_size           = "${var.disk_size}"
  guest_os_type       = "oraclelinux-64"
  headless            = var.headless
  http_directory      = "${var.http_directory}"
  iso_checksum        = "${var.iso_checksum}"
  iso_urls            = ["${var.iso_url}", "${var.iso_path}"]
  output_directory    = "${var.build_directory}/packer-${var.template}-vmware"
  shutdown_command    = "echo 'vagrant' | sudo -S /sbin/halt -h -p"
  ssh_password        = "${var.ssh_password}"
  ssh_port            = 22
  ssh_timeout         = "${var.ssh_timeout}"
  ssh_username        = "${var.ssh_username}"
  tools_upload_flavor = "linux"
  version             = 19
  vm_name             = "${var.template}"
  vmx_data = {
    memsize             = "${var.memory}"
    numvcpus            = "${var.cpus}"
    "scsi0.virtualDev"  = "lsisas1068"
    "virtualHW.version" = "14"
  }
  vmx_remove_ethernet_interfaces = true
}

source "hyperv-iso" "oracle" {
  boot_command          = ["c  setparams 'kickstart' <enter> linuxefi /images/pxeboot/vmlinuz inst.stage2=hd:LABEL=OL-9-0-0-BaseOS-x86_64 inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-9.cfg<enter> initrdefi /images/pxeboot/initrd.img<enter> boot<enter>"]
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
  iso_urls            = ["${var.iso_url}", "${var.iso_path}"]
  memory                = "${var.memory}"
  output_directory    = "${var.build_directory}/packer-${var.template}-hv"
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

build {
  sources = ["source.vmware-iso.oracle", "source.hyperv-iso.oracle"]

  provisioner "shell" {
    environment_vars  = ["HOME_DIR=/home/vagrant"]
    execute_command   = "echo 'vagrant' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
    scripts           = ["./Files/update.sh", "./Files/networking.sh", "./Files/cleanup.sh"]
  }
  /*
  post-processor "vagrant" {
    output = "${var.build_directory}/${var.box_basename}.<no value>.box"
  }
  */
}
