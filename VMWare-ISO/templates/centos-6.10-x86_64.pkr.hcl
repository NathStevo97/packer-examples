
variable "box_basename" {
  type    = string
  default = "centos-6.10"
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
  default = "a68e46970678d4d297d46086ae2efdd3e994322d6d862ff51dcce25a0759e41c"
}

variable "iso_name" {
  type    = string
  default = "CentOS-6.10-x86_64-bin-DVD1.iso"
}

variable "memory" {
  type    = string
  default = "1024"
}

variable "mirror" {
  type    = string
  default = "http://mirrors.kernel.org/centos"
}

variable "mirror_directory" {
  type    = string
  default = "6.10/isos/x86_64"
}

variable "name" {
  type    = string
  default = "centos-6.10"
}

variable "no_proxy" {
  type    = string
  default = "${env("no_proxy")}"
}

variable "template" {
  type    = string
  default = "centos-6.10-x86_64"
}

source "vmware-iso" "centos6" {
  boot_command        = ["<up><wait><tab> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-6.cfg<enter><wait>"]
  boot_wait           = "5s"
  cpus                = "${var.cpus}"
  disk_size           = "${var.disk_size}"
  guest_os_type       = "centos-64"
  headless            = "${var.headless}"
  http_directory      = "../scripts/http/CentOS"
  iso_checksum        = "md5:8ffcc065c3110e6fa0144cb85e4bb4bc"
  iso_url             = "../../../../ISOs/CentOS/CentOS-6.10-x86_64-bin-DVD1.iso"
  memory              = "${var.memory}"
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
  sources = ["source.vmware-iso.centos6"]

  provisioner "shell" {
    environment_vars  = ["HOME_DIR=/home/vagrant", "http_proxy=${var.http_proxy}", "https_proxy=${var.https_proxy}", "no_proxy=${var.no_proxy}"]
    execute_command   = "echo 'vagrant' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
    scripts           = ["../scripts/CentOS/6/update.sh", 
    "../scripts/CentOS/6/common/motd.sh", 
    "../scripts/CentOS/6/common/sshd.sh", 
    "../scripts/CentOS/6/networking.sh", 
    "../scripts/CentOS/6/common/vagrant.sh", 
    "../scripts/CentOS/6/common/virtualbox.sh", 
    "../scripts/CentOS/6/common/vmware.sh", 
    "../scripts/CentOS/6/common/parallels.sh", 
    "../scripts/CentOS/6/cleanup.sh", 
    "../scripts/CentOS/6/common/minimize.sh"]
  }
}
