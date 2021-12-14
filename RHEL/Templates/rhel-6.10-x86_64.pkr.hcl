
variable "arch" {
  type    = string
  default = "64"
}

variable "box_basename" {
  type    = string
  default = "rhel-6.10"
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
  type    = string
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
  default = "1e15f9202d2cdd4b2bdf9d6503a8543347f0cb8cc06ba9a0dfd2df4fdef5c727"
}

variable "iso_name" {
  type    = string
  default = "rhel-server-6.10-x86_64-dvd.iso"
}

variable "iso_path" {
  type    = string
  default = "../../ISOs/RHEL/rhel-server-6.10-x86_64-dvd.iso"
}

variable "iso_url" {
  type    = string
  default = "https://archive.org/download/rhel-server-6.10-x86_64-dvd/rhel-server-6.10-x86_64-dvd.iso"
}

variable "ks_path" {
  type    = string
  default = "6/ks.cfg"
}

variable "memory" {
  type    = string
  default = "1024"
}

variable "name" {
  type    = string
  default = "rhel-6.10"
}

variable "no_proxy" {
  type    = string
  default = "${env("no_proxy")}"
}

variable "template" {
  type    = string
  default = "rhel-6.10-x86_64"
}

variable "version" {
  type    = string
  default = "TIMESTAMP"
}
# The "legacy_isotime" function has been provided for backwards compatability, but we recommend switching to the timestamp and formatdate functions.

source "vmware-iso" "rhel6-vmware" {
  boot_command   = ["<tab> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-6.cfg<enter><wait>"]
  boot_wait      = "5s"
  cpus           = "${var.cpus}"
  disk_size      = "${var.disk_size}"
  guest_os_type  = "rhel6-64"
  headless       = "${var.headless}"
  http_directory = "../http/CentOS"
  iso_checksum   = "md5:5e131530e18bef7ff0a5d70bd2eb9c3d"
  iso_urls       = ["${var.iso_path}", "${var.iso_url}"]
  memory         = "${var.memory}"
  #output_directory    = "${var.build_directory}/packer-${var.template}-vmware"
  shutdown_command    = "echo 'vagrant' | sudo -S /sbin/halt -h -p"
  ssh_password        = "vagrant"
  ssh_port            = 22
  ssh_timeout         = "10000s"
  ssh_username        = "vagrant"
  tools_upload_flavor = "linux"
  vm_name             = "${var.template}"
  vmx_data = {
    "cpuid.coresPerSocket" = "1"
  }
  vmx_remove_ethernet_interfaces = true
}

build {
  sources = ["source.vmware-iso.rhel6-vmware"]

  provisioner "shell" {
    environment_vars  = ["HOME_DIR=/home/vagrant", "http_proxy=${var.http_proxy}", "https_proxy=${var.https_proxy}", "no_proxy=${var.no_proxy}"]
    execute_command   = "echo 'vagrant' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
    scripts = ["./Files/scripts/6/update.sh",
      "./Files/scripts/6/common/motd.sh",
      "./Files/scripts/6/common/sshd.sh",
      "./Files/scripts/6/networking.sh",
      "./Files/scripts/6/common/vagrant.sh",
    "./Files/scripts/6/common/virtualbox.sh"]
  }
}
