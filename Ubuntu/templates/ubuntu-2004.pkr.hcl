
variable "box_basename" {
  type    = string
  default = "ubuntu-20.04"
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

variable "iso_checksum" {
  type    = string
  default = "sha256:5035be37a7e9abbdc09f0d257f3e33416c1a0fb322ba860d42d74aa75c3468d4"
}

variable "iso_name" {
  type    = string
  default = "ubuntu-20.04.5-live-server-amd64.iso"
}

variable "memory" {
  type    = string
  default = "1024"
}

variable "mirror" {
  type    = string
  default = "https://releases.ubuntu.com"
}

variable "mirror_directory" {
  type    = string
  default = "focal"
}

variable "name" {
  type    = string
  default = "ubuntu-20.04"
}

variable "no_proxy" {
  type    = string
  default = "${env("no_proxy")}"
}

variable "preseed_path" {
  type    = string
  default = "preseed.cfg"
}

variable "qemu_display" {
  type    = string
  default = "none"
}

variable "template" {
  type    = string
  default = "ubuntu-20.04-amd64"
}

variable "version" {
  type    = string
  default = "TIMESTAMP"
}
# The "legacy_isotime" function has been provided for backwards compatability, but we recommend switching to the timestamp and formatdate functions.

locals {
  build_timestamp = "${legacy_isotime("20060102150405")}"
  http_directory  = "../http/Ubuntu"
  scripts_directory = "./files"
}

source "vmware-iso" "ubuntu" {
  boot_command        = [" <wait>", " <wait>", " <wait>", " <wait>", " <wait>", "<esc><wait>", "<f6><wait>", "<esc><wait>", "<bs><bs><bs><bs><wait>", " autoinstall<wait5>", " ds=nocloud-net<wait5>", ";s=http://<wait5>{{ .HTTPIP }}<wait5>:{{ .HTTPPort }}/<wait5>", " ---<wait5>", "<enter><wait5>"]
  boot_wait           = "5s"
  cpus                = "${var.cpus}"
  disk_size           = "${var.disk_size}"
  guest_os_type       = "ubuntu64Guest"
  headless            = "${var.headless}"
  http_directory      = "${local.http_directory}"
  iso_checksum        = "${var.iso_checksum}"
  iso_url             = "${var.mirror}/${var.mirror_directory}/${var.iso_name}"
  memory              = "${var.memory}"
  output_directory    = "${var.build_directory}/packer-${var.template}-vmware"
  shutdown_command    = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_password        = "vagrant"
  ssh_port            = 22
  ssh_timeout         = "10000s"
  ssh_username        = "vagrant"
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
