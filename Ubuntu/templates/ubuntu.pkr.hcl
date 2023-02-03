variable "boot_command" {
  type = list(string)
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
  default = ""
}

variable "guest_additions_url" {
  type    = string
  default = ""
}

variable "guest_os_type_virtualbox" {
  type    = string
  default = ""
}

variable "guest_os_type_vmware" {
  type    = string
  default = ""
}

variable "headless" {
  type    = bool
  default = "false"
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

variable "iso_checksum" {
  type    = string
  default = ""
}

variable "iso_name" {
  type    = string
  default = ""
}

variable "iso_url" {
  type    = string
  default = ""
}

variable "memory" {
  type    = string
  default = ""
}

variable "mirror" {
  type    = string
  default = ""
}

variable "mirror_directory" {
  type    = string
  default = ""
}

variable "name" {
  type    = string
  default = ""
}

variable "no_proxy" {
  type    = string
  default = "${env("no_proxy")}"
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

variable "version" {
  type    = string
  default = "TIMESTAMP"
}
# The "legacy_isotime" function has been provided for backwards compatability, but we recommend switching to the timestamp and formatdate functions.

locals {
  build_timestamp   = "${legacy_isotime("20060102150405")}"
  scripts_directory = "./files"
}

source "vmware-iso" "ubuntu" {
  boot_command        = "${var.boot_command}"
  boot_wait           = "${var.boot_wait}"
  cpus                = "${var.cpus}"
  disk_size           = "${var.disk_size}"
  guest_os_type       = "${var.guest_os_type_vmware}"
  headless            = "${var.headless}"
  http_directory      = "${var.http_directory}"
  iso_checksum        = "${var.iso_checksum}"
  #iso_url             = "${var.mirror}/${var.mirror_directory}/${var.iso_name}"
  iso_url             = "${var.iso_url}"
  memory              = "${var.memory}"
  output_directory    = "${var.build_directory}/packer-${var.template}-vmware"
  shutdown_command    = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_handshake_attempts = 1000
  ssh_password        = "${var.ssh_password}"
  ssh_port            = 22
  ssh_timeout         = "${var.ssh_timeout}"
  ssh_username        = "${var.ssh_username}"
  tools_upload_flavor = "linux"
  vm_name             = "${var.template}"
  vmx_data = {
    "cpuid.coresPerSocket"    = "1"
    "ethernet0.pciSlotNumber" = "32"
  }
  vmx_remove_ethernet_interfaces = true
}

build {
  sources = ["source.vmware-iso.ubuntu"]

  provisioner "shell" {
    environment_vars  = ["HOME_DIR=/home/vagrant", "http_proxy=${var.http_proxy}", "https_proxy=${var.https_proxy}", "no_proxy=${var.no_proxy}"]
    execute_command   = "echo 'vagrant' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
    scripts           = ["${local.scripts_directory}/update.sh", "${local.scripts_directory}/sshd.sh", "${local.scripts_directory}/networking.sh", "${local.scripts_directory}/sudoers.sh", "${local.scripts_directory}/vagrant.sh", "${local.scripts_directory}/vmware.sh", "${local.scripts_directory}/cleanup.sh", "${local.scripts_directory}/minimize.sh"]
  }
  /*
  post-processor "vagrant" {
    output = "${var.build_directory}/${var.box_basename}.<no value>.box"
  }
  */
}
