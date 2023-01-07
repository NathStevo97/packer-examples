
variable "box_basename" {
  type    = string
  default = "oracle-9.0"
}

variable "build_directory" {
  type    = string
  default = "../../builds"
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

variable "guest_additions_url" {
  type    = string
  default = ""
}

variable "headless" {
  type    = bool
  default = "false"
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
  default = "1"
}

variable "hyperv_switch" {
  type    = string
  default = "bento"
}

variable "iso_checksum" {
  type    = string
  default = "5275d4db7355fb217381a49cdde2ffbb"
}

variable "iso_path" {
  type    = string
  default = "../../ISOs/Oracle Linux/OracleLinux-R9-U0-x86_64-dvd.iso"
}

variable "iso_url" {
  type    = string
  default = "https://yum.oracle.com/ISOS/OracleLinux/OL9/u0/x86_64/OracleLinux-R9-U0-x86_64-dvd.iso"
}

variable "ks_path" {
  type    = string
  default = "ks-9.cfg"
}

variable "memory" {
  type    = string
  default = "1024"
}

variable "name" {
  type    = string
  default = "oracle-9.0"
}

variable "qemu_display" {
  type    = string
  default = "none"
}

variable "template" {
  type    = string
  default = "oracle-9.0-x86_64"
}

variable "version" {
  type    = string
  default = "TIMESTAMP"
}
# The "legacy_isotime" function has been provided for backwards compatability, but we recommend switching to the timestamp and formatdate functions.

locals {
  boot_command    = ["<up><wait><tab> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${var.ks_path}<enter><wait>"]
  build_timestamp = "${legacy_isotime("2019102650405")}"
  #http_directory  = "${path.root}/http"
  http_directory = "./http"
}

source "hyperv-iso" "oracle9" {
  boot_command         = ["<wait5><up><wait5><tab> text ks=hd:fd0:/ks-9.cfg<enter><wait5><esc>"]
  boot_wait            = "5s"
  cpus                 = "${var.cpus}"
  disk_size            = "${var.disk_size}"
  floppy_files         = ["${local.http_directory}/${var.ks_path}"]
  generation           = "${var.hyperv_generation}"
  guest_additions_mode = "disable"
  http_directory       = "../http/oracle"
  iso_checksum         = "${var.iso_checksum}"
  iso_urls             = ["${var.iso_path}", "${var.iso_url}"]
  memory               = "${var.memory}"
  output_directory     = "${var.build_directory}/packer-${var.template}-hyperv"
  shutdown_command     = "echo 'vagrant' | sudo -S /sbin/halt -h -p"
  ssh_password         = "vagrant"
  ssh_port             = 22
  ssh_timeout          = "10000s"
  ssh_username         = "vagrant"
  switch_name          = "${var.hyperv_switch}"
  vm_name              = "${var.template}"
}

source "virtualbox-iso" "oracle9" {
  boot_command            = "${local.boot_command}"
  boot_wait               = "120s"
  cpus                    = "${var.cpus}"
  disk_size               = "${var.disk_size}"
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_additions_url     = "${var.guest_additions_url}"
  guest_os_type           = "Oracle_64"
  hard_drive_interface    = "sata"
  headless                = "${var.headless}"
  http_directory          = "../http/oracle"
  iso_checksum            = "${var.iso_checksum}"
  iso_url                 = "${var.iso_url}"
  memory                  = "${var.memory}"
  output_directory        = "${var.build_directory}/packer-${var.template}-virtualbox"
  shutdown_command        = "echo 'vagrant' | sudo -S /sbin/halt -h -p"
  ssh_password            = "vagrant"
  ssh_port                = 22
  ssh_timeout             = "10000s"
  ssh_username            = "vagrant"
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "${var.template}"
}

source "vmware-iso" "oracle9" {
  boot_command        = ["<tab><wait2m> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-9.cfg<enter><wait>"]
  boot_wait           = "5s"
  disk_size           = "${var.disk_size}"
  guest_os_type       = "oraclelinux-64"
  headless            = "${var.headless}"
  http_directory      = "../http/oracle"
  iso_checksum        = "${var.iso_checksum}"
  iso_url             = "${var.iso_url}"
  output_directory    = "${var.build_directory}/packer-${var.template}-vmware"
  shutdown_command    = "echo 'vagrant' | sudo -S /sbin/halt -h -p"
  ssh_password        = "vagrant"
  ssh_port            = 22
  ssh_timeout         = "10000s"
  ssh_username        = "vagrant"
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

build {
  sources = ["source.hyperv-iso.oracle9", "source.virtualbox-iso.oracle9", "source.vmware-iso.oracle9"]

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
