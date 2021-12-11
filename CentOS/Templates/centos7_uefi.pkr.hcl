
variable "boot_wait" {
  type    = string
  default = "5s"
}

variable "disk_size" {
  type    = string
  default = "40960"
}

variable "iso_checksum" {
  type    = string
  default = "b79079ad71cc3c5ceb3561fff348a1b67ee37f71f4cddfec09480d4589c191d6"
}

variable "iso_url" {
  type    = string
  default = "http://miroir.univ-paris13.fr/centos/7.9.2009/isos/x86_64/CentOS-7-x86_64-NetInstall-2009.iso"
}

variable "memsize" {
  type    = string
  default = "1024"
}

variable "numvcpus" {
  type    = string
  default = "1"
}

variable "ssh_password" {
  type    = string
  default = "packer"
}

variable "ssh_username" {
  type    = string
  default = "packer"
}

variable "vm_name" {
  type    = string
  default = "CentOS-7-x86_64-2009"
}

source "vmware-iso" "centos7" {
  #boot_command     = ["e<down><down><end><bs><bs><bs><bs><bs>text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-7.cfg<leftCtrlOn>x<leftCtrlOff>"]
  boot_command     = ["<tab> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-7.cfg<enter><wait>"]
  boot_wait        = "${var.boot_wait}"
  disk_size        = "${var.disk_size}"
  disk_type_id     = "0"
  guest_os_type    = "centos-64"
  headless         = false
  http_directory   = "../http/CentOS"
  iso_checksum     = "${var.iso_checksum}"
  iso_url          = "${var.iso_url}"
  shutdown_command = "echo 'packer'|sudo -S /sbin/halt -h -p"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = 22
  ssh_timeout      = "30m"
  ssh_username     = "${var.ssh_username}"
  vm_name          = "${var.vm_name}"
  vmx_data = {
    #firmware            = "efi"
    memsize             = "${var.memsize}"
    numvcpus            = "${var.numvcpus}"
    "virtualHW.version" = "14"
  }
}

build {
  sources = ["source.vmware-iso.centos7"]
  /*  
  provisioner "shell" {
    execute_command = "echo 'packer'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    inline          = ["yum -y install epel-release", "yum -y update", "yum -y install ansible"]
  }

  provisioner "ansible-local" {
    playbook_file = "./Files/scripts/setup.yml"
  }

  provisioner "shell" {
    execute_command = "echo 'packer'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts         = ["./Files/scripts/cleanup.sh"]
  }
  */
}
