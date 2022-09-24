
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
  #default = "3d09d111f1664334ab7ae080a32deb32effe6803b1ade9dcc32c1e3eead79b3a"
  default = "ba9f15bb15d689978b10eda55c276020a4bc5b8ffc624d24a1cfc73017aff75c"
}

variable "iso_path" {
  type    = string
  #default = "../../ISOs/CentOS/CentOS-Stream-8-x86_64-latest-boot.iso"
  default = "../../ISOs/CentOS/CentOS-Stream-8-x86_64-latest-dvd1.iso"
}

variable "iso_url" {
  type    = string
  #default = "https://mirrors.edge.kernel.org/centos/8-stream/isos/x86_64/CentOS-Stream-8-x86_64-latest-boot.iso"
  default = "https://mirrors.edge.kernel.org/centos/8-stream/isos/x86_64/CentOS-Stream-8-x86_64-latest-dvd1.iso"
}

variable "memsize" {
  type    = string
  default = "1024"
}

variable "numvcpus" {
  type    = string
  default = "2"
}

variable "ssh_password" {
  type    = string
  default = "vagrant"
}

variable "ssh_username" {
  type    = string
  default = "vagrant"
}

variable "vm_name" {
  type    = string
  default = "centos-stream-8-x86_64"
}

source "virtualbox-iso" "centos8_vbox" {
  boot_command     = ["e<down><down><end><bs><bs><bs><bs><bs>inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/CentOS/ks-8-stream.cfg<leftCtrlOn>x<leftCtrlOff>"]
  boot_wait        = "${var.boot_wait}"
  disk_size        = "${var.disk_size}"
  guest_os_type    = "RedHat_64"
  headless         = true
  http_directory   = "../http"
  iso_checksum     = "${var.iso_checksum}"
  iso_interface    = "sata"
  iso_urls         = ["${var.iso_path}", "${var.iso_url}"]
  shutdown_command = "echo 'packer'|sudo -S /sbin/halt -h -p"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = 22
  ssh_timeout      = "30m"
  ssh_username     = "${var.ssh_username}"
  vboxmanage       = [["modifyvm", "{{ .Name }}", "--memory", "${var.memsize}"], ["modifyvm", "{{ .Name }}", "--cpus", "${var.numvcpus}"], ["modifyvm", "{{ .Name }}", "--firmware", "EFI"]]
  vm_name          = "${var.vm_name}"
}

source "vmware-iso" "centos8_vmware" {
  boot_command     = ["e<down><down><end><bs><bs><bs><bs><bs>inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/CentOS/ks-8-stream.cfg<leftCtrlOn>x<leftCtrlOff>"]
  boot_wait        = "${var.boot_wait}"
  disk_size        = "${var.disk_size}"
  disk_type_id     = "0"
  guest_os_type    = "centos-64"
  headless         = false
  http_directory   = "../http"
  iso_checksum     = "${var.iso_checksum}"
  iso_urls         = ["${var.iso_path}", "${var.iso_url}"]
  shutdown_command = "echo 'packer'|sudo -S /sbin/halt -h -p"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = 22
  ssh_timeout      = "2h"
  ssh_username     = "${var.ssh_username}"
  vm_name          = "${var.vm_name}"
  vmx_data = {
    firmware            = "efi"
    memsize             = "${var.memsize}"
    numvcpus            = "${var.numvcpus}"
    "virtualHW.version" = "14"
  }
}

build {
  sources = ["source.virtualbox-iso.centos8_vbox", "source.vmware-iso.centos8_vmware"]

  provisioner "shell" {
    execute_command = "echo 'packer'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    inline          = ["dnf -y update", "dnf -y install python3", "alternatives --set python /usr/bin/python3"]
  }
  /*  
  provisioner "ansible-local" {
    playbook_file = "scripts/setup.yml"
  }

  provisioner "shell" {
    execute_command = "echo 'packer'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts         = ["scripts/cleanup.sh"]
  }
  */
}
